//
//  ViewController.m
//  Yarima App
//
//  Created by sina on 9/9/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import "ListViewController.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "CustomLabel.h"
#import "DesignTeamViewController.h"

@interface ListViewController (){
    
    int pageInt;
}
@end

@implementation ListViewController{
    float  pointNow;
    NSMutableArray *tableArray;
    NSDictionary*dic;
    NSMutableArray*kitchenarray;
    NSMutableArray*groundArray;
    NSMutableArray*propertyArray;
    NSMutableArray*positionArray;
    NSDictionary*dic3;
    NSMutableArray*kitchenArray2;
    //NSMutableArray*Groundarray;
    //NSMutableArray*Propertyarray;
    //NSMutableArray*Positionarray;
    
    NSArray *matches;
}
-(void)viewWillAppear:(BOOL)animated{
//    if ([self hasConnectivity]) {
//        [self fetchDataFromServer];
//    }
}

-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [SVProgressHUD dismiss];
    if ([[defualt1 objectForKey:@"login"] isEqualToString:@"1"]){
        self.LoginBtn.hidden=YES;
        self.Loginlbl.hidden=YES;
        self.Myhomesbtn.hidden=NO;
        self.Myhomeslbl.hidden=NO;
    }else{
        self.LoginBtn.hidden=NO;
        self.Loginlbl.hidden=NO;
        //self.Myhomesbtn.hidden=YES;
       // self.Myhomeslbl.hidden=YES;
    }
}
-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)saveContext{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
    {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
        }
    }
}
-(IBAction)Exit{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:@"0" forKey:@"login"];
    NSManagedObjectContext *context = [self managedObjectContext];
    //NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:context];
    NSFetchRequest *Entity = [[NSFetchRequest alloc] init];
    [Entity setEntity:[NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context]];
    [Entity setIncludesPropertyValues:NO];
    NSError *error = nil;
    NSArray *Entityarray = [context executeFetchRequest:Entity error:&error];
    for (NSManagedObject *car in Entityarray)
    {
        [context deleteObject:car];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    [self saveContext];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerDeviceToken:) name:@"RegisterDeviceToken" object:nil];
    
    [self registerDeviceTokenOnServer:nil];
    
    if (![self hasConnectivity]) {
       // [self performSelector:@selector(showAlert) withObject:nil afterDelay:3.0];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"در حالت آفلاین هستید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        dispatch_async(dispatch_get_main_queue(), ^{
           [self presentViewController:alert animated:YES completion:nil];
        });
    }else{
        [self fetchDataFromServer];
    }
    pageInt=0;
    [self performSelector:@selector(indicator) withObject:nil afterDelay:0.1];
     self.scrollView.delegate = self;
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320,680)];
    [self.ListTableView setScrollEnabled:NO];
    [self pointofscrollview];
    [self scrollOffset];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.menuBtn addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
