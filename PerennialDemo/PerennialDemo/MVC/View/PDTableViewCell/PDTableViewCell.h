//
//  PDTableViewCell.h
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDUserVO;
@interface PDTableViewCell : UITableViewCell
- (void)setItem:(PDUserVO *)item;
@end
