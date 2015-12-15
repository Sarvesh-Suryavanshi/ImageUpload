//
//  PDUserResponseVO.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "PDUserResponseVO.h"
#import "PDUserVO.h"

NSString * const PDDataKey        = @"data";
NSString * const PDUserListKey    = @"userlist";
NSInteger const VOInsertionIndex  = 0.0f;

@interface PDUserResponseVO ()
{
    NSMutableArray *_items;
}
@end

@implementation PDUserResponseVO

#pragma mark - WebService Response Delegate

- (BOOL)processResponse:(NSData *)response
{
    if (response)
    {
        NSError *error;
        id responseValue = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
        if (responseValue && [responseValue isKindOfClass:[NSDictionary class]])
        {
            return [self processDictionary:responseValue];
        }
    }
    return NO;
}

#pragma mark - Helper Methods

- (BOOL)processDictionary:(NSDictionary *)dictionary
{
    NSDictionary *data = [dictionary valueForKey:PDDataKey];
    _items = [[NSMutableArray alloc] init];

    if (data)
    {
        NSArray *userlist = [data valueForKey:PDUserListKey];
        
        if (userlist && userlist.count>0)
        {
            _items = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dataDictionary in userlist)
            {
                PDUserVO *userVO = [[PDUserVO alloc] initWithDictionary:dataDictionary];
                [_items insertObject:userVO atIndex:VOInsertionIndex];
            }
            return YES;
        }
    }
    return NO;
}

#pragma mark - Getter Method

- (NSArray *)getItems
{
    return _items;
}

@end