//    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"last_domains_app"];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
//    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
//    {
//        tableArray = [[NSMutableArray alloc]init];
//    for (NSDictionary *dic in [responseObject objectForKey:@"result"] )
//    {
//        [tableArray addObject:dic];
//    }
//      //  [SVProgressHUD dismiss];
//        [self.ListTableView reloadData];
//    }   failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];

    self.AddnewBtn.layer.cornerRadius=15;
    self.AddnewBtn.clipsToBounds=YES;
    self.SearchnewBtn.layer.cornerRadius=15;
    self.SearchnewBtn.clipsToBounds=YES;
    self.LoginBtn.layer.cornerRadius=15;
    self.LoginBtn.clipsToBounds=YES;
    self.Myhomesbtn.layer.cornerRadius=15;
    self.Myhomeslbl.clipsToBounds=YES;
    self.inboxButton.layer.cornerRadius = 15;
    self.inboxButton.clipsToBounds = YES;
    self.aboutUsButton.layer.cornerRadius = 15;
    self.aboutUsButton.clipsToBounds = YES;
    
    /*
    UIButton *designTeamButton = [[UIButton alloc]initWithFrame:CGRectMake(0, screenHeight-50, screenWidth,50)];
    [designTeamButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [designTeamButton addTarget:self action:@selector(designTeamButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //designTeamButton.backgroundColor = [UIColor redColor];
    designTeamButton.titleLabel.font = FONT_NORMAL(15);
    designTeamButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:designTeamButton];
    
    UIImageView *designTeamImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2+40,12,25,25)];
    designTeamImageView.image = [UIImage imageNamed:@"yarimaLogo"];
    designTeamImageView.backgroundColor = [UIColor clearColor];
    designTeamImageView.contentMode = UIViewContentModeScaleAspectFit;
    designTeamImageView.userInteractionEnabled = YES;
    [designTeamButton addSubview: designTeamImageView];
    
    UILabel *designTeamLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(100, 10, 100, 30)];
    designTeamLabel.textColor = [UIColor blackColor];
    designTeamLabel.text = @"تیم طراحی و توسعه";
    designTeamLabel.font = FONT_NORMAL(10);
    //designTeamLabel.backgroundColor = [UIColor yellowColor];
    designTeamLabel.textAlignment = NSTextAlignmentCenter;
    [designTeamButton addSubview:designTeamLabel];
     */
}
#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableArray count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"Selected section>> %ld",(long)indexPath.section);
    NSLog(@"Selected row of section >> %ld",(long)indexPath.row);
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
    if(indexPath.row == totalRow -1){
       // self.ListTableView.hidden=YES;
    }
}
-(IBAction)Back{
    NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
     [def setObject:@"2" forKey:@"backID"];
    [def synchronize];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    ListTableViewCell *cell = (ListTableViewCell *)[self.ListTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.nameLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"property_type"];
    cell.locationLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"region_name"];
    cell.dateLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"adddate"];
    cell.priceLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"price"]];
    cell.IDlabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
    cell.areaLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"area"] ];
    cell.bedroomLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"bedroom"] ];
    return cell;
}
#pragma mark - ScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        // [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
        NSString*pageStr;
        pageInt++;
       
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"last_domains_app"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        
        pageStr=[NSString stringWithFormat:@"%d", pageInt];
        params[@"page"] =pageStr;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
         manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
        [manager POST:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            for (NSDictionary *dic2 in [responseObject objectForKey:@"result"] ){
                [tableArray addObject:dic2];
            }
            //  [self performSelector:@selector(as) withObject:nil afterDelay:3];
            //[SVProgressHUD dismiss];
            [self.ListTableView reloadData];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    pointNow = self.scrollView.contentOffset.y;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    ////
    if (scrollView==self.scrollView) {
        CGFloat totalScroll = self.scrollView.contentOffset.y - self.ListTableView.contentOffset.y;
        CGFloat percentage = totalScroll / 100;
        self.cityImg.alpha =1- percentage;
        self.titleBtn.alpha=1- percentage;
        self.irlabel.alpha=1- percentage;
        self.addImg.alpha=1- percentage;
        self.addBtn.alpha=1- percentage;
        self.searchImg.alpha=1- percentage;
        self.searchBtn.alpha=1- percentage;
        self.addtitleBtn.alpha=percentage;
        self.searchtitleBtn.alpha=percentage;
        if (self.scrollView.contentOffset.y>pointNow) {
            if (percentage>0) {
                if (percentage>0.5) {
                    if (self.yarimalabel.frame.origin.y>16) {
                        self.yarimalabel.font=[UIFont fontWithName:@"BebasNeue" size:30];
                        CGRect frame = self.yarimalabel.frame;
                        frame.size.width = self.yarimalabel.frame.size.width-4.2;
                        frame.size.height = self.yarimalabel.frame.size.height-2.3;
                        frame.origin.x = self.yarimalabel.frame.origin.x-25.5;
                        frame.origin.y = self.yarimalabel.frame.origin.y-10.5;
                        self.yarimalabel.frame = frame;
                    }
                }
                if (self.addBtn.frame.origin.y>120) {
                    CGRect frame1 = self.addBtn.frame;
                    frame1.origin.y = self.addBtn.frame.origin.y-1.5;
                    self.addBtn.frame = frame1;
                    CGRect frame2 = self.addImg.frame;
                    frame2.origin.y = self.addImg.frame.origin.y-1.5;
                    self.addImg.frame = frame2;
                    CGRect frame4 = self.searchBtn.frame;
                    frame4.origin.y = self.searchBtn.frame.origin.y-1.5;
                    self.searchBtn.frame = frame4;
                    CGRect frame5 = self.searchImg.frame;
                    frame5.origin.y = self.searchImg.frame.origin.y-1.5;
                    self.searchImg.frame = frame5;
                    CGRect frame = self.addtitleBtn.frame;
                    frame.origin.y = self.addtitleBtn.frame.origin.y-1.5;
                    self.addtitleBtn.frame = frame;
                    CGRect xx2 = self.searchtitleBtn.frame;
                    xx2.origin.y = self.searchtitleBtn.frame.origin.y-1.5;
                    self.searchtitleBtn.frame = xx2;
                }
                pointNow = self.scrollView.contentOffset.y;
            }
        }
        if (self.scrollView.contentOffset.y<pointNow) {
            if (percentage<1) {
                if (percentage<0.8) {
                    if (self.yarimalabel.frame.origin.y<40) {
                        self.yarimalabel.font=[UIFont fontWithName:@"BebasNeue" size:60];
                        CGRect x3 = self.yarimalabel.frame;
                        x3.size.width = self.yarimalabel.frame.size.width+4.2;
                        x3.size.height = self.yarimalabel.frame.size.height+2.3;
                        x3.origin.x = self.yarimalabel.frame.origin.x+25.5;
                        x3.origin.y = self.yarimalabel.frame.origin.y+10.5;
                        self.yarimalabel.frame = x3;
                    }
                }
                if (self.addBtn.frame.origin.y<120) {
                    CGRect x1 = self.addBtn.frame;
                    x1.origin.y = self.addBtn.frame.origin.y+1.5;
                    self.addBtn.frame = x1;
                    CGRect x2 = self.addImg.frame;
                    x2.origin.y = self.addImg.frame.origin.y+1.5;
                    self.addImg.frame = x2;
                    CGRect x4 = self.searchBtn.frame;
                    x4.origin.y = self.searchBtn.frame.origin.y+1.5;
                    self.searchBtn.frame = x4;
                    CGRect x5 = self.searchImg.frame;
                    x5.origin.y = self.searchImg.frame.origin.y+1.5;
                    self.searchImg.frame = x5;
                    CGRect xx1 = self.addtitleBtn.frame;
                    xx1.origin.y = self.addtitleBtn.frame.origin.y+1.5;
                    self.addtitleBtn.frame = xx1;
                    CGRect xx2 = self.searchtitleBtn.frame;
                    xx2.origin.y = self.searchtitleBtn.frame.origin.y+1.5;
                    self.searchtitleBtn.frame = xx2;
                }
                pointNow = self.scrollView.contentOffset.y;
            }
        }
    }
}
#pragma mark - Custom
-(void)pointofscrollview{
    pointNow=self.scrollView.contentOffset.y;
    [self performSelector:@selector(pointofscrollview) withObject:nil afterDelay:0.000000000000001];
}

