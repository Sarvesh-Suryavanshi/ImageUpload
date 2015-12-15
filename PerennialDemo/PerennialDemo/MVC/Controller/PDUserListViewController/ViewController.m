//
//  ViewController.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "ViewController.h"
#import "PDTopBarView.h"
#import "PDTableViewCell.h"
#import "WebServiceManager.h"
#import "PDUserResponseVO.h"
#import "PDWebServiceHelper.h"
#import "AppDelegate.h"
#import "PDAddUserViewController.h"

NSString * const PDTitle = @"Perinnial Demo";
NSInteger const PDTableRowHeight = 100.0f;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, WebServiceManagerCallbackDelegate, PDTopBarDelegate>
{
    __weak IBOutlet PDTopBarView *_topBarView;
    __weak IBOutlet UITableView *_tableView;
    NSArray *_userList;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self callWebServiceForUsers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Helper Method

- (void)updateView
{
    [_topBarView setBackgroundColor:[PDThemeAndAlertConstant getMainthemeColour]];
    [_topBarView setTitle:PDTitle];
    [_topBarView setDelegate:self];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDTableViewCell class])];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _userList = @[];
}

- (void)callWebServiceForUsers
{
    if (![AlertView isNetworkAvailable])
    {
        [AlertView showNoNetworkAlert];
        return;
    }
    
    [ActivityAlert showActivity];
    PDUserResponseVO *userVO = [[PDUserResponseVO alloc] init];
    NSString *apiURL = [PDWebServiceHelper getUserListAPI];
    [[WebServiceManager sharedInstance] callGetWebServiceWithAPIURL:apiURL responseVO:userVO andListener:self];
}

#pragma mark - WebServiceManager CallbackDelegate

- (void)webServiceSuccessForResponseVO:(id<WebServiceResponseDelegate>)responseVO
{
    if ([responseVO isKindOfClass:[PDUserResponseVO class]])
    {
        PDUserResponseVO *responseObject = (PDUserResponseVO *)responseVO;
        _userList = [responseObject getItems];
        [_tableView reloadData];
    }
    [ActivityAlert dismissActivityAlert];
}

- (void)webServiceFailureForResponseVO:(id<WebServiceResponseDelegate>)responseVO
{
    [ActivityAlert dismissActivityAlert];
}

#pragma mark - TableView DataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTableViewCell class]) forIndexPath:indexPath];
    [cell setItem:[_userList objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark -TableView Delegate Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PDTableRowHeight;
}

#pragma mark - PDTopBarDelegate

- (void)didTapOnAddUser
{
    PDAddUserViewController *addUserVC =[[AppDelegate getStoryBoard] instantiateViewControllerWithIdentifier:NSStringFromClass([PDAddUserViewController class])];
    [self presentViewController:addUserVC animated:YES completion:nil];
}

@end
