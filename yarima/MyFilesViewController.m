//
//  MyFilesViewController.m
//  yarima
//
//  Created by sina on 12/30/15.
//  Copyright © 2015 sina. All rights reserved.
//

#import "MyFilesViewController.h"
#import "ListTableViewCell.h"
#import "ADDViewController.h"

@interface MyFilesViewController (){
    NSMutableArray *tableArray;
    NSMutableArray*info;
    NSMutableArray*Addinfo;
    NSMutableArray*newaddArray;
    NSMutableArray*detailArray;
    NSMutableArray*detail;
    
    ListTableViewCell *Cell;
}

@end

@implementation MyFilesViewController

-(void)viewDidAppear:(BOOL)animated{
    
    
}
-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }}}
- (void)viewDidLoad {
    
    [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
    self.Tab1Img.hidden=YES;
    self.tableViewmyfiles.hidden=YES;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menubtn addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    info = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSManagedObjectContext *managedObjectContext2 = [self managedObjectContext];
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc]initWithEntityName:@"Detail"];
    [fetchRequest2 setReturnsObjectsAsFaults:NO];
    Addinfo = [[managedObjectContext2 executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    
    newaddArray=[[NSMutableArray alloc]init];
    for (NSDictionary * dic in Addinfo ) {
        [newaddArray addObject:dic];
    }
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        
        NSManagedObjectContext *managedObjectContext2 = [self managedObjectContext];
        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc]initWithEntityName:@"AddFiles"];
        detail = [[managedObjectContext2 executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
        detailArray=[[NSMutableArray alloc]init];
        
        for (NSDictionary *obj in [detail valueForKey:@"detail"])
        {
            detailArray=[NSMutableArray arrayWithArray:[obj allValues]];
            
        }
        
    } else {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"email"] =[info valueForKey:@"user"];
        params[@"password"] =[info valueForKey:@"pass"];
        // [SVProgressHUD show];
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"estate_domains_app"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject)
         {
             
             
             detailArray = [[NSMutableArray alloc]init];
             for (NSDictionary *dic2 in [responseObject objectForKey:@"result"]) {
                 NSManagedObjectContext *context = [self managedObjectContext];
                 NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"AddFiles" inManagedObjectContext:context];
                 [newDevice setValue:dic2  forKey:@"detail"];
                 [self saveContext];
             }
             
             
             tableArray = [[NSMutableArray alloc]init];
             NSArray*array;
             for (NSDictionary *dic in [responseObject objectForKey:@"result"])
             {
                 [tableArray addObject:dic];
             }
             array=tableArray;
             [SVProgressHUD dismiss];
             [self.tableViewaddedfiles reloadData];
         }   failure:^(NSURLSessionTask *operation, NSError *error) {
             [SVProgressHUD dismiss];
             NSLog(@"Error: %@", error);
         }];
        
    }
    
    
    [super viewDidLoad];
}
-(IBAction)View{
    NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
    [defualt setObject:@"1" forKey:@"backID"];
    [defualt synchronize];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
    if(indexPath.row == totalRow -1){
        
        if (tableView==self.tableViewaddedfiles) {
            
            
            NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
            [fetchRequest setReturnsObjectsAsFaults:NO];
            info = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
            NSManagedObjectContext *managedObjectContext2 = [self managedObjectContext];
            NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc]initWithEntityName:@"Detail"];
            [fetchRequest2 setReturnsObjectsAsFaults:NO];
            Addinfo = [[managedObjectContext2 executeFetchRequest:fetchRequest2 error:nil] mutableCopy];

            for (NSDictionary * dic in Addinfo ) {
                [newaddArray addObject:dic];
            }
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"email"] =[info valueForKey:@"user"];
            params[@"password"] =[info valueForKey:@"pass"];
            params[@"last_id"] =Cell.IDlabel.text;
            
            NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"estate_domains_app"];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject)
             {
                 
                 NSArray*array;
                 for (NSDictionary *dic in [responseObject objectForKey:@"result"])
                 {
                     [tableArray addObject:dic];
                 }
                 array=tableArray;
                 [SVProgressHUD dismiss];
                 [self.tableViewaddedfiles reloadData];
             }   failure:^(NSURLSessionTask *operation, NSError *error) {
                 [SVProgressHUD dismiss];
                 NSLog(@"Error: %@", error);
             }];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.tableViewaddedfiles)
    {
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable) {
            return [detailArray count];
        }
        else
        {
            return [tableArray count];
        }
    }
    else
    {
        return [newaddArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableViewaddedfiles) {
        static NSString *CellIdentifier = @"cell";
        Cell = (ListTableViewCell *)[self.tableViewaddedfiles dequeueReusableCellWithIdentifier:CellIdentifier];
        if (Cell == nil)
        {
            Cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        Cell.rahnView.hidden=YES;
        if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"property_type"] isEqualToString:@"رهن و اجاره"]) {
            Cell.rahnView.hidden=NO;
        }
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable) {
            Cell.nameLabel.text=[[detailArray objectAtIndex:indexPath.row]objectForKey:@"property_type"];
            Cell.locationLabel.text=[[detailArray objectAtIndex:indexPath.row]objectForKey:@"region_name"];
            Cell.rahnLabel.text=[NSString stringWithFormat:@"%@",[[detailArray objectAtIndex:indexPath.row]objectForKey:@"mortgage"]];
            Cell.ejareLabel.text=[NSString stringWithFormat:@"%@",[[detailArray objectAtIndex:indexPath.row]objectForKey:@"rent"]];
            Cell.dateLabel.text=[[detailArray objectAtIndex:indexPath.row]objectForKey:@"adddate"];
            Cell.priceLabel.text=[NSString stringWithFormat:@"%@",[[detailArray objectAtIndex:indexPath.row]objectForKey:@"price"]];
            Cell.IDlabel.text=[NSString stringWithFormat:@"%@",[[detailArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
            Cell.areaLabel.text=[NSString stringWithFormat:@"%@",[[detailArray objectAtIndex:indexPath.row]objectForKey:@"area"]];
            Cell.bedroomLabel.text=[NSString stringWithFormat:@"%@",[[detailArray objectAtIndex:indexPath.row]objectForKey:@"bedroom"]];
        }
        else
        {
            Cell.nameLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"property_type"];
            Cell.locationLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"region_name"];
            Cell.rahnLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"mortgage"]];
            Cell.ejareLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"]];
            Cell.dateLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"adddate"];
            Cell.priceLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"price"]];
            Cell.IDlabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
            Cell.areaLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"area"]];
            Cell.bedroomLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"bedroom"]];
        }
        return Cell;
        
    }
    else
    {
        static NSString *CellIdentifier = @"cell";
        ListTableViewCell *cell = (ListTableViewCell *)[self.tableViewmyfiles dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSManagedObject *device = [Addinfo objectAtIndex:indexPath.row];
        cell.rahnView.hidden=YES;
        
        if ([[device valueForKey:@"transection"] isEqualToString:@"رهن و اجاره"]) {
            cell.rahnView.hidden=NO;
            cell.rahnLabel.text=[device valueForKey:@"rahn"];
            cell.ejareLabel.text=[device valueForKey:@"ejareh"];
        }
        else
        {
            cell.priceLabel.text=[device valueForKey:@"price"];
        }
        
        cell.nameLabel.text=[device valueForKey:@"type"];
        cell.locationLabel.text=[device valueForKey:@"region"];
        cell.typeLabel.text=[device valueForKey:@"transection"];
        cell.IDlabel.text=[device valueForKey:@"id"];
        cell.areaLabel.text=[device valueForKey:@"area"];
        cell.bedroomLabel.text=[device valueForKey:@"roomnumber"];
        
        NSLog(@"%@",device);
        
        return cell;
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[self getDetails:1];
    
   // UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSLog(@"%@",Addinfo);
    
   // NSArray *keys = [[[myObject entity] attributesByName] allKeys];
   // NSDictionary *dict = [myObject dictionaryWithValuesForKeys:keys];
    

    
    //NSDictionary *selectedItemDictionary = [Addinfo objectAtIndex:indexPath.row];

     //NSArray *keys = [[[] attributesByName] allKeys];
     //NSDictionary *fileDic = [selectedItemDictionary dictionaryWithValuesForKeys:keys];
    
   // NSLog(@"%@",fileDic);
    
   // ADDViewController *view = (ADDViewController *)[story instantiateViewControllerWithIdentifier:@"ADDViewController"];
    
  //  NSInteger fileID = [[fileDic objectForKey:@"id"]integerValue];
    
  //  [self getDetails:fileID];
    
    //view.dictionary = dic;
    
    //[self.navigationController pushViewController:view animated:YES];
}

-(void)getDetails:(NSInteger)fileID{
    NSLog(@"%ld",(long)fileID);
    
}

- (IBAction)Added:(id)sender
{
    self.Tab1Img.hidden=NO;
    self.Tab2Img.hidden=YES;
    self.tableViewaddedfiles.hidden=YES;
    self.tableViewmyfiles.hidden=NO;
    [SVProgressHUD dismiss];
    
}
- (IBAction)AllFiles:(id)sender
{
    self.Tab1Img.hidden=YES;
    self.Tab2Img.hidden=NO;
    self.tableViewaddedfiles.hidden=NO;
    self.tableViewmyfiles.hidden=YES;
}


@end