-(void)scrollOffset{
    float scrollViewHeight = self.scrollView.frame.size.height;
    float scrollContentSizeHeight = self.scrollView.contentSize.height;
    float scrollOffset = self.scrollView.contentOffset.y;
    float scrollOffset2 = self.ListTableView.contentOffset.y;
    if (scrollOffset==0) {
        [self.ListTableView setScrollEnabled:NO];
    }
    if (scrollOffset2==0) {
    }
    if (scrollOffset + scrollViewHeight == scrollContentSizeHeight){
        [self.ListTableView setScrollEnabled:YES];
    }
    [self performSelector:@selector(scrollOffset) withObject:nil afterDelay:0.01];
}

-(void)indicator{
  //  [SVProgressHUD show];
}
- (IBAction)Call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:02166158735"]];
}

- (void)clearCoreData:(NSString *)entityName{
    NSError *error;
    NSEntityDescription *des = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    NSManagedObjectModel *model = [des managedObjectModel];
    NSArray *entityNames = [[model entities] valueForKey:@"name"];
    
    for (NSString *entity in entityNames){
        if ([entity isEqualToString:entityName]) {
            NSFetchRequest *deleteAll = [NSFetchRequest fetchRequestWithEntityName:entity];
            matches = [[self managedObjectContext] executeFetchRequest:deleteAll error:&error];
            break;
        }
    }
    if (matches.count > 0){
        for (id obj in matches){
            
            [[self managedObjectContext] deleteObject:obj];
        }
        [[self managedObjectContext] save:&error];
    }
}

//-(void) designTeamButtonAction{
////    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
////    DesignTeamViewController *view = (DesignTeamViewController *)[story instantiateViewControllerWithIdentifier:@"DesignTeamViewController"];
////    [self.navigationController pushViewController:view animated:YES];
//    [self performSegueWithIdentifier:@"designTeamSegue" sender:self];
//}

#pragma mark - Connections
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

