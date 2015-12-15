//
//  PDAddUserViewController.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "PDAddUserViewController.h"
#import "WebServiceManager.h"
#import "PDWebServiceHelper.h"
#import "PDUploadTaskResponseVO.h"
#import "AppDelegate.h"

NSString * const NameKey        = @"name";
NSString * const AddressKey     = @"address";
NSString * const ImageFileKey   = @"imgfile";

@interface PDAddUserViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,WebServiceManagerCallbackDelegate>
{
    __weak IBOutlet UITextField *_usernameField;
    __weak IBOutlet UITextView *_addressField;
    UIImagePickerController *_imagePicker;
    __weak IBOutlet UIImageView *_userImageView;
    UIImage *_userImage;
}
- (IBAction)onTapSave:(id)sender;
- (IBAction)onTapCancel:(id)sender;
- (IBAction)onTapSelectImage:(id)sender;
@end

@interface PDAddUserViewController ()

@end

@implementation PDAddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Methods

- (IBAction)onTapCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapSelectImage:(id)sender
{
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (IBAction)onTapSave:(id)sender
{
    NSString *username = _usernameField.text;
    NSString *address = _addressField.text;
    [self.view endEditing:YES];
    
    if ([self isValidData])
    {
        NSDictionary *parameter = @{ NameKey:username,
                                     AddressKey:address,
                                     ImageFileKey:username
                                     };
        
            if (![AlertView isNetworkAvailable])
            {
                [AlertView showNoNetworkAlert];
                return;
            }
            
            [ActivityAlert showActivity];
            PDUploadTaskResponseVO *uploadTaskResponseVO = [[PDUploadTaskResponseVO alloc] init];
            [[WebServiceManager sharedInstance] uploadImage:_userImage withAPIUrl:[PDWebServiceHelper getSaveUserAPI] parameters:parameter responseVO:uploadTaskResponseVO andListener:self];
    }
}

#pragma mark View Touch Methods

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editing
{}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    if (image)
    {
        if ([self setupImage:image])
        {
            [_imagePicker dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Helper Method

- (void)updateView
{
    [_usernameField.layer setBorderWidth:1.0f];
    [_usernameField.layer setBorderColor:[PDThemeAndAlertConstant getMainthemeColour].CGColor];
    [_addressField.layer setBorderWidth:1.0f];
    [_addressField.layer setBorderColor:[PDThemeAndAlertConstant getMainthemeColour].CGColor];
    _addressField.layer.cornerRadius = _usernameField.layer.cornerRadius = 3.0f;
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
}

- (BOOL)isValidData
{
    NSString *username = _usernameField.text;
    NSString *address = _addressField.text;
 
    if (username.length>0 && address.length>0)
    {
        return YES;
    }
    else
    {
        [AlertView showAlertWithTitle:@"" message:AlertEmptyFields buttons:@[AlertOK] completionBlock:^(NSInteger index) {
            [self resetTextFields];
        }];
        return NO;
    }
}

- (void)resetTextFields
{
    _usernameField.text = @"";
    _addressField.text = @"";
    [_usernameField becomeFirstResponder];
}

- (BOOL)setupImage:(UIImage *)image
{
    _userImage = image;
    [_userImageView setImage:_userImage];
    return YES;
}

#pragma mark - WebServiceResponseDelegate Method

- (void)webServiceSuccessForResponseVO:(id<WebServiceResponseDelegate>)responseVO
{
    if ([responseVO isKindOfClass:[PDUploadTaskResponseVO class]])
    {
        [AlertView showAlertWithTitle:@"" message:AlertUserAdded buttons:@[AlertOK] completionBlock:^(NSInteger index) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    [ActivityAlert dismissActivityAlert];
}

- (void)webServiceFailureForResponseVO:(id<WebServiceResponseDelegate>)responseVO
{
    if ([responseVO isKindOfClass:[PDUploadTaskResponseVO class]])
    {
        [AlertView showAlertWithTitle:@"" Message:AlertUserAddingFailed buttons:@[AlertOK]];
    }
    [ActivityAlert dismissActivityAlert];
}

@end
