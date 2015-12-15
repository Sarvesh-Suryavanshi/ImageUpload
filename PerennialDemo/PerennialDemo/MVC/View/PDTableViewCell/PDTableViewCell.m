//
//  PDTableViewCell.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "PDTableViewCell.h"
#import "PDUserVO.h"
#import "UIImage+Helper.h"
#import "UIImageView+WebCache.h"

NSString * const PortNo = @":8081";
NSInteger const InsertionIndex = 21.0f;

@interface PDTableViewCell ()
{
    __weak IBOutlet UILabel *_userName;
    __weak IBOutlet UIImageView *_userImage;
    __weak IBOutlet UITextView *_address;
    PDUserVO *_currentUserVO;
}
@end

@implementation PDTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)prepareForReuse
{
    _userName.text = @"Username - ";
}

- (void)setItem:(PDUserVO *)item
{
    _address.text = [item getAddress];    
    _userName.text = [_userName.text stringByAppendingString:[item getUserName]];
    NSMutableString *imageString = [NSMutableString stringWithString:[item getImage]];
    [imageString insertString:PortNo atIndex:InsertionIndex];
    NSURL *imageURL = [NSURL URLWithString:imageString];
    
    [_userImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Image"]];
}

@end
