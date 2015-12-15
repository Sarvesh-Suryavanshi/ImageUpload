//
//  WebServiceResponseDelegate.h
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceResponseDelegate <NSObject>
@required
- (BOOL)processResponse:(NSData *)response;
@end
