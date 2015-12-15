//
//  WebServiceManager.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "WebServiceManager.h"


@interface WebServiceManager () <NSURLSessionDelegate,NSURLSessionDataDelegate>
{
    id <WebServiceResponseDelegate> _responseVO;
    __weak id <WebServiceManagerCallbackDelegate> _listener;
    NSURLSession *session;
}
@end

@implementation WebServiceManager

+ (instancetype)sharedInstance
{
    static WebServiceManager *manager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[WebServiceManager alloc] init];
    });
    return manager;
}


- (void)callGetWebServiceWithAPIURL:(NSString *)apiURL responseVO:(id <WebServiceResponseDelegate>)responseVO andListener:(__weak id <WebServiceManagerCallbackDelegate>)listener
{
    _responseVO = responseVO;
    _listener = listener;
    
    NSURL *apiURLSchema = [[NSURL alloc] initWithString:apiURL];
    
    session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:apiURLSchema];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dispatchData:data];
        });
    }];
    [dataTask resume];
}


- (void)uploadImage:(UIImage *)image withAPIUrl:(NSString *)apiURL parameters:(NSDictionary *)parameters responseVO:(id <WebServiceResponseDelegate>)responseVO andListener:(__weak id <WebServiceManagerCallbackDelegate>) listener
{
    
    _listener = listener;
    _responseVO = responseVO;

    NSURL *url = [NSURL URLWithString:apiURL];
   
    // configure the request

    NSString *boundary = [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    // set content type
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // create body
    
    NSData *httpBody = [self createBodyWithBoundary:boundary parameters:parameters image:image fieldName:@"ProfilePic"];
    
    NSURLSession *uploadSession = [NSURLSession sharedSession];  // use sharedSession or create your own
    
    NSURLSessionTask *task = [uploadSession uploadTaskWithRequest:request fromData:httpBody completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dispatchData:data];
        });
    }];
    [task resume];
    
}


- (NSData *)createBodyWithBoundary:(NSString *)boundary
                        parameters:(NSDictionary *)parameters
                             image:(UIImage *)image
                         fieldName:(NSString *)fieldName
{
    NSMutableData *httpBody = [NSMutableData data];
    
    // add params (all params are strings)
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    // add image data
    
    NSString *mimetype = @"image/jpeg";
    NSString *filename = @"Pic";
    
    CGSize optimizationSize = CGSizeMake(100, 100);
    UIImage *optimizedImage = [self imageResize:image andResizeTo:optimizationSize];
    NSData *imgData = [NSData dataWithData:UIImageJPEGRepresentation(optimizedImage,0.25)];
    
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimetype] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:imgData];
        [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return httpBody;
}




#pragma mark - Helper Methods

- (UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding withString:(NSString *) str
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                         (CFStringRef)str,
                                                                                         NULL,
                                                                                         (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",                                                               CFStringConvertNSStringEncodingToEncoding(encoding)));
}
                                  
- (void)dispatchData:(NSData *)data
{
    if (_responseVO && [_responseVO respondsToSelector:@selector(processResponse:)])
    {
        BOOL state = [_responseVO processResponse:data];
        [self processState:state];
    }
}

- (void)processState:(BOOL)state
{
    state?[self sendSuccessCallback]:[self sendFailureCallback];
}

- (void)sendSuccessCallback
{
    if (_listener && [_listener respondsToSelector:@selector(webServiceSuccessForResponseVO:)])
    {
        [_listener webServiceSuccessForResponseVO:_responseVO];
    }
}

- (void)sendFailureCallback
{
    if (_listener && [_listener respondsToSelector:@selector(webServiceFailureForResponseVO:)])
    {
        [_listener webServiceFailureForResponseVO:_responseVO];
    }
}

@end
