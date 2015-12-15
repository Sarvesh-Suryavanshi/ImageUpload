//
//  PDUploadTaskResponseVO.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 29/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "PDUploadTaskResponseVO.h"

NSString * const PDUploadStatuskey = @"status";

@implementation PDUploadTaskResponseVO

- (BOOL)processResponse:(NSData *)response;
{
    if (response)
    {
        NSError *error;
        id responseObject = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
        {
            return [self processDictionary:responseObject];
        }
    }
    return NO;
}

- (BOOL)processDictionary:(NSDictionary *)dictionary
{
    if (dictionary)
    {
        if ([[dictionary valueForKey:PDUploadStatuskey] integerValue])
        {
            return YES;
        }
    }
    return NO;
}


@end
