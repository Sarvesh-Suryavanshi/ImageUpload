//
//  PDUserVO.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "PDUserVO.h"

NSString * const PDAddressKey   = @"address";
NSString * const PDUserNameKey  = @"name";
NSString * const PDImageKey     = @"image";
NSString * const PDIDKey        = @"id";

@interface PDUserVO ()
{
    NSString * _id;
    NSString * _addess;
    NSString * _image;
    NSString * _name;
    
}
@end

@implementation PDUserVO

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)information
{
    self = [super init];
    if (self)
    {
        if (information)
        {
            NSString *name = [information valueForKey:PDUserNameKey];
            NSString *address = [information valueForKey:PDAddressKey];
            NSString *image = [information valueForKey:PDImageKey];
            NSString *idString = [information valueForKey:PDIDKey];
            
            _name = name?name:@"";
            _addess = address?address:@"";
            _image = image?image:@"";
            _id = idString?idString:@"";
        }
    }
    return self;
}

#pragma mark - Getter Method

- (NSString *)getUserName
{
    return _name;
}

- (NSString *)getAddress
{
    return _addess;
}

- (NSString *)getImage
{
    return _image;
}

- (NSString *)getID
{
    return _id;
}

@end
