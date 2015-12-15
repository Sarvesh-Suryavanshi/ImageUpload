

#import "ActivityAlert.h"
#import "AppDelegate.h"


static ActivityAlert *initObj = nil;
@implementation ActivityAlert

ActivityAlert *vw ;

UIImageView *view;
UIActivityIndicatorView *view_indicatorDownload;

- (void) show
{   
    
    AppDelegate *appDelegate = nil;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [initObj removeFromSuperview];
    [appDelegate.window insertSubview:initObj atIndex:[appDelegate.window.subviews count]];

     self.frame = [[UIScreen mainScreen] bounds];
    vw.frame = self.frame;
    vw.center = self.center;
    vw.bounds = self.bounds;
    
}

- (void)startAnimationWithRevolutions:(float)revPerSecond forTime:(float)time
{
    view.userInteractionEnabled = FALSE;
    float totalRevolutions = 100;
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:time] forKey:kCATransactionAnimationDuration];

    CABasicAnimation* spinAnimation = [CABasicAnimation
                                       animationWithKeyPath:@"transform.rotation"];
    CGAffineTransform transform = view.transform;
    float fromAngle = atan2(transform.b, transform.a);
    float toAngle = fromAngle + (totalRevolutions*2*M_PI);
    spinAnimation.fromValue = [NSNumber numberWithFloat:fromAngle];
    spinAnimation.toValue = [NSNumber numberWithFloat:toAngle];
    spinAnimation.repeatCount = 0;
    spinAnimation.removedOnCompletion = NO;
    spinAnimation.delegate = self;
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:
                                    kCAMediaTimingFunctionEaseOut];
    [view.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
    [CATransaction commit];
}

+ (void) showCircularProgressiveIndicator
{
	view = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 30, 30)];
	view.image=[UIImage imageNamed:@"spinner.png"];
	[[AppDelegate getInstance].window addSubview:view];
	
	[UIView animateWithDuration:0.7 animations:^{
		view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
	}];


	view.userInteractionEnabled = FALSE;
    float totalRevolutions = 200;
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:200] forKey:kCATransactionAnimationDuration];

    CABasicAnimation* spinAnimation = [CABasicAnimation
                                       animationWithKeyPath:@"transform.rotation"];
    CGAffineTransform transform = view.transform;
    float fromAngle = atan2(transform.b, transform.a);
    float toAngle = fromAngle + (totalRevolutions*2*M_PI);
    spinAnimation.fromValue = [NSNumber numberWithFloat:fromAngle];
    spinAnimation.toValue = [NSNumber numberWithFloat:toAngle];
    spinAnimation.repeatCount = 0;
    spinAnimation.removedOnCompletion = NO;
    spinAnimation.delegate = self;
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:
                                    kCAMediaTimingFunctionEaseOut];
    [view.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
    [CATransaction commit];



    
}

+ (void) showActivity
{
    dispatch_async(dispatch_get_main_queue(), ^{
        @synchronized(self) {
            if (initObj == nil)
            {
                
                AppDelegate *appDelegate = nil;
                appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                vw = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                vw.alpha = 0.6f;
                vw.backgroundColor = [UIColor clearColor];
                
                
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
                [bgView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
                bgView.layer.cornerRadius = 7.0f;
                bgView.layer.borderColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.8].CGColor;
                bgView.layer.borderWidth = 2.0f;
                bgView.center = vw.center;
                [vw addSubview:bgView];
                
                UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                activity.tag = 103;
                [activity startAnimating];
                [vw addSubview:activity];
                activity.center = CGPointMake(bgView.frame.size.width/2.0f, bgView.frame.size.height/2.0f);
                
                [bgView addSubview:activity];
                activity =nil;
                bgView =nil;;
                
                initObj = vw;
                [appDelegate.window addSubview:vw];
            }
            
        }
        
        [initObj performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    });
   
}

- (void) willPresentAlertView:(UIAlertView *)alertView
{
    UIActivityIndicatorView *activityView = nil;
    activityView = (UIActivityIndicatorView *)[alertView viewWithTag:103];
    CGRect frm = alertView.frame;
    frm.size.height -= 20;
    alertView.frame = frm;
    activityView.center = CGPointMake(140, frm.size.height-30);
}

+ (void) dismissActivityAlert
{
    double delayInSeconds = 0.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.0 animations:^{
            initObj.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [initObj removeFromSuperview];
            initObj.alpha = 0.1f;
        }];
    });
}

+ (void)showDownloadingIndicator:(UIView*)view_
{
    view_indicatorDownload = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(100, 5, 10, 10)];
    [view_indicatorDownload setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view_ addSubview:view_indicatorDownload];
    [view_indicatorDownload startAnimating];
}

+ (void)hideDownloadingIndicator:(UIView*)view_
{
    [view_indicatorDownload stopAnimating];
    [view_indicatorDownload removeFromSuperview];
    
}

+ (void)showDownloadingIndicator
{
    
}

+ (void)hideDownloadingIndicator
{
    
}

@end

