//
//  PDUserVO.h
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDUserVO : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)information;
- (NSString *)getUserName;
- (NSString *)getAddress;
- (NSString *)getImage;
- (NSString *)getID;
@end
