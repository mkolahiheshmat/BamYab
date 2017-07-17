//
//  SearchRegionViewController.m
//  Yarima App
//
//  Created by sina on 10/13/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import "SearchRegionViewController.h"
#import "AFHTTPSessionManager.h"
#import "ListTableViewCell.h"
#import "Header.h"
#import "SVProgressHUD.h"

@interface SearchRegionViewController (){
    NSMutableArray*tableArray;
    NSMutableArray*citytableArray;
    NSMutableArray*stringArray;
    NSMutableArray*citystringArray;
    NSMutableArray*ResultArray;
    NSMutableArray*cityid2;
    NSArray*searchResults;
    NSArray*searchResults2;
    NSDictionary *regionDictionary;
    NSMutableDictionary*dicstr;
    NSDictionary *cityDictionary;
    
    NSMutableArray*city;
    NSMutableArray*cityname;
    NSMutableArray*regionname;
    
    NSDictionary*dic3;
    NSMutableArray*kitchenArray2;
    NSMutableArray*groundArray;
    NSMutableArray*propertyArray;
    NSMutableArray*positionArray;
    
    NSArray *matches;
}
@end
@implementation SearchRegionViewController
-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
-(void)viewWillAppear:(BOOL)animated{
    if ([self hasConnectivity]) {
        [self fetchDataFromServer];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self hasConnectivity]) {
        // [self performSelector:@selector(showAlert) withObject:nil afterDelay:3.0];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"در حالت آفلاین هستید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        dispatch_async(dispatch_get_main_queue(), ^{
            // [self presentViewController:alert animated:YES completion:nil];
        });
    }
    cityid2=[[NSMutableArray alloc]init ];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Region"];
    city = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    cityname=[[NSMutableArray alloc]init];
    regionname=[[NSMutableArray alloc]init];
    tableArray = [[NSMutableArray alloc]init];
    citytableArray = [[NSMutableArray alloc]init];
    searchResults2=[[NSMutableArray alloc]init];
    stringArray = [[NSMutableArray alloc]init];
    citystringArray = [[NSMutableArray alloc]init];
    dicstr=[[NSMutableDictionary alloc]init];
    ResultArray=[[NSMutableArray alloc]init];
    dicstr = [NSMutableDictionary dictionary];
    for (NSDictionary *obj in [city valueForKey:@"cityname"])
    {
        cityname=[NSMutableArray arrayWithArray:[obj objectForKey:@"city"]];
        regionname=[NSMutableArray arrayWithArray:[obj objectForKey:@"region"]];
    }
    for (cityDictionary in cityname ) {
        for (regionDictionary in regionname ) {
            if ([[regionDictionary valueForKey:@"city_id"] isEqualToString:[cityDictionary valueForKey:@"id"]])
            {
                NSString*string=[NSString stringWithFormat:@"%@%@%@",[regionDictionary valueForKey:@"name"],@"-",[cityDictionary valueForKey:@"name"]];
                NSString*string2=[NSString stringWithFormat:@"%@",[regionDictionary valueForKey:@"name"]];
                NSString*string3=[NSString stringWithFormat:@"%@",[regionDictionary valueForKey:@"id"]];
                [stringArray addObject:string];
                dicstr[@"location"]=string;
                dicstr[@"id"]=string3;
                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:dicstr];
                [ResultArray addObject:dict];
                [citystringArray addObject:string2];
            }
        }
    }
    [self.Tableview reloadData];
}
#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    ListTableViewCell *cell = (ListTableViewCell *)[self.Tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView){
        [self.searchDisplayController.searchResultsTableView.separatorColor= [UIColor clearColor]CGColor];
        cell.nameLabel.text=[[searchResults2 objectAtIndex:indexPath.row]valueForKey:@"location"];
        cell.locationLabel.text=[[searchResults2 objectAtIndex:indexPath.row]valueForKey:@"location" ];
        cell.IDlabel.text=[[searchResults2 objectAtIndex:indexPath.row]valueForKey:@"id"];
    }else{
        cell.nameLabel.text=[[ResultArray objectAtIndex:indexPath.row]valueForKey:@"location"];
        cell.locationLabel.text=[citystringArray objectAtIndex:indexPath.row];
        cell.IDlabel.text=[[ResultArray objectAtIndex:indexPath.row]valueForKey:@"id"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return [searchResults2 count];
    }else{
        return [regionname count];
    }
}

#pragma mark - Search
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSString *str = [searchText stringByReplacingOccurrencesOfString:@"ي" withString:@"ی"];
    //NSString *str2 = [str stringByReplacingOccurrencesOfString:@"ک" withString:@"ک"];
    NSString *str2 = [str stringByReplacingOccurrencesOfString:@"ك" withString:@"ک"];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"location contains[c] %@",str2];
    searchResults2 = [ResultArray filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}

//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self filterContentForSearchText:searchString
//                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
//                                      objectAtIndex:[self.searchDisplayController.searchBar
//                                                     selectedScopeButtonIndex]]];
//    return YES;
//}

#pragma mark - Custom
-(IBAction)set{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    NSString*loadstring1=[defualt1 objectForKey:@"regionid"];
    if ([loadstring1 isEqualToString:@"1"]){
        [self performSegueWithIdentifier:@"OK" sender:self];
    }else{
        [self performSegueWithIdentifier:@"OK2" sender:self];
    }
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

- (void)clearCoreData:(NSString *)entityName
{
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
         [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
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
         [SVProgressHUD dismiss];
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
@end
