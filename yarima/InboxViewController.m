//
//  InboxViewController.m
//  Catalog
//
//  Created by Developer on 1/29/17.
//  Copyright © 2017 Developer. All rights reserved.
//

#import "InboxViewController.h"
#import "Header.h"
#import "InboxCustomCell.h"
#import "PersianDate.h"
#import "AFHTTPSessionManager.h"
#import "SVProgressHUD.h"

#define MENU_WIDTH  screenWidth/1.5
@interface InboxViewController ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UILabel *titleLabel;
    BOOL isMenuShown;
    UIView *mainView;
    UIView *tranparentView;
    UIView *menuColorView;
    NSString *menuImageURL;
    CGFloat menuImageRatio;
    UIRefreshControl *refreshControl;
    BOOL noMoreData;
    NSString *dateStringTopOfList;
    NSString *dateStringEndOfList;
    UILabel *noResultLabelPost;
    NSString *message_id;
    NSInteger page;
    UILabel *offlineLabel;
    NSInteger *cellHeight;
    CGFloat height;
    
}
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *tableArray;

@end

@implementation InboxViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    page = 1;
    self.tableArray = [[NSMutableArray alloc]init];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    if ([self hasConnectivity]) {
        offlineLabel.hidden = YES;
        [self fetchInbox];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"شما در حالت آفلاین هستید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            offlineLabel.hidden = NO;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenWidth ,screenHeight - 50)];
    //self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    
    offlineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, screenWidth-40,  25)];
    offlineLabel.font = FONT_MEDIUM(17);
    offlineLabel.text = @"اتصال به اینترنت برقرار نیست.";
    offlineLabel.minimumScaleFactor = 0.7;
    offlineLabel.textColor = MAIN_COLOR;
    offlineLabel.textAlignment = NSTextAlignmentCenter;
    offlineLabel.adjustsFontSizeToFitWidth = YES;
    offlineLabel.hidden = YES;
    [self.tableView addSubview:offlineLabel];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.menuButton addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

#pragma mark - TableView DataSource Implementation

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_tableArray objectAtIndex:indexPath.row];
    return [self getHeightOfString:[dic objectForKey:@"body"]]+100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [_tableArray objectAtIndex:indexPath.row];
    
    InboxCustomCell *cell = (InboxCustomCell *)[[InboxCustomCell alloc]
                                                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2" titleString:[dic objectForKey:@"body"]];
    
    cell.descriptionText.text = [dic objectForKey:@"body"];
    
    //Change timestamp Date to persianDate
    double dateInMilliSeconds = [[dic objectForKey:@"date"]doubleValue];
    NSDate *normalDate = [NSDate dateWithTimeIntervalSince1970:dateInMilliSeconds];
    NSString *normalDateString = [NSString stringWithFormat:@"%@",normalDate];
    NSArray *dateComponentsArray = [normalDateString componentsSeparatedByString:@" "];
    NSArray *dashComponentsArray = [dateComponentsArray[0] componentsSeparatedByString:@"-"];
    PersianDate *persianDateInstance = [[PersianDate alloc]init];
    NSString *persianDateString = [persianDateInstance ConvertToPersianDateFinalWithYear:[[dashComponentsArray objectAtIndex:0]integerValue] month:[[dashComponentsArray objectAtIndex:1] integerValue]day:[[dashComponentsArray objectAtIndex:2] integerValue]];
    NSString *dateStr = [NSString stringWithFormat:@"%@",persianDateString];
    
    cell.dateLabel.text = dateStr;
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(5, cell.dateLabel.frame.origin.y+cell.dateLabel.frame.size.height+5, screenWidth-10, 1)];
    
    lineView.backgroundColor = MAIN_COLOR;
    [cell addSubview:lineView];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - custom methods
-(NSString*)timestamp2date:(NSString*)timestamp{
    NSString * timeStampString = timestamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue]/1000.0];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"dd/MM/yy"];
    return [_formatter stringFromDate:date];
}

- (CGFloat)getHeightOfString:(NSString *)labelText{
    UIFont *myFont = FONT_MEDIUM(15);
    if (IS_IPHONE_5_IOS7 || IS_IPHONE_5_IOS8 || IS_IPHONE_4_AND_OLDER_IOS7 || IS_IPHONE_4_AND_OLDER_IOS8) {
        myFont = FONT_NORMAL(15);
    }
    if (IS_IPAD) {
        myFont = FONT_NORMAL(22);
    }
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineSpacing:10];
    paragraph.alignment = NSTextAlignmentJustified;
    paragraph.baseWritingDirection = NSWritingDirectionRightToLeft;
    paragraph.firstLineHeadIndent = 1.0;
    NSDictionary* attributes = @{
                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                 NSParagraphStyleAttributeName: paragraph,
                                 NSFontAttributeName:FONT_NORMAL(15)
                                 };
    NSString* txt = labelText;
    NSAttributedString* aString = [[NSAttributedString alloc] initWithString: txt attributes: attributes];
    CGSize sizeOfText = [aString boundingRectWithSize:CGSizeMake( screenWidth -40,CGFLOAT_MAX)
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              context:nil].size;
    CGFloat height2 = sizeOfText.height;
    if (IS_IPHONE_4_AND_OLDER_IOS8)
        height2 = sizeOfText.height + 10;
    return height2;
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        if ([self hasConnectivity]) {
            page += 1;
            [self fetchInbox];
        }
    }
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Connection
- (BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    return NO;
}

- (void)fetchInbox{
    [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
    NSDictionary *params = @{
                             @"channel":channel,
                             @"page":[NSNumber numberWithInteger:page],
                             @"limit":@"20"
                             };
    /*yarima.ir/Domains/get_inbox_messages*/
    NSString *url = [NSString stringWithFormat:@"%@get_inbox_messages", BaseURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        
        [noResultLabelPost removeFromSuperview];
        if (([[tempDic objectForKey:@"data"]count] == 0) && ([self.tableArray count] == 0)) {
            
            noResultLabelPost = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, screenWidth-20,  25)];
            noResultLabelPost.font = FONT_MEDIUM(17);
            noResultLabelPost.text = @"پیامی یافت نشد.";
            noResultLabelPost.minimumScaleFactor = 0.7;
            noResultLabelPost.textColor = [UIColor blackColor];
            noResultLabelPost.textAlignment = NSTextAlignmentCenter;
            noResultLabelPost.adjustsFontSizeToFitWidth = YES;
            [_tableView addSubview:noResultLabelPost];
            return;
        }
        
        for (NSDictionary *message in [tempDic objectForKey:@"data"]) {
            [self.tableArray addObject:message];
        }
        [noResultLabelPost removeFromSuperview];
        [self.tableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"خطای سرور.لطفا دوباره تلاش کنید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        [SVProgressHUD dismiss];
    }];
}
@end
