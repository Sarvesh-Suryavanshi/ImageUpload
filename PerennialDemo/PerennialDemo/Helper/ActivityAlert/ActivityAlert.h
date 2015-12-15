


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ActivityAlert;
@interface ActivityAlert:UIView <UIAlertViewDelegate>

+ (void)showActivity;
+ (void)dismissActivityAlert;
- (void)startAnimationWithRevolutions:(float)revPerSecond forTime:(float)time;
+ (void)showCircularProgressiveIndicator;
+ (void)showDownloadingIndicator;
+ (void)hideDownloadingIndicator;

@end