- (void)fetchDataFromServer{
    if (![self hasConnectivity]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"شما در حالت آفلاین هستید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    
    //        if ([[user valueForKey:@"database"] isEqualToString:@"1"]) {
    //
    //        }
    //        else {
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"region_list_app"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         //[self clearCoreData:@"Region"];
         //[SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
         NSManagedObjectContext *context = [self managedObjectContext];
         NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Region" inManagedObjectContext:context];
         NSMutableDictionary*dicstr2=[[NSMutableDictionary alloc] init];
         dicstr2[@"location"]=responseObject;
         for (dic3 in [dicstr2 allValues])
         {
             [newDevice setValue:dic3 forKey:@"cityname"];
             [self saveContext];
         }
         [user setObject:@"1" forKey:@"database"];
         //[SVProgressHUD dismiss];
     }   failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
    
    NSString *url2 = [NSString stringWithFormat:@"%@%@",BaseURL, @"kitchen_app"];
    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
    manager2.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager2 GET:url2 parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         [self clearCoreData:@"Kitchen"];
         kitchenArray2 = [[NSMutableArray alloc]init];
         for (NSDictionary *dic2 in [responseObject objectForKey:@"result"]) {
             NSManagedObjectContext *context = [self managedObjectContext];
             
             NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Kitchen" inManagedObjectContext:context];
             [newDevice setValue:[dic2 valueForKey:@"name"] forKey:@"kitchen"];
             [self saveContext];
         }
         [user setObject:@"1" forKey:@"database"];
     }   failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
    NSString *url3 = [NSString stringWithFormat:@"%@%@",BaseURL, @"mogheyiat_app"];
    AFHTTPSessionManager *manager3 = [AFHTTPSessionManager manager];
    manager3.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager3 GET:url3 parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         [self clearCoreData:@"Position"];
         positionArray = [[NSMutableArray alloc]init];
         for (NSDictionary *dic2 in [responseObject objectForKey:@"result"]) {
             NSManagedObjectContext *context = [self managedObjectContext];
             NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Position" inManagedObjectContext:context];
             [newDevice setValue:[dic2 valueForKey:@"name"] forKey:@"position"];
             [self saveContext];
         }
         [user setObject:@"1" forKey:@"database"];
     }   failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
    NSString *url4 = [NSString stringWithFormat:@"%@%@",BaseURL, @"kafpoosh_app"];
    AFHTTPSessionManager *manager4 = [AFHTTPSessionManager manager];
    manager4.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager4 GET:url4 parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         [self clearCoreData:@"Ground"];
         groundArray = [[NSMutableArray alloc]init];
         for (NSDictionary *dic2 in [responseObject objectForKey:@"result"]) {
             NSManagedObjectContext *context = [self managedObjectContext];
             NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Ground" inManagedObjectContext:context];
             [newDevice setValue:[dic2 valueForKey:@"name"] forKey:@"ground"];
             [self saveContext];
         }
         [user setObject:@"1" forKey:@"database"];
     }   failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
    NSString *url5 = [NSString stringWithFormat:@"%@%@",BaseURL, @"property_type_app"];
    AFHTTPSessionManager *manager5 = [AFHTTPSessionManager manager];
    manager5.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager5 GET:url5 parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         [self clearCoreData:@"Property"];
         propertyArray = [[NSMutableArray alloc]init];
         for (NSDictionary *dic2 in [responseObject objectForKey:@"result"]) {
             NSManagedObjectContext *context = [self managedObjectContext];
             NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
             [newDevice setValue:[dic2 valueForKey:@"name"] forKey:@"property"];
             [self saveContext];
         }
         [user setObject:@"1" forKey:@"database"];
         
     }   failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}

#pragma mark - Comment this Connection if Push is not needed
- (void)registerDeviceTokenOnServer:(NSNotification *)notif{
    //    NSString *isDeviceToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"registerDeviceToken"];
    //    if ([isDeviceToken isEqualToString:@"YES"]) {
    //        return;
    //    }
    //NSString *deviceToken = @"ksfjsklfjsf-sdf-sdfsdflsdfjdsfsldf";
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
    NSInteger userID = [[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]integerValue];
    if ([deviceToken length] == 0) {
        return;
    }
    if (userID == 0) {
        userID = 0;
    }
    NSDictionary *params = @{@"push_key":deviceToken,
                             @"user_id":[NSNumber numberWithInteger:userID],
                             @"type":@"apple",
                             @"channel_id":@"21",
                             @"version_name":@"1.0",
                             @"imei": UDID
                             };
    NSString *url = @"http://notifpanel.yarima.co/web_services/push_notification/register_device";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 45;;
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        if ([[tempDic objectForKey:@"success"]integerValue] == 1) {
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"registerDeviceToken"];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}
@end
