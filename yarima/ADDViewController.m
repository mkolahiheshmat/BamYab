//
//  ADDViewController.m
//  Yarima App
//
//  Created by sina on 9/16/15.
//  Copyright (c) 2015 sina. All rights reserved.
//
#import <sys/socket.h>
#import <netinet/in.h>
#import "ADDViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPSessionManager.h"
#import "ListTableViewCell.h"
#import "Header.h"
#import "ReplacerEngToPer.h"
#import "MapViewController.h"
#import "CustomImageView.h"
#import "DetailViewController.h"

#define MAX_LENGTH 2
#define MAX_LENGTH2 10
#define MAX_LENGTH3 6
#define MAX_LENGTH4 14

@interface ADDViewController ()
{
    UIPickerView *TransectionPickerView;
    UIPickerView *TypePickerView;
    UIPickerView *roomNumberPickerView;
    UIPickerView *positionPickerView;
    UIPickerView *kitchenPickerView;
    UIPickerView *groundPickerView;
    UIPickerView *PickerViewTabaghe;
    UIPickerView *PickerViewUsers;
    NSMutableArray*positionarray;
    NSMutableArray*kitchenarray;
    NSMutableArray*groundarray;
    NSMutableArray*typearray;
    NSMutableArray*users;
    NSMutableArray*city;
    NSMutableArray*regionname;
    NSMutableArray*cityname;
    NSMutableArray*kitchen;
    NSMutableArray*Position;
    NSMutableArray*Property;
    NSMutableArray*Ground;
    NSMutableArray*cityid;
    NSMutableArray*cityid2;
    NSMutableArray*EntityArray;
    NSMutableArray*usersdetail;
    NSMutableArray*usersphoneArray;
    NSMutableArray*tableArray;
    NSMutableArray*citytableArray;
    NSMutableArray*stringArray;
    NSMutableArray*citystringArray;
    NSMutableArray*ResultArray;
    NSMutableArray*passwordArray;
    NSMutableArray*detailArray;
    NSArray*searchResults;
    NSArray*searchResults2;
    NSDictionary *regionDictionary;
    NSMutableDictionary*dicstr;
    NSDictionary *cityDictionary;
    NSDictionary *alldic;
    NSDictionary *citydic;
    
    NSDictionary*dic3;
    NSMutableArray*regionArray2;
    NSMutableArray*kitchenArray2;
    NSMutableArray*groundArray;
    NSMutableArray*propertyArray;
    NSMutableArray*positionArray;
    
    NSArray *matches;
    
    UIScrollView *imagesScrollView;
    UIImage *chosenImage;
    
    UIImageView *imageView;
    UIImageView *removeImageView;
    
    NSMutableArray *imagesArray;
    NSData *imageData;
    NSMutableArray *imagesDataArray;
    
    NSInteger pointerOfImages;
    
}
@property (strong, nonatomic) IBOutlet UISearchBar *Serachbar;

@end

@implementation ADDViewController

-(void)viewWillAppear:(BOOL)animated{
    if ([self hasConnectivity]) {
        [self fetchDataFromServer];
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.view endEditing:YES];
    
    NSLog(@"%@",self.dictionary);
    
    // NSLog(@"%@",[self.dictionary objectForKey:@"ejareh"]);
    
    
    if (self.dictionary) {
        
        //if ([[self.dictionary objectForKey:@"transection"] isEqualToString:@"رهن و اجاره"]) {
        
        self.rahnTextField.hidden=NO;
        self.rahnConvertorlabel.hidden=NO;
        self.ejareConvertorlabel.hidden=NO;
        self.ejareTextField.hidden=NO;
        self.priceTextField.hidden=YES;
        self.Convertorlabel.hidden=YES;
        self.ejareTextField.text=[NSString stringWithFormat:@"%@",[self.dictionary objectForKey:@"ejareh"]];
        self.rahnTextField.text=[NSString stringWithFormat:@"%@",[self.dictionary objectForKey:@"rahn"]];
        self.transectionTextField.text=[self.dictionary objectForKey:@"transection"];
        self.typeTextField.text = [self.dictionary objectForKey:@"type"];
        //self.addressTextField.text = [self.dictionary objectForKey:@"address"];
        //self.nameTextField.text = [self.dictionary objectForKey:@"presenter"];
        self.areaTextField.text = [self.dictionary objectForKey:@"area"];
        //self.kitchenTextField.text = [self.dictionary objectForKey:@"ashpazkhane"];
        self.roomnumberTextField.text = [NSString stringWithFormat:@"%@", [self.dictionary objectForKey:@"roomnumber"]];
        self.regionTextField.text = [self.dictionary objectForKey:@"region"];
        //self.groundTextField.text = [self.dictionary objectForKey:@"kafpoosh"];
        //self.positionTextField.text = [self.dictionary objectForKey:@"mogheiyat"];
        //self.priceTextField.text = [self.dictionary objectForKey:@"price"];
        //self.mogeiatStr = [self.dictionary objectForKey:@"vaziyatesokonat"];
        //self.asansorStr = [self.dictionary objectForKey:@"asansor"];
        //self.balkonStr = [self.dictionary objectForKey:@"balkon"];
        //self.estahkrStr = [self.dictionary objectForKey:@"estakhr"];
        //self.parkingStr = [self.dictionary objectForKey:@"parking"];
        //self.sonaStr = [self.dictionary objectForKey:@"sona"];
        //self.anbariStr = [self.dictionary objectForKey:@"anbari"];
        //self.barghStr = [self.dictionary objectForKey:@"bargh"];
        //self.abStr = [self.dictionary objectForKey:@"ab"];
        //self.jakoziStr = [self.dictionary objectForKey:@"jakozi"];
        //self.gazStr = [self.dictionary objectForKey:@"gaz"];
        //  self. = [self.dictionary objectForKey:@"adddate"];
        // self.yearTextField.text = [self.dictionary objectForKey:@"seneBana"];
        // self.infoTextField.text = [self.dictionary objectForKey:@"tozihat"];
        // self.floorTextField.text = [self.dictionary objectForKey:@"tabaghe"];
        // self.phoneTextField.text = [self.dictionary objectForKey:@"tell"];
        // }else{
        
        //            self.rahnTextField.hidden=YES;
        //            self.rahnConvertorlabel.hidden=YES;
        //            self.ejareConvertorlabel.hidden=YES;
        //            self.ejareTextField.hidden=YES;
        //            self.priceTextField.hidden=NO;
        //            self.Convertorlabel.hidden=NO;
        //            self.priceTextField.text=[self.dictionary objectForKey:@"price"];
        //            //self.rahnTextField.text=[self.dictionary objectForKey:@"mortgage"];
        //            self.transectionTextField.text=[self.dictionary objectForKey:@"type_of_transaction"];
        //            self.typeTextField.text = [self.dictionary objectForKey:@"property_type"];
        //            self.addressTextField.text = [self.dictionary objectForKey:@"address"];
        //            self.nameTextField.text = [self.dictionary objectForKey:@"presenter"];
        //            self.areaTextField.text = [self.dictionary objectForKey:@"area"];
        //            self.kitchenTextField.text = [self.dictionary objectForKey:@"ashpazkhane"];
        //            self.roomnumberTextField.text = [self.dictionary objectForKey:@"bedroom"];
        //            self.regionTextField.text = [self.dictionary objectForKey:@"region_name"];
        //            self.groundTextField.text = [self.dictionary objectForKey:@"kafpoosh"];
        //            self.positionTextField.text = [self.dictionary objectForKey:@"mogheiyat"];
        //            self.priceTextField.text = [self.dictionary objectForKey:@"price"];
        //            self.mogeiatStr = [self.dictionary objectForKey:@"vaziyatesokonat"];
        //            self.asansorStr = [self.dictionary objectForKey:@"asansor"];
        //            self.balkonStr = [self.dictionary objectForKey:@"balkon"];
        //            self.estahkrStr = [self.dictionary objectForKey:@"estakhr"];
        //            self.parkingStr = [self.dictionary objectForKey:@"parking"];
        //            self.sonaStr = [self.dictionary objectForKey:@"sona"];
        //            self.anbariStr = [self.dictionary objectForKey:@"anbari"];
        //            self.barghStr = [self.dictionary objectForKey:@"bargh"];
        //            self.abStr = [self.dictionary objectForKey:@"ab"];
        //            self.jakoziStr = [self.dictionary objectForKey:@"jakozi"];
        //            self.gazStr = [self.dictionary objectForKey:@"gaz"];
        //            //  self. = [self.dictionary objectForKey:@"adddate"];
        //            self.yearTextField.text = [self.dictionary objectForKey:@"seneBana"];
        //            self.infoTextField.text = [self.dictionary objectForKey:@"tozihat"];
        //            self.floorTextField.text = [self.dictionary objectForKey:@"tabaghe"];
        //            self.phoneTextField.text = [self.dictionary objectForKey:@"tell"];
        
        //       }
    }
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuBtn addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.menuBtn addTarget:self action:@selector(touches) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [super viewDidAppear:animated];
    [SVProgressHUD dismiss];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Users"];
    users = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    usersdetail=[[NSMutableArray alloc]init];
    usersphoneArray=[[NSMutableArray alloc]init];
    for (NSDictionary * dic in [users valueForKey:@"name"]){
        [usersdetail addObject:dic];
    }
    for (NSDictionary * dic in [users valueForKey:@"phone"]){
        [usersphoneArray addObject:dic];
    }
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transactionOperations:)];
    tap1.numberOfTapsRequired = 1;
    [self.transactionTypeLabel addGestureRecognizer:tap1];
    self.transactionTypeLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeOperations:)];
    tap2.numberOfTapsRequired = 1;
    [self.typeLabel addGestureRecognizer:tap2];
    self.typeLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regionOperations:)];
    tap3.numberOfTapsRequired = 1;
    [self.regionLabel addGestureRecognizer:tap3];
    self.regionLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressOperations:)];
    tap4.numberOfTapsRequired = 1;
    [self.addressLabel addGestureRecognizer:tap4];
    self.addressLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(priceOperations:)];
    tap5.numberOfTapsRequired = 1;
    [self.priceLabel addGestureRecognizer:tap5];
    self.priceLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(areaOperations:)];
    tap6.numberOfTapsRequired = 1;
    [self.areaLabel addGestureRecognizer:tap6];
    self.areaLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(roomNumberOperations:)];
    tap7.numberOfTapsRequired = 1;
    [self.roomNumberLabel addGestureRecognizer:tap7];
    self.roomNumberLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameOperations:)];
    tap8.numberOfTapsRequired = 1;
    [self.nameLabel addGestureRecognizer:tap8];
    self.nameLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneOperations:)];
    tap9.numberOfTapsRequired = 1;
    [self.phoneLabel addGestureRecognizer:tap9];
    self.phoneLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap10 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(floorOperations:)];
    tap10.numberOfTapsRequired = 1;
    [self.floorLabel addGestureRecognizer:tap10];
    self.floorLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nFloorOperations:)];
    tap11.numberOfTapsRequired = 1;
    [self.nFloorLabel addGestureRecognizer:tap11];
    self.nFloorLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap20 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noRoomOperations:)];
    tap20.numberOfTapsRequired = 1;
    [self.nRoomLabel addGestureRecognizer:tap20];
    self.nRoomLabel.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tap12 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yearOperations:)];
    tap12.numberOfTapsRequired = 1;
    [self.yearLabel addGestureRecognizer:tap12];
    self.yearLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap13 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kitchenOperations:)];
    tap13.numberOfTapsRequired = 1;
    [self.kitchenLabel addGestureRecognizer:tap13];
    self.kitchenLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap14 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(groundOperations:)];
    tap14.numberOfTapsRequired = 1;
    [self.groundLabel addGestureRecognizer:tap14];
    self.groundLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap15 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(positionOperations:)];
    tap15.numberOfTapsRequired = 1;
    [self.positionLabel addGestureRecognizer:tap15];
    self.positionLabel.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tap16 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoOperations:)];
    tap16.numberOfTapsRequired = 1;
    [self.infoLabel addGestureRecognizer:tap16];
    self.infoLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap17 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapOperations:)];
    tap17.numberOfTapsRequired = 1;
    [self.mapLabel addGestureRecognizer:tap17];
    [self.mapTextField addGestureRecognizer:tap17];
    self.mapLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap18 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popMapVC:)];
    tap18.numberOfTapsRequired = 1;
    [self.mapTextField addGestureRecognizer:tap18];
    self.mapTextField.userInteractionEnabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    imagesScrollView = [[UIScrollView alloc]init];
    imagesArray = [[NSMutableArray alloc]init];
    imagesDataArray = [[NSMutableArray alloc]init];
    pointerOfImages = 0;
    
    //self.scrollView.contentSize = CGSizeMake(screenWidth,screenHeight+1000);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setLatLongText) name:@"setLatLongText" object:nil];
    if (![self hasConnectivity]) {
        // [self performSelector:@selector(showAlert) withObject:nil afterDelay:3.0];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"در حالت آفلاین هستید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        dispatch_async(dispatch_get_main_queue(), ^{
            //    [self presentViewController:alert animated:YES completion:nil];
        });
    }
    self.isFiltered = NO;
    
    [self.backButton2 setHidden:YES];
    // self.backButton2.backgroundColor = [UIColor redColor];
    [self addPickerView];
    self.EditBtn.hidden=YES;
    self.Tableview.hidden=YES;
    self.Serachbar.hidden=YES;
    self.mapenableLabel.hidden=YES;
    self.mapenableBtn.hidden=YES;
    self.imagesScrollview.hidden=YES;
    self.detailScrollview.hidden=YES;
    self.pic1Imageview.hidden=YES;
    self.pic2Imageview.hidden=YES;
    self.pic3Imageview.hidden=YES;
    self.pic4Imageview.hidden=YES;
    self.pic5Imageview.hidden=YES;
    self.pic6Imageview.hidden=YES;
    self.pic7Imageview.hidden=YES;
    self.pic8Imageview.hidden=YES;
    self.Cancel1Btn.hidden=YES;
    self.Cancel2Btn.hidden=YES;
    self.Cancel3Btn.hidden=YES;
    self.Cancel4Btn.hidden=YES;
    self.Cancel5Btn.hidden=YES;
    self.Cancel6Btn.hidden=YES;
    self.Cancel7Btn.hidden=YES;
    self.Cancel8Btn.hidden=YES;
    cityid2=[[NSMutableArray alloc]init ];
    NSManagedObjectContext *managedObjectContext2 = [self managedObjectContext];
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc]initWithEntityName:@"Region"];
    city = [[managedObjectContext2 executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    cityname=[[NSMutableArray alloc]init];
    regionname=[[NSMutableArray alloc]init];
    
    for (NSDictionary *obj in [city valueForKey:@"cityname"])
    {
        cityname=[NSMutableArray arrayWithArray:[obj objectForKey:@"city"]];
        regionname=[NSMutableArray arrayWithArray:[obj objectForKey:@"region"]];
    }
    
    
    NSManagedObjectContext *managedObjectContext3 = [self managedObjectContext];
    NSFetchRequest *fetchRequest3 = [[NSFetchRequest alloc]initWithEntityName:@"Kitchen"];
    kitchen = [[managedObjectContext3 executeFetchRequest:fetchRequest3 error:nil] mutableCopy];
    kitchenarray=[[NSMutableArray alloc]init];
    
    for (NSDictionary * dic in [kitchen valueForKey:@"kitchen"])
    {
        [kitchenarray addObject:dic];
    }
    
    NSManagedObjectContext *managedObjectContext4 = [self managedObjectContext];
    NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc]initWithEntityName:@"Position"];
    Position= [[managedObjectContext4 executeFetchRequest:fetchRequest4 error:nil] mutableCopy];
    positionarray=[[NSMutableArray alloc]init];
    
    for (NSDictionary * dic in [Position valueForKey:@"position"])
    {
        [positionarray addObject:dic];
    }
    NSManagedObjectContext *managedObjectContext5 = [self managedObjectContext];
    NSFetchRequest *fetchRequest5 = [[NSFetchRequest alloc]initWithEntityName:@"Property"];
    Property = [[managedObjectContext5 executeFetchRequest:fetchRequest5 error:nil] mutableCopy];
    typearray=[[NSMutableArray alloc]init];
    
    for (NSDictionary * dic in [Property valueForKey:@"property"])
    {
        [typearray addObject:dic];
    }
    
    
    NSManagedObjectContext *managedObjectContext6 = [self managedObjectContext];
    NSFetchRequest *fetchRequest6 = [[NSFetchRequest alloc]initWithEntityName:@"Ground"];
    Ground = [[managedObjectContext6 executeFetchRequest:fetchRequest6 error:nil] mutableCopy];
    groundarray=[[NSMutableArray alloc]init];
    
    for (NSDictionary * dic in [Ground valueForKey:@"ground"])
    {
        [groundarray addObject:dic];
    }
    
    _locationManager =[[CLLocationManager alloc]init];
    // Use either one of these authorizations **The top one gets called first and the other gets ignored
    [self.locationManager requestWhenInUseAuthorization];
    //[self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    //  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
    //       target:self
    //    selector:@selector(checkStatus)
    //   userInfo:nil repeats:YES];
    
    tableArray = [[NSMutableArray alloc]init];
    citytableArray = [[NSMutableArray alloc]init];
    searchResults2=[[NSMutableArray alloc]init];
    stringArray = [[NSMutableArray alloc]init];
    citystringArray = [[NSMutableArray alloc]init];
    dicstr = [[NSMutableDictionary alloc]init];
    ResultArray = [[NSMutableArray alloc]init];
    
    for (cityDictionary in cityname ) {
        
        for (regionDictionary in regionname ) {
            if ([[regionDictionary valueForKey:@"city_id"] isEqualToString:[cityDictionary valueForKey:@"id"]]){
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
    
    [self.priceTextField addTarget:self
                            action:@selector(textFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
    [self.rahnTextField addTarget:self
                           action:@selector(textFieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.ejareTextField addTarget:self
                            action:@selector(textFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
    self.mapTextField.text=@"";
    self.rahnTextField.hidden=YES;
    self.ejareTextField.hidden=YES;
    self.mapView.hidden=YES;
    self.Action2.hidden=YES;
    self.mogeiatStr=@"0";
    self.parkingStr=@"0";
    self.anbariStr=@"0";
    self.MapLatStr=@"0";
    self.jakoziStr=@"0";
    self.estahkrStr=@"0";
    self.barghStr=@"0";
    self.abStr=@"0";
    self.gazStr=@"0";
    self.sonaStr=@"0";
    self.asansorStr=@"0";
    self.balkonStr=@"0";
    
    NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
    
    if ([[defualt objectForKey:@"edit"]isEqualToString:@"1"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"domain_detail_app"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"domain_id"] =[defualt valueForKey:@"ID"];
        self.EditBtn.hidden=NO;
        [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            if ([[[responseObject objectForKey:@"result"] objectForKey:@"type_of_transaction"] isEqualToString:@"رهن و اجاره"]) {
                self.rahnTextField.hidden=NO;
                self.rahnConvertorlabel.hidden=NO;
                self.ejareConvertorlabel.hidden=NO;
                self.ejareTextField.hidden=NO;
                self.priceTextField.hidden=YES;
                self.Convertorlabel.hidden=YES;
                self.ejareTextField.text=[[responseObject objectForKey:@"result"] objectForKey:@"rent"];
                self.rahnTextField.text=[[responseObject objectForKey:@"result"] objectForKey:@"mortgage"];
            }
            self.transectionTextField.text=[[responseObject objectForKey:@"result"] objectForKey:@"type_of_transaction"];
            self.typeTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"property_type"];
            self.addressTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"address"];
            self.nameTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"presenter"];
            self.areaTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"area"];
            self.kitchenTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"ashpazkhane"];
            self.roomnumberTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"bedroom"];
            self.regionTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"region_name"];
            self.groundTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"kafpoosh"];
            self.positionTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"mogheiyat"];
            self.priceTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"price"];
            self.mogeiatStr = [[responseObject objectForKey:@"result"] objectForKey:@"vaziyatesokonat"];
            self.asansorStr = [[responseObject objectForKey:@"result"] objectForKey:@"asansor"];
            self.balkonStr = [[responseObject objectForKey:@"result"] objectForKey:@"balkon"];
            self.estahkrStr = [[responseObject objectForKey:@"result"] objectForKey:@"estakhr"];
            self.parkingStr = [[responseObject objectForKey:@"result"] objectForKey:@"parking"];
            self.sonaStr = [[responseObject objectForKey:@"result"] objectForKey:@"sona"];
            self.anbariStr = [[responseObject objectForKey:@"result"] objectForKey:@"anbari"];
            self.barghStr = [[responseObject objectForKey:@"result"] objectForKey:@"bargh"];
            self.abStr = [[responseObject objectForKey:@"result"] objectForKey:@"ab"];
            self.jakoziStr = [[responseObject objectForKey:@"result"] objectForKey:@"jakozi"];
            self.gazStr = [[responseObject objectForKey:@"result"] objectForKey:@"gaz"];
            //  self. = [[responseObject objectForKey:@"result"] objectForKey:@"adddate"];
            self.yearTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"seneBana"];
            self.infoTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"tozihat"];
            self.floorTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"tabaghe"];
            self.phoneTextField.text = [[responseObject objectForKey:@"result"] objectForKey:@"tell"];
            
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
        }];
    }
    NSString*loadstring1=[defualt objectForKey:@"Map"];
    [self.mapTextField setText:loadstring1];
    self.viewMapLatStr=[defualt objectForKey:@"Map"];
    self.viewMapLongStr=[defualt objectForKey:@"Mapl"];
    NSString*loadstring2=[defualt objectForKey:@"id"];
    [self.regionFieldid setText:loadstring2];
    self.regionTextField.text=[defualt objectForKey:@"AName"];
    
    [self performSelector:@selector(addPickerView) withObject:nil afterDelay:3];
    self.counterLabel.hidden=YES;
    self.pic1Imageview.hidden=YES;
    self.pic2Imageview.hidden=YES;
    self.pic3Imageview.hidden=YES;
    self.pic4Imageview.hidden=YES;
    self.pic5Imageview.hidden=YES;
    //[self initMap];
    ismogeiat=isparking=issona=isjakozi=isab=isgaz=isasansor=isanbari=isbargh=isbalkon=isestakhr=true;
    
    self.scrollView.delegate = self;
    [self.scrollView setScrollEnabled:YES];
    transactionarray = [[NSArray alloc]initWithObjects:@"رهن",@"فروش",
                        @"اجاره موقت",@"معاوضه",@"پیش فروش",@"رهن و اجاره",@"مشارکت در ساخت", nil];
    Roomarray = [[NSArray alloc]initWithObjects:
                 @"1",@"2",@"3",@"4",@"5",@"بیشتر از 5", nil];
    Tabaghearray = [[NSArray alloc]initWithObjects:@"زیر زمین",@"پیلوت",@"همکف",@"اول",@"دوم",@"سوم",@"چهارم",@"پنجم",@"ششم",@"هفتم",@"هشتم",@"نهم",@"دهم",@"یازدهم",@"دوازدهم",@"سیزدهم",@"چهاردهم",@"پانزدهم",@"شانزدهم" ,nil];
    self.counterLabel.text=@"1";
    [self.roomnumberTextField setBorderStyle:UITextBorderStyleNone];
    self.roomnumberTextField.layer.cornerRadius = 15.0;
    self.roomnumberTextField.layer.borderWidth = 1.0;
    self.AddNew.layer.cornerRadius = 15.0;
    self.AddNew.clipsToBounds =YES;
    self.EditBtn.layer.cornerRadius = 15.0;
    self.EditBtn.clipsToBounds =YES;
    self.DetailsBtn.layer.cornerRadius = 15.0;
    self.DetailsBtn.layer.borderWidth = 1.0;
    self.DetailsBtn.layer.borderColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:150.0f/255.0f alpha:1.0].CGColor;
    self.AddImageButton.layer.cornerRadius = 15.0;
    self.AddImageButton.clipsToBounds =YES;
    //   self.regionTextField.delegate = self;
    self.areaTextField.delegate = self;
    //   self.addressTextField.delegate = self;
    //   self.roomnumberTextField.delegate = self;
    self.priceTextField.delegate = self;
    //   self.typeTextField.delegate = self;
    //   self.transectionTextField.delegate = self;
    //   self.infoTextField.delegate = self;
    //   self.floorTextField.delegate = self;
    self.nofloorTextField.delegate = self;
    self.noroomTextField.delegate = self;
    //   self.groundTextField.delegate = self;
    //   self.phoneTextField.delegate = self;
    //   self.kitchenTextField.delegate = self;
    //   self.positionTextField.delegate = self;
    self.yearTextField.delegate = self;
    //   self.mapTextField.delegate=self;
    //   self.nameTextField.delegate = self;
    //   self.yearTextField.delegate=self;
    self.rahnTextField.delegate=self;
    self.ejareTextField.delegate=self;
    //   self.PIC1Imageview.layer.cornerRadius = 15.0;
    //   self.PIC1Imageview.layer.masksToBounds = YES;
    //   self.PIC2Imageview.layer.cornerRadius = 15.0;
    //   self.PIC2Imageview.layer.masksToBounds = YES;
    //   self.PIC3Imageview.layer.cornerRadius = 15.0;
    //   self.PIC3Imageview.layer.masksToBounds = YES;
    //   self.PIC4Imageview.layer.cornerRadius = 15.0;
    //   self.PIC4Imageview.layer.masksToBounds = YES;
    //   self.PIC5Imageview.layer.cornerRadius = 15.0;
    //   self.PIC5Imageview.layer.masksToBounds = YES;
    
    self.roomnumberTextField.layer.borderColor=[UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1.0].CGColor;
    
    self.roomnumberTextField.layer.masksToBounds = YES;
    self.addPICBtn.layer.cornerRadius=15;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.menuBtn addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.mapenableBtn.hidden=YES;
    self.mapdisableLabel.hidden=YES;
    self.scrollView.delegate = self;
    [self.scrollView setScrollEnabled:YES];
    
    [self.scrollView setContentSize:CGSizeMake(320,1250)];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touches)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.scrollView addGestureRecognizer:recognizer];
}

-(void)transactionOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.transectionTextField becomeFirstResponder];
    
}
-(void)typeOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.typeTextField becomeFirstResponder];
    
}
-(void)regionOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.regionTextField becomeFirstResponder];
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:@"0" forKey:@"regionid"];
    [defualt1 synchronize];
    
    [self.view endEditing:YES];
    [self.scrollView endEditing:YES];
    self.Tableview.hidden=NO;
    self.Serachbar.hidden=NO;
    [self.backButton2 setHidden:NO];
}

-(void)addressOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.addressTextField becomeFirstResponder];
}

-(void)priceOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.priceTextField becomeFirstResponder];
}

-(void)areaOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.areaTextField becomeFirstResponder];
}

-(void)roomNumberOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.roomnumberTextField becomeFirstResponder];
}

-(void)nameOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.nameTextField becomeFirstResponder];
}

-(void)phoneOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.phoneTextField becomeFirstResponder];
}

-(void)floorOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.floorTextField becomeFirstResponder];
}

-(void)nFloorOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.nofloorTextField becomeFirstResponder];
}

-(void)noRoomOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.noroomTextField becomeFirstResponder];
}

-(void)yearOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.yearTextField becomeFirstResponder];
}

-(void)kitchenOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.kitchenTextField becomeFirstResponder];
}

-(void)groundOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.groundTextField becomeFirstResponder];
}

-(void)positionOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.positionTextField becomeFirstResponder];
}

-(void)infoOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.infoTextField becomeFirstResponder];
}

-(void)mapOperations:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.mapTextField resignFirstResponder];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *view = (MapViewController *)[story instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self presentViewController:view animated:YES completion:nil];
}

-(void)popMapVC:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.mapTextField resignFirstResponder];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *view = (MapViewController *)[story instantiateViewControllerWithIdentifier:@"MapViewController"];
    //view.branchesArray = branchesArray;
    [self presentViewController:view animated:YES completion:nil];
}

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)viewDidDisappear:(BOOL)animated{
    NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
    [defualt setObject:@"0" forKey:@"edit"];
    [defualt synchronize];
}

#pragma mark -  NSTouch
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touches)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.scrollView addGestureRecognizer:recognizer];
    [self.transectionTextField resignFirstResponder];
    [self.roomnumberTextField resignFirstResponder];
}

#pragma mark -  Custom
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(IBAction)close{
    [self performSelector:@selector(DelayAction) withObject:nil afterDelay:0.1];
    self.Tableview.hidden=YES;
    self.Serachbar.hidden=YES;
    [self.Serachbar resignFirstResponder];
    
    //  [[self.view.superview.subviews firstObject]removeFromSuperview];
    // [topView removeFromSuperview];
    //[self.view bringSubviewToFront:self.view];
    //[self.searchDisplayController.searchResultsTableView setHidden:YES];
    //UIView *topView = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
    UIView *topView = [[self.view subviews] lastObject];
    [topView removeFromSuperview];
    
    //    [self.view sendSubviewToBack:self.searchDisplayController.searchResultsTableView];
    //    [self.view sendSubviewToBack:self.searchDisplayController.searchResultsTableView];
    //    [self.view bringSubviewToFront:self.searchDisplayController.searchResultsTableView];
    //
    //    [self.searchDisplayController.searchResultsTableView removeFromSuperview];
    
    // [[UIApplication sharedApplication].keyWindow addSubview: self.view];
    //[(self.view)sendSubviewToBack:self.searchDisplayController.searchResultsTableView];
    // [self.view bringSubviewToFront:self.view];
    // [self.searchDisplayController.searchBar removeFromSuperview];
    // [self.searchDisplayController.searchResultsTableView removeFromSuperview];
    
    // [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.view];
    // [self.searchDisplayController.searchResultsTableView.superview.superview bringSubviewToFront:self.searchDisplayController.searchResultsTableView.superview];
    // [self.searchDisplayController.searchBar setHidden:YES];
}
-(IBAction)upload{
    NSString *latitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"Latitude"];
    NSString *longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"Longitude"];
    NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
    if ([self.areaTextField.text isEqualToString:@""]||[self.nameTextField.text isEqualToString:@""]||[self.regionTextField.text isEqualToString:@""]||[self.transectionTextField.text isEqualToString:@""]||[self.typeTextField.text isEqualToString:@""]||[self.phoneTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"لطفا همه فیلد ها را کامل نمایید" delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        if ([[defualt objectForKey:@"edit"]isEqualToString:@"1"]) {
            [SVProgressHUD show];
            
            NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
            [fetchRequest setReturnsObjectsAsFaults:NO];
            EntityArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
            NSManagedObjectContext *managedObjectContext2 = [self managedObjectContext];
            NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc]initWithEntityName:@"Detail"];
            [fetchRequest2 setReturnsObjectsAsFaults:NO];
            detailArray = [[managedObjectContext2 executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
            
            NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"edit_domain_app"];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            
            if ([self.transectionTextField.text isEqualToString:@"رهن و اجاره"]){
                params[@"email"] =[EntityArray valueForKey:@"user"];
                params[@"password"] =[EntityArray valueForKey:@"pass"];
                params[@"TypeOfTransaction"] = self.transectionTextField.text;
                params[@"PropertyType"] = self.typeTextField.text;
                params[@"Region"] = self.regionFieldid.text;
                
                NSString *str3 = self.areaTextField.text;
                str3 = [ReplacerEngToPer replacer2:str3];
                params[@"Area"] = str3;
                
                NSLog(@"%@",str3);
                
                params[@"tabaghe"] = self.floorTextField.text;
                params[@"koleTabaghat"] = self.nofloorTextField.text;
                
                NSString *str7 = self.roomnumberTextField.text;
                str7 = [ReplacerEngToPer replacer2:str7];
                params[@"khab"] = str7; //@"0";
                
                params[@"Price"] = @"";
                NSString *str = self.rahnTextField.text;
                str = [ReplacerEngToPer replacer2:str];
                params[@"Rent"] = str;
                
                NSString *str2 = self.ejareTextField.text;
                str2 = [ReplacerEngToPer replacer2:str2];
                params[@"Mortgage"] = str2;
                params[@"kafpoosh"] = self.groundTextField.text;
                params[@"mogheiyat"] = self.positionTextField.text;
                params[@"ashpazkhane"] = self.kitchenTextField.text;
                params[@"Presenter"] = self.nameTextField.text;
                params[@"Tel"] = self.phoneTextField.text;
                params[@"Address"] = self.addressTextField.text;
                params[@"Tozihat"] = self.infoTextField.text;
                if ((latitude != nil) && (longitude != nil)) {
                    params[@"latitude"] = latitude;//self.viewMapLatStr;
                    params[@"longitude"] = longitude;//self.viewMapLongStr;
                }else{
                    params[@"latitude"] = @"";
                    params[@"longitude"] = @"";
                }
                params[@"IsForce"] = @"0";
                params[@"balkon"] = self.balkonStr;
                params[@"Asansoor"] = self.asansorStr;
                params[@"sona"] = self.sonaStr;
                params[@"jakozi"] = self.jakoziStr;
                params[@"parking"] = self.parkingStr;
                params[@"Anbari"] = self.anbariStr;
                if ((latitude != nil) && (longitude != nil)) {
                    params[@"latitude"] = latitude;//self.viewMapLatStr;
                    params[@"longitude"] = longitude;//self.viewMapLongStr;
                }else{
                    params[@"latitude"] = @"";
                    params[@"longitude"] = @"";
                }
                params[@"domain_id"] =[detailArray valueForKey:@"id"];
            }else{
                params[@"email"] =[EntityArray valueForKey:@"user"];
                params[@"password"] =[EntityArray valueForKey:@"pass"];
                params[@"domain_id"] =[detailArray valueForKey:@"id"];
                params[@"TypeOfTransaction"] = self.transectionTextField.text;
                params[@"PropertyType"] = self.typeTextField.text;
                params[@"Region"] = self.regionFieldid.text;
                
                NSString *str4 = self.areaTextField.text;
                str4 = [ReplacerEngToPer replacer2:str4];
                params[@"Area"] = str4;
                
                NSLog(@"%@",str4);
                
                params[@"tabaghe"] = self.floorTextField.text;
                params[@"koleTabaghat"] = self.nofloorTextField.text;
                
                NSString *str6 = self.roomnumberTextField.text;
                str6 = [ReplacerEngToPer replacer2:str6];
                params[@"khab"] = str6;//@"0";
                
                // params[@"khab"] = self.roomnumberTextField.text;
                
                NSString *str5 = self.priceTextField.text;
                str5 = [ReplacerEngToPer replacer2:str5];
                params[@"Price"] = str5;
                
                params[@"Rent"] = @"";
                params[@"Mortgage"] = @"";
                params[@"kafpoosh"] = self.groundTextField.text;
                params[@"mogheiyat"] = self.positionTextField.text;
                params[@"ashpazkhane"] = self.kitchenTextField.text;
                params[@"Presenter"] = self.nameTextField.text;
                params[@"Tel"] = self.phoneTextField.text;
                params[@"Address"] = self.addressTextField.text;
                params[@"Tozihat"] = self.infoTextField.text;
                if ((latitude != nil) && (longitude != nil)) {
                    params[@"latitude"] = latitude;//self.viewMapLatStr;
                    params[@"longitude"] = longitude;//self.viewMapLongStr;
                }else{
                    params[@"latitude"] = @"";
                    params[@"longitude"] = @"";
                }
                params[@"IsForce"] = @"0";
                params[@"balkon"] = self.balkonStr;
                params[@"Asansoor"] = self.asansorStr;
                params[@"sona"] = self.sonaStr;
                params[@"jakozi"] = self.jakoziStr;
                params[@"parking"] = self.parkingStr;
                params[@"Anbari"] = self.anbariStr;
                if ((latitude != nil) && (longitude != nil)) {
                    params[@"latitude"] = latitude;//self.viewMapLatStr;
                    params[@"longitude"] = longitude;//self.viewMapLongStr;
                }else{
                    params[@"latitude"] = @"";
                    params[@"longitude"] = @"";
                }
            }
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                [SVProgressHUD dismiss];
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        }else{
            NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
            [defualt setObject:self.transectionTextField.text forKey:@"TransectiontextField"];
            [defualt setObject:self.typeTextField.text forKey:@"TypetextField"];
            [defualt setObject:self.roomnumberTextField.text forKey:@"roomNumbertextField"];
            [defualt setObject:self.areaTextField.text forKey:@"areatextField"];
            [defualt setObject:self.ejareConvertorlabel.text forKey:@"ejareconvert"];
            [defualt setObject:self.rahnConvertorlabel.text forKey:@"rahnconvert"];
            [defualt setObject:self.rahnTextField.text forKey:@"rahntextField"];
            [defualt setObject:self.ejareTextField.text forKey:@"ejaretextField"];
            [defualt setObject:self.Convertorlabel.text forKey:@"Priceconvert"];
            [defualt setObject:self.priceTextField.text forKey:@"PricetextField"];
            [defualt setObject:self.addressTextField.text forKey:@"AddresstextField"];
            [defualt setObject:self.regionTextField.text forKey:@"RegiontextField"];
            //  [defualt setObject:self.IDAStr forKey:@"RegiontextField"];
            [defualt setObject:self.floorTextField.text forKey:@"floorTextField"];
            [defualt setObject:self.nofloorTextField.text forKey:@"noFloortextField"];
            [defualt setObject:self.noroomTextField.text forKey:@"noRoomtextField"];
            [defualt setObject:self.yearTextField.text forKey:@"yeartextField"];
            [defualt setObject:self.kitchenTextField.text forKey:@"kitchentextField"];
            [defualt setObject:self.groundTextField.text forKey:@"groundtextField"];
            [defualt setObject:self.positionTextField.text forKey:@"positiontextField"];
            [defualt setObject:self.mapTextField.text forKey:@"maptextField"];
            [defualt setObject:self.infoTextField.text forKey:@"iNFOtextField"];
            [defualt setObject:self.nameTextField.text forKey:@"nametextField"];
            [defualt setObject:self.phoneTextField.text forKey:@"phonetextField"];
            [defualt setObject:self.balkonStr forKey:@"balkonStr"];
            [defualt setObject:self.parkingStr forKey:@"parkingStr"];
            [defualt setObject:self.asansorStr forKey:@"asansorStr"];
            [defualt setObject:self.sonaStr forKey:@"sonaStr"];
            [defualt setObject:self.abStr forKey:@"abStr"];
            [defualt setObject:self.gazStr forKey:@"gazStr"];
            [defualt setObject:self.barghStr forKey:@"barghStr"];
            [defualt setObject:self.anbariStr forKey:@"anbariStr"];
            [defualt setObject:self.estahkrStr forKey:@"estahkrStr"];
            [defualt setObject:self.jakoziStr forKey:@"jakoziStr"];
            [defualt setObject:self.mogeiatStr forKey:@"mogeiatStr"];
            [defualt setObject:self.viewMapLatStr forKey:@"viewMapLatStr"];
            [defualt setObject:self.viewMapLongStr forKey:@"viewMapLongStr"];
            [defualt setObject:self.MapLatStr forKey:@"MapLatStr"];
            [defualt setObject:self.MapLongStr forKey:@"MapLongStr"];
            [defualt setObject:self.mogeiatStr forKey:@"mogeiatStr"];
            [defualt setObject:@"4" forKey:@"backID"];
            [defualt setObject:@"1" forKey:@"ID"];
            [defualt setObject:imagesDataArray forKey:@"imagesDataArray"];
            [defualt synchronize];
            [self performSegueWithIdentifier:@"Preview" sender:self];
        }
    }
}

-(void)touches{
    [self.transectionTextField resignFirstResponder];
    [self.typeTextField resignFirstResponder];
    [self.roomnumberTextField resignFirstResponder];
    [self.positionTextField resignFirstResponder];
    [self.infoTextField resignFirstResponder];
    [self.kitchenTextField resignFirstResponder];
    [self.groundTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.priceTextField resignFirstResponder];
    [self.areaTextField resignFirstResponder];
    [self.floorTextField resignFirstResponder];
    [self.yearTextField resignFirstResponder];
    [self.noroomTextField resignFirstResponder];
    [self.nofloorTextField resignFirstResponder];
    [self.ejareTextField resignFirstResponder];
    [self.rahnTextField resignFirstResponder];
    [self.Serachbar resignFirstResponder];
}

-(IBAction)AddDetails{
    self.detailScrollview.hidden=NO;
    self.DetailsBtn.hidden=YES;
    //[self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,1900, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
    [self.EditBtn setFrame:CGRectMake(self.EditBtn.frame.origin.x,1900, self.EditBtn.frame.size.width,self.EditBtn.frame.size.height)];
    if (imagesScrollView.frame.size.height>0) {
        self.detailScrollview.frame=CGRectMake(self.detailScrollview.frame.origin.x, 1040, self.detailScrollview.frame.size.width, self.detailScrollview.frame.size.height);
        [self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,2000, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
        [self.scrollView setContentSize:CGSizeMake(320,2110)];
    }else{
        self.detailScrollview.frame=CGRectMake(self.detailScrollview.frame.origin.x, 930, self.detailScrollview.frame.size.width, self.detailScrollview.frame.size.height);
        [self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,1900, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
        [self.scrollView setContentSize:CGSizeMake(320,2010)];
    }
    [self.scrollView setScrollEnabled:YES];
}

-(IBAction)getregion{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:@"0" forKey:@"regionid"];
    [defualt1 synchronize];
    [self.view endEditing:YES];
    [self.scrollView endEditing:YES];
    self.Tableview.hidden=NO;
    self.Serachbar.hidden=NO;
    [self.backButton2 setHidden:NO];
}

-(void)DelayAction{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    self.regionTextField.text=[defualt1 valueForKey:@"AName"];
    self.regionFieldid.text=[defualt1 valueForKey:@"id"];
}

-(void)addPickerView{
    TransectionPickerView = [[UIPickerView alloc]init];
    //TransectionPickerView.dataSource = self;
    TransectionPickerView.delegate = self;
    TransectionPickerView.showsSelectionIndicator = YES;
    TransectionPickerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.transectionTextField.inputView = TransectionPickerView;
    
    TypePickerView = [[UIPickerView alloc]init];
    //TypePickerView.dataSource = self;
    TypePickerView.delegate = self;
    TypePickerView.showsSelectionIndicator = YES;
    TypePickerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.typeTextField.inputView = TypePickerView;
    
    roomNumberPickerView = [[UIPickerView alloc]init];
    //roomNumberPickerView.dataSource = self;
    roomNumberPickerView.delegate = self;
    roomNumberPickerView.showsSelectionIndicator = YES;
    roomNumberPickerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.roomnumberTextField.inputView = roomNumberPickerView;
    
    positionPickerView = [[UIPickerView alloc]init];
    //positionPickerView.dataSource = self;
    positionPickerView.delegate = self;
    positionPickerView.showsSelectionIndicator = YES;
    positionPickerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.positionTextField.inputView = positionPickerView;
    
    kitchenPickerView = [[UIPickerView alloc]init];
    //kitchenPickerView.dataSource = self;
    kitchenPickerView.delegate = self;
    kitchenPickerView.showsSelectionIndicator = YES;
    kitchenPickerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.kitchenTextField.inputView = kitchenPickerView;
    
    groundPickerView = [[UIPickerView alloc]init];
    //groundPickerView.dataSource = self;
    groundPickerView.delegate = self;
    groundPickerView.showsSelectionIndicator = YES;
    groundPickerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.groundTextField.inputView = groundPickerView;
    
    PickerViewTabaghe = [[UIPickerView alloc]init];
    //PickerViewTabaghe.dataSource = self;
    PickerViewTabaghe.delegate = self;
    PickerViewTabaghe.showsSelectionIndicator = YES;
    PickerViewTabaghe.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.floorTextField.inputView = PickerViewTabaghe;
    
    if (usersdetail.count==0){
    }else{
        PickerViewUsers = [[UIPickerView alloc]init];
        //PickerViewUsers.dataSource = self;
        PickerViewUsers.delegate = self;
        PickerViewUsers.showsSelectionIndicator = YES;
        PickerViewUsers.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.nameTextField.inputView = PickerViewUsers;
    }
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

-(void) setLatLongText{
    NSString *latitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"Latitude"];
    NSString *longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"Longitude"];
    if ((latitude != nil) && (longitude != nil)) {
        self.mapdisableLabel.hidden = NO;
        self.mapenableBtn.hidden = NO;
        self.mapTextField.text = [NSString stringWithFormat:@"%@ , %@" , latitude,longitude];
    }
}

- (IBAction)AddImageButtonAction:(id)sender {
    [self uploadImageButtonAction];
    if (self.detailScrollview.hidden) {
        [imagesScrollView setFrame:CGRectMake(0, 940, screenWidth, 110)];
        self.scrollView.contentSize = CGSizeMake(screenWidth,screenHeight+800);
        //[self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,self.DetailsBtn.frame.origin.y+self.DetailsBtn.frame.size.height+10, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
        CGRect rect3 = self.AddNew.frame;
        rect3.origin.y = imagesScrollView.frame.origin.y+imagesScrollView.frame.size.height+10;
        self.AddNew.frame = rect3;
        
        CGRect rect = self.DetailsBtn.frame;
        rect.origin.y = imagesScrollView.frame.origin.y+imagesScrollView.frame.size.height+55;
        self.DetailsBtn.frame = rect;
    }else{
        [imagesScrollView setFrame:CGRectMake(0, 940, screenWidth, 110)];
        [self.detailScrollview setFrame:CGRectMake(self.detailScrollview.frame.origin.x,imagesScrollView.frame.origin.y+imagesScrollView.frame.size.height+10, self.detailScrollview.frame.size.width,self.detailScrollview.frame.size.height)];
        [self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,2000, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
        self.scrollView.contentSize = CGSizeMake(320,2110);
    }
    imagesScrollView.showsVerticalScrollIndicator = NO;
    imagesScrollView.showsHorizontalScrollIndicator = NO;
    imagesScrollView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:imagesScrollView];
    //imagesScrollView.contentSize = CGSizeMake(screenWidth/3.25*10.5, 100);
}

- (void)uploadImageButtonAction{
    [self showgalleryCameraMenu];
}

-(void) AddImageView:(UIImage *)choosenImage{
    [self removeImages];
    [imagesArray addObject:choosenImage];
    if (choosenImage) {
        imageData = [NSData dataWithData:UIImagePNGRepresentation(choosenImage)];
        [imagesDataArray addObject:imageData];
    }
    [self makeImagesScrollView];
}

- (void)removeTapGestureAction:(UITapGestureRecognizer*)tap{
    for (UIView *view in imagesScrollView.subviews) {
        //if ([view isKindOfClass:[UIImageView class]]) {
        [view removeFromSuperview];
        //  }
    }
    [imagesArray removeObjectAtIndex: tap.view.tag];
    [imagesDataArray removeObjectAtIndex:tap.view.tag];
    [self makeImagesScrollView];
}

- (void)removeImages{
    for (UIView *view in [imagesScrollView subviews]) {
        [view removeFromSuperview];
    }
}
-(void) makeImagesScrollView{
    CGFloat xPos = 10;
    if ([imagesArray count]==0) {
        [imagesScrollView removeFromSuperview];
        if (self.detailScrollview.hidden) {
            [imagesScrollView setFrame:CGRectMake(0, 900, screenWidth, 0)];
            self.scrollView.contentSize = CGSizeMake(screenWidth,screenHeight+800);
            //[self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,self.DetailsBtn.frame.origin.y+self.DetailsBtn.frame.size.height+10, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
            CGRect rect3 = self.AddNew.frame;
            rect3.origin.y = imagesScrollView.frame.origin.y+imagesScrollView.frame.size.height+80;
            self.AddNew.frame = rect3;
            
            CGRect rect = self.DetailsBtn.frame;
            rect.origin.y = imagesScrollView.frame.origin.y+imagesScrollView.frame.size.height+40;
            self.DetailsBtn.frame = rect;
        }else{
            [imagesScrollView setFrame:CGRectMake(0, 900, screenWidth, 0)];
            self.detailScrollview.frame=CGRectMake(self.detailScrollview.frame.origin.x, 930, self.detailScrollview.frame.size.width, self.detailScrollview.frame.size.height);
            [self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,1900, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
            self.scrollView.contentSize = CGSizeMake(320,2010);
        }
    }
    for (int j=0; j<[imagesArray count]; j++) {
        imageView = [CustomImageView initImageViewWithImage:@"" withFrame:CGRectMake(xPos,15,screenWidth/3.25,100)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [imagesArray objectAtIndex:j];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = j;
        [imagesScrollView addSubview: imageView];
        
        removeImageView = [CustomImageView initImageViewWithImage:@"" withFrame:CGRectMake(((screenWidth/3.25)/2)-15,-15,30, 30)];
        removeImageView.backgroundColor = [UIColor clearColor];
        removeImageView.image = [UIImage imageNamed:@"cancelImage"];
        removeImageView.tag = j;
        [imageView addSubview:removeImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeTapGestureAction:)];
        removeImageView.userInteractionEnabled = YES;
        [removeImageView addGestureRecognizer:tapGesture];
        
        xPos = xPos+imageView.frame.size.width+3;
    }
    imagesScrollView.contentSize = CGSizeMake((screenWidth/3.25*[imagesArray count]+30), 110);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"Preview"]) {
        DetailViewController *view = [segue destinationViewController];
        view.isDetailOfAdd = YES;
    }
}
- (IBAction)backButtonActionADD:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backButton2:(id)sender {
    [self.view endEditing:YES];
    [self.scrollView endEditing:YES];
    self.Tableview.hidden=YES;
    self.Serachbar.hidden=YES;
    [self.backButton2 setHidden:YES];
}

#pragma mark -  TableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    ListTableViewCell *cell = (ListTableViewCell *)[self.Tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //if (tableView == self.searchDisplayController.searchResultsTableView) {
    if(self.isFiltered == YES){
        // [self.searchDisplayController.searchResultsTableView.separatorColor= [UIColor clearColor]CGColor];
        cell.nameLabel.text=[[searchResults2 objectAtIndex:indexPath.row]valueForKey:@"location"];
        cell.locationLabel.text=[[searchResults2 objectAtIndex:indexPath.row]valueForKey:@"location"];
        cell.IDlabel.text=[[searchResults2 objectAtIndex:indexPath.row]valueForKey:@"id"];
    }else{
        cell.nameLabel.text=[[ResultArray objectAtIndex:indexPath.row]valueForKey:@"location"];
        cell.locationLabel.text=[citystringArray objectAtIndex:indexPath.row];
        cell.IDlabel.text=[[ResultArray objectAtIndex:indexPath.row]valueForKey:@"id"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //if (tableView == self.searchDisplayController.searchResultsTableView) {
    if(self.isFiltered == YES){
        return [searchResults2 count];
    }else{
        return [regionname count];
    }
}
#pragma mark -  Search
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        self.isFiltered = NO;
        //  self.searchButoon.hidden = NO;
        [searchBar performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
        [self.Tableview reloadData];
    }else{
        self.isFiltered = YES;
        NSString *str = [searchText stringByReplacingOccurrencesOfString:@"ي" withString:@"ی"];
        NSString *st2 = [str stringByReplacingOccurrencesOfString:@"ك" withString:@"ک"];
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"location contains[c] %@", st2];
        //   searchResults = [tableArray filteredArrayUsingPredicate:resultPredicate];
        searchResults2 = [ResultArray filteredArrayUsingPredicate:resultPredicate];
        [self.Tableview reloadData];
    }
}
#pragma mark - PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if (pickerView==TransectionPickerView){
        return [transactionarray count];
    }
    if (pickerView==TypePickerView) {
        return [typearray count];
    }
    if (pickerView==roomNumberPickerView) {
        return [Roomarray count];
    }
    if (pickerView==positionPickerView) {
        return [positionarray count];
    }
    if (pickerView==kitchenPickerView) {
        return [kitchenarray count];
    }
    if (pickerView==groundPickerView) {
        return [groundarray count];
    }
    if (pickerView==PickerViewTabaghe) {
        return [Tabaghearray count];
    }
    if (pickerView==PickerViewUsers) {
        return [usersdetail count];
    }
    return NO;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView==TransectionPickerView) {
        [self.transectionTextField setText:[transactionarray objectAtIndex:row]];
        NSLog(@"%ld",(long)row);
        self.TranrowStr = [NSString stringWithFormat:@"%ld",(long)row];
        
        if ([self.transectionTextField.text isEqualToString:@"رهن و اجاره"]||[self.transectionTextField.text isEqualToString:@"اجاره موقت"]) {
            self.priceTextField.hidden=YES;
            self.rahnTextField.hidden=NO;
            self.ejareTextField.hidden=NO;
            self.Convertorlabel.hidden=YES;
            self.rahnConvertorlabel.text=@"";
            self.ejareConvertorlabel.text=@"";
            self.rahnConvertorlabel.hidden=NO;
            self.ejareConvertorlabel.hidden=NO;
        }else{
            self.priceTextField.hidden=NO;
            self.rahnTextField.hidden=YES;
            self.ejareTextField.hidden=YES;
            self.Convertorlabel.hidden=NO;
            self.Convertorlabel.text=@"";
            self.rahnConvertorlabel.hidden=YES;
            self.ejareConvertorlabel.hidden=YES;
        }
        //   [pickerView setHidden:YES];
        NSLog(@"%@",self.TranrowStr);
    }
    if (pickerView==TypePickerView) {
        [self.typeTextField setText:[typearray objectAtIndex:row]];
        NSLog(@"%ld",(long)row);
        self.TyperowStr = [NSString stringWithFormat:@"%ld",(long)row];
    }
    if (pickerView==roomNumberPickerView) {
        [self.roomnumberTextField setText:[Roomarray objectAtIndex:row]];
    }
    if (pickerView==positionPickerView) {
        [self.positionTextField setText:[positionarray objectAtIndex:row]];
    }
    if (pickerView==kitchenPickerView) {
        [self.kitchenTextField setText:[kitchenarray objectAtIndex:row]];
    }
    if (pickerView==groundPickerView) {
        [self.groundTextField setText:[groundarray objectAtIndex:row]];
    }
    if (pickerView==PickerViewTabaghe) {
        [self.floorTextField setText:[Tabaghearray objectAtIndex:row]];
    }
    if (pickerView==PickerViewUsers) {
        [self.nameTextField setText:[usersdetail objectAtIndex:row]];
        self.phoneTextField.text=[usersphoneArray objectAtIndex:row];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView==TransectionPickerView) {
        return [transactionarray objectAtIndex:row];
    }
    if (pickerView==TypePickerView) {
        return [typearray objectAtIndex:row];
    }
    if (pickerView==roomNumberPickerView) {
        return [Roomarray objectAtIndex:row];
    }
    if (pickerView==positionPickerView) {
        return [positionarray objectAtIndex:row];
    }
    if (pickerView==kitchenPickerView) {
        return [kitchenarray objectAtIndex:row];
    }
    if (pickerView==groundPickerView) {
        return [groundarray objectAtIndex:row];
    }
    if (pickerView==PickerViewTabaghe) {
        return [Tabaghearray objectAtIndex:row];
    }
    if (pickerView==PickerViewUsers) {
        return [usersdetail objectAtIndex:row];
    }
    return 0;
}
#pragma mark -  TextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag==1){
        if ([textField.text length] >= MAX_LENGTH){
            self.nofloorTextField.text = [textField.text substringToIndex:MAX_LENGTH-1];
            return NO;
        }
    }
    if (textField.tag==2){
        if ([textField.text length] >= MAX_LENGTH){
            self.yearTextField.text = [textField.text substringToIndex:MAX_LENGTH-1];
            return NO;
        }
    }
    if (textField.tag==3) {
        if ([textField.text length] >= MAX_LENGTH){
            self.noroomTextField.text = [textField.text substringToIndex:MAX_LENGTH-1];
            return NO;
        }
    }
    if (textField.tag==4) {
        if ([textField.text length] >= MAX_LENGTH3){
            self.rahnTextField.text = [self.rahnTextField.text substringToIndex:MAX_LENGTH3-1];
            return NO;
        }
    }
    if (textField.tag==5) {
        if ([textField.text length] >= MAX_LENGTH2){
            self.ejareTextField.text = [self.ejareTextField.text substringToIndex:MAX_LENGTH2-1];
            return NO;
        }
    }
    if (textField.tag==6) {
        if ([textField.text length] >= MAX_LENGTH3){
            self.priceTextField.text = [self.priceTextField.text substringToIndex:MAX_LENGTH3-1];
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    TransectionPickerView;
//    UIPickerView *TypePickerView;
//    UIPickerView *roomNumberPickerView;
//    UIPickerView *positionPickerView;
//    UIPickerView *kitchenPickerView;
//    UIPickerView *groundPickerView;
//    UIPickerView *PickerViewTabaghe
    if (textField.inputView == TransectionPickerView) {
        [self.view endEditing:true];
        [self.scrollView endEditing:true];
        [self addPickerView];
    }
    if (textField.inputView == TypePickerView) {
        [self.view endEditing:YES];
        [self.scrollView endEditing:YES];
       [self addPickerView];
    }
    if (textField.inputView == roomNumberPickerView) {
        [self.view endEditing:YES];
        [self.scrollView endEditing:YES];
        //[self showTypePickerView];
    }
    if (textField.inputView == positionPickerView) {
        [self.view endEditing:YES];
        [self.scrollView endEditing:YES];
        [self addPickerView];
    }
    if (textField.inputView == kitchenPickerView) {
        [self.view endEditing:YES];
        [self.scrollView endEditing:YES];
        [self addPickerView];
    }
    if (textField.inputView == groundPickerView) {
        [self.view endEditing:YES];
        [self.scrollView endEditing:YES];
        [self addPickerView];
    }
    if (textField.inputView == PickerViewTabaghe) {
        [self.view endEditing:YES];
        [self.scrollView endEditing:YES];
    }
    return YES;
}

-(void)textFieldDidChange :(UITextField *) textField{
    
    if ([self.transectionTextField.text isEqualToString:@"رهن"]) {
        
        if ([self.priceTextField.text length] == 0){
            self.Convertorlabel.text=@"";
        }
        if ([self.ejareTextField.text length] == 0){
            self.ejareConvertorlabel.text=@"";
        }
        if ([self.rahnTextField.text length] == 0){
            self.rahnConvertorlabel.text=@"";
        }
        if ([self.priceTextField.text length] == 1){
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@",self.priceTextField.text,@" میلیون تومان"];
        }
        if ([self.priceTextField.text length] == 2){
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@",self.priceTextField.text,@" میلیون تومان"];
        }
        if ([self.priceTextField.text length] == 3){
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@",self.priceTextField.text,@" میلیون تومان"];
        }
        if ([self.priceTextField.text length] == 4){
            NSString*text2=[self.priceTextField.text substringToIndex:1];
            NSString*text3=[self.priceTextField.text substringWithRange:(NSMakeRange(1, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]){
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]){
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@" میلیون تومان "];
            if ([self.priceTextField.text isEqualToString:@"1000"]) {
                self.Convertorlabel.text=@"۱ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"2000"]) {
                self.Convertorlabel.text=@"۲ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"3000"]) {
                self.Convertorlabel.text=@"۳ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"4000"]) {
                self.Convertorlabel.text=@"۴ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"5000"]) {
                self.Convertorlabel.text=@"۵ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"6000"]) {
                self.Convertorlabel.text=@"۶ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"7000"]) {
                self.Convertorlabel.text=@"۷ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"8000"]) {
                self.Convertorlabel.text=@"۸ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"9000"]) {
                self.Convertorlabel.text=@"۹ میلیارد تومان";
            }
        }
        if ([self.priceTextField.text length] == 5){
            NSString*text2=[self.priceTextField.text substringToIndex:2];
            NSString*text3=[self.priceTextField.text substringWithRange:(NSMakeRange(2,3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]){
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]){
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@" میلیون تومان "];
            if ([self.priceTextField.text isEqualToString:@"10000"]) {
                self.Convertorlabel.text=@"۱۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"20000"]) {
                self.Convertorlabel.text=@"۲۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"30000"]) {
                self.Convertorlabel.text=@"۳۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"40000"]) {
                self.Convertorlabel.text=@"۴۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"50000"]) {
                self.Convertorlabel.text=@"۵۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"60000"]) {
                self.Convertorlabel.text=@"۶۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"70000"]) {
                self.Convertorlabel.text=@"۷۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"80000"]) {
                self.Convertorlabel.text=@"۸۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"90000"]) {
                self.Convertorlabel.text=@"۹۰ میلیارد تومان";
            }
        }
        if ([self.priceTextField.text length] == 6){
            NSString*text2=[self.priceTextField.text substringToIndex:3];
            NSString*text3=[self.priceTextField.text substringWithRange:(NSMakeRange(3, 3))];
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@" میلیون تومان"];
            if ([self.priceTextField.text isEqualToString:@"100000"]) {
                self.Convertorlabel.text=@"۱۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"200000"]) {
                self.Convertorlabel.text=@"۲۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"300000"]) {
                self.Convertorlabel.text=@"۳۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"400000"]) {
                self.Convertorlabel.text=@"۴۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"500000"]) {
                self.Convertorlabel.text=@"۵۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"600000"]) {
                self.Convertorlabel.text=@"۶۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"700000"]) {
                self.Convertorlabel.text=@"۷۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"800000"]) {
                self.Convertorlabel.text=@"۸۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"900000"]) {
                self.Convertorlabel.text=@"۹۰۰ میلیارد تومان";
            }
        }
    }else{
        if ([self.priceTextField.text length] == 0){
            self.Convertorlabel.text=@"";
        }
        if ([self.ejareTextField.text length] == 0){
            self.ejareConvertorlabel.text=@"";
        }
        if ([self.rahnTextField.text length] == 0){
            self.rahnConvertorlabel.text=@"";
        }
        if ([self.priceTextField.text length] == 1){
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@",self.priceTextField.text,@"میلیون تومان"];
        }
        if ([self.priceTextField.text length] == 2){
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@",self.priceTextField.text,@"میلیون تومان"];
        }
        if ([self.priceTextField.text length] == 3){
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@",self.priceTextField.text,@"میلیون تومان"];
        }
        if ([self.priceTextField.text length] == 4){
            NSString*text2=[self.priceTextField.text substringToIndex:1];
            NSString*text3=[self.priceTextField.text substringWithRange:(NSMakeRange(1, 3))];
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            if ([self.priceTextField.text isEqualToString:@"1000"]) {
                self.Convertorlabel.text=@"۱ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"2000"]) {
                self.Convertorlabel.text=@"۲ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"3000"]) {
                self.Convertorlabel.text=@"۳ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"4000"]) {
                self.Convertorlabel.text=@"۴ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"5000"]) {
                self.Convertorlabel.text=@"۵ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"6000"]) {
                self.Convertorlabel.text=@"۶ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"7000"]) {
                self.Convertorlabel.text=@"۷ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"8000"]) {
                self.Convertorlabel.text=@"۸ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"9000"]) {
                self.Convertorlabel.text=@"۹ میلیارد تومان";
            }
        }
        if ([self.priceTextField.text length] == 5){
            NSString*text2=[self.priceTextField.text substringToIndex:2];
            NSString*text3=[self.priceTextField.text substringWithRange:(NSMakeRange(2,3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            if ([self.priceTextField.text isEqualToString:@"10000"]) {
                self.Convertorlabel.text=@"۱۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"20000"]) {
                self.Convertorlabel.text=@"۲۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"30000"]) {
                self.Convertorlabel.text=@"۳۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"40000"]) {
                self.Convertorlabel.text=@"۴۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"50000"]) {
                self.Convertorlabel.text=@"۵۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"60000"]) {
                self.Convertorlabel.text=@"۶۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"70000"]) {
                self.Convertorlabel.text=@"۷۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"80000"]) {
                self.Convertorlabel.text=@"۸۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"90000"]) {
                self.Convertorlabel.text=@"۹۰ میلیارد تومان";
            }
        }
        if ([self.priceTextField.text length] == 6){
            NSString*text2=[self.priceTextField.text substringToIndex:3];
            NSString*text3=[self.priceTextField.text substringWithRange:(NSMakeRange(3, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            self.Convertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            if ([self.priceTextField.text isEqualToString:@"100000"]) {
                self.Convertorlabel.text=@"۱۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"200000"]) {
                self.Convertorlabel.text=@"۲۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"300000"]) {
                self.Convertorlabel.text=@"۳۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"400000"]) {
                self.Convertorlabel.text=@"۴۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"500000"]) {
                self.Convertorlabel.text=@"۵۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"600000"]) {
                self.Convertorlabel.text=@"۶۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"700000"]) {
                self.Convertorlabel.text=@"۷۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"800000"]) {
                self.Convertorlabel.text=@"۸۰۰ میلیارد تومان";
            }
            if ([self.priceTextField.text isEqualToString:@"900000"]) {
                self.Convertorlabel.text=@"۹۰۰ میلیارد تومان";
            }
        }
    }
    if ([self.rahnTextField.text length] == 5){
        NSString*text2=[self.rahnTextField.text substringToIndex:2];
        NSString*text3=[self.rahnTextField.text substringWithRange:(NSMakeRange(2,3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        self.rahnConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
        if ([self.rahnTextField.text isEqualToString:@"10000"]) {
            self.rahnConvertorlabel.text=@"۱۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"20000"]) {
            self.rahnConvertorlabel.text=@"۲۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"30000"]) {
            self.rahnConvertorlabel.text=@"۳۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"40000"]) {
            self.rahnConvertorlabel.text=@"۴۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"50000"]) {
            self.rahnConvertorlabel.text=@"۵۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"60000"]) {
            self.rahnConvertorlabel.text=@"۶۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"70000"]) {
            self.rahnConvertorlabel.text=@"۷۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"80000"]) {
            self.rahnConvertorlabel.text=@"۸۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"90000"]) {
            self.rahnConvertorlabel.text=@"۹۰ میلیارد تومان";
        }
    }
    if ([self.rahnTextField.text length] == 6){
        NSString*text2=[self.rahnTextField.text substringToIndex:3];
        NSString*text3=[self.rahnTextField.text substringWithRange:(NSMakeRange(3, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
            
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        self.rahnConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
        if ([self.rahnTextField.text isEqualToString:@"100000"]) {
            self.rahnConvertorlabel.text=@"۱۰۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"200000"]) {
            self.rahnConvertorlabel.text=@"۲۰۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"300000"]) {
            self.rahnConvertorlabel.text=@"۳۰۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"400000"]) {
            self.rahnConvertorlabel.text=@"۴۰۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"500000"]) {
            self.rahnConvertorlabel.text=@"۵۰۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"600000"]) {
            self.rahnConvertorlabel.text=@"۶۰۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"700000"]) {
            self.rahnConvertorlabel.text=@"۷۰۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"800000"]) {
            self.rahnConvertorlabel.text=@"۸۰۰ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"900000"]) {
            self.rahnConvertorlabel.text=@"۹۰۰ میلیارد تومان";
        }
    }
    if ([self.rahnTextField.text length] == 4){
        NSString*text2=[self.rahnTextField.text substringToIndex:1];
        NSString*text3=[self.rahnTextField.text substringWithRange:(NSMakeRange(1, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
            
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        self.rahnConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"  و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
        
        if ([self.rahnTextField.text isEqualToString:@"1000"]) {
            self.rahnConvertorlabel.text=@"۱ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"2000"]) {
            self.rahnConvertorlabel.text=@"۲ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"3000"]) {
            self.rahnConvertorlabel.text=@"۳ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"4000"]) {
            self.rahnConvertorlabel.text=@"۴ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"5000"]) {
            self.rahnConvertorlabel.text=@"۵ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"6000"]) {
            self.rahnConvertorlabel.text=@"۶ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"7000"]) {
            self.rahnConvertorlabel.text=@"۷ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"8000"]) {
            self.rahnConvertorlabel.text=@"۸ میلیارد تومان";
        }
        if ([self.rahnTextField.text isEqualToString:@"9000"]) {
            self.rahnConvertorlabel.text=@"۹ میلیارد تومان";
        }
    }
    if ([self.rahnTextField.text length] == 1){
        self.rahnConvertorlabel.text=[NSString stringWithFormat:@"%@%@",self.rahnTextField.text,@" میلیون تومان"];
    }
    if ([self.rahnTextField.text length] == 2){
        self.rahnConvertorlabel.text=[NSString stringWithFormat:@"%@%@",self.rahnTextField.text,@" میلیون تومان"];
    }
    if ([self.rahnTextField.text length] == 3){
        self.rahnConvertorlabel.text=[NSString stringWithFormat:@"%@%@",self.rahnTextField.text,@" میلیون تومان"];
    }
    if ([self.ejareTextField.text length] == 9){
        NSString*text2=[self.ejareTextField.text substringToIndex:3];
        NSString*text3=[self.ejareTextField.text substringWithRange:(NSMakeRange(3, 3))];
        NSString*text4=[self.ejareTextField.text substringWithRange:(NSMakeRange(6, 3))];
        
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار ",@"و",[text4 substringToIndex:[text4 length]],@"تومان"];
        if ([self.ejareTextField.text isEqualToString:@"100000000"]) {
            self.ejareConvertorlabel.text=@"۱۰۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"200000000"]) {
            self.ejareConvertorlabel.text=@"۲۰۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"300000000"]) {
            self.ejareConvertorlabel.text=@"۳۰۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"400000000"]) {
            self.ejareConvertorlabel.text=@"۴۰۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"500000000"]) {
            self.ejareConvertorlabel.text=@"۵۰۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"600000000"]) {
            self.ejareConvertorlabel.text=@"۶۰۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"700000000"]) {
            self.ejareConvertorlabel.text=@"۷۰۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"800000000"]) {
            self.ejareConvertorlabel.text=@"۸۰۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"900000000"]) {
            self.ejareConvertorlabel.text=@"۹۰۰ میلیون تومان";
        }
    }
    if ([self.ejareTextField.text length] == 8){
        NSString*text2=[self.ejareTextField.text substringToIndex:2];
        NSString*text3=[self.ejareTextField.text substringWithRange:(NSMakeRange(2,3))];
        NSString*text4=[self.ejareTextField.text substringWithRange:(NSMakeRange(5, 3))];
        
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار ",@"و",[text4 substringToIndex:[text4 length]],@"تومان"];
        if ([self.ejareTextField.text isEqualToString:@"10000000"]) {
            self.ejareConvertorlabel.text=@"۱۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"20000000"]) {
            self.ejareConvertorlabel.text=@"۲۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"30000000"]) {
            self.ejareConvertorlabel.text=@"۳۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"40000000"]) {
            self.ejareConvertorlabel.text=@"۴۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"50000000"]) {
            self.ejareConvertorlabel.text=@"۵۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"60000000"]) {
            self.ejareConvertorlabel.text=@"۶۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"70000000"]) {
            self.ejareConvertorlabel.text=@"۷۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"80000000"]) {
            self.ejareConvertorlabel.text=@"۸۰ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"90000000"]) {
            self.ejareConvertorlabel.text=@"۹۰ میلیون تومان";
        }
    }
    if ([self.ejareTextField.text length] == 7){
        NSString*text2=[self.ejareTextField.text substringToIndex:1];
        NSString*text3=[self.ejareTextField.text substringWithRange:(NSMakeRange(1, 3))];
        NSString*text4=[self.ejareTextField.text substringWithRange:(NSMakeRange(4, 3))];
        
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار ",@"و",[text4 substringToIndex:[text4 length]],@"تومان"];
        if ([self.ejareTextField.text isEqualToString:@"1000000"]) {
            self.ejareConvertorlabel.text=@"۱ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"2000000"]) {
            self.ejareConvertorlabel.text=@"۲ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"3000000"]) {
            self.ejareConvertorlabel.text=@"۳ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"4000000"]) {
            self.ejareConvertorlabel.text=@"۴ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"5000000"]) {
            self.ejareConvertorlabel.text=@"۵ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"6000000"]) {
            self.ejareConvertorlabel.text=@"۶ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"7000000"]) {
            self.ejareConvertorlabel.text=@"۷ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"8000000"]) {
            self.ejareConvertorlabel.text=@"۸ میلیون تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"9000000"]) {
            self.ejareConvertorlabel.text=@"۹ میلیون تومان";
        }
    }
    if ([self.ejareTextField.text length] == 6){
        NSString*text2=[self.ejareTextField.text substringToIndex:3];
        NSString*text3=[self.ejareTextField.text substringWithRange:(NSMakeRange(3, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
        if ([self.ejareTextField.text isEqualToString:@"100000"]) {
            self.ejareConvertorlabel.text=@"۱۰۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"200000"]) {
            self.ejareConvertorlabel.text=@"۲۰۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"300000"]) {
            self.ejareConvertorlabel.text=@"۳۰۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"400000"]) {
            self.ejareConvertorlabel.text=@"۴۰۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"500000"]) {
            self.ejareConvertorlabel.text=@"۵۰۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"600000"]) {
            self.ejareConvertorlabel.text=@"۶۰۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"700000"]) {
            self.ejareConvertorlabel.text=@"۷۰۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"800000"]) {
            self.ejareConvertorlabel.text=@"۸۰۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"900000"]) {
            self.ejareConvertorlabel.text=@"۹۰۰ هزار تومان";
        }
    }
    if ([self.ejareTextField.text length] == 5){
        NSString*text2=[self.ejareTextField.text substringToIndex:2];
        NSString*text3=[self.ejareTextField.text substringWithRange:(NSMakeRange(2, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
        if ([self.ejareTextField.text isEqualToString:@"10000"]) {
            self.ejareConvertorlabel.text=@"۱۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"20000"]) {
            self.ejareConvertorlabel.text=@"۲۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"30000"]) {
            self.ejareConvertorlabel.text=@"۳۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"40000"]) {
            self.ejareConvertorlabel.text=@"۴۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"50000"]) {
            self.ejareConvertorlabel.text=@"۵۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"60000"]) {
            self.ejareConvertorlabel.text=@"۶۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"70000"]) {
            self.ejareConvertorlabel.text=@"۷۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"80000"]) {
            self.ejareConvertorlabel.text=@"۸۰ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"90000"]) {
            self.ejareConvertorlabel.text=@"۹۰ هزار تومان";
        }
    }
    if ([self.ejareTextField.text length] == 4){
        NSString*text2=[self.ejareTextField.text substringToIndex:1];
        NSString*text3=[self.ejareTextField.text substringWithRange:(NSMakeRange(1, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
        
        if ([self.ejareTextField.text isEqualToString:@"1000"]) {
            self.ejareConvertorlabel.text=@"۱ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"2000"]) {
            self.ejareConvertorlabel.text=@"۲ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"3000"]) {
            self.ejareConvertorlabel.text=@"۳ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"4000"]) {
            self.ejareConvertorlabel.text=@"۴ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"5000"]) {
            self.ejareConvertorlabel.text=@"۵ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"6000"]) {
            self.ejareConvertorlabel.text=@"۶ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"7000"]) {
            self.ejareConvertorlabel.text=@"۷ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"8000"]) {
            self.ejareConvertorlabel.text=@"۸ هزار تومان";
        }
        if ([self.ejareTextField.text isEqualToString:@"9000"]) {
            self.ejareConvertorlabel.text=@"۹ هزار تومان";
        }
    }
    if ([self.ejareTextField.text length] == 3){
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@",self.ejareTextField.text,@"تومان"];
    }
    if ([self.ejareTextField.text length] == 2){
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@",self.ejareTextField.text,@"تومان"];
    }
    if ([self.ejareTextField.text length] == 1){
        self.ejareConvertorlabel.text=[NSString stringWithFormat:@"%@%@",self.ejareTextField.text,@"تومان"];
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.priceTextField.text length] == 0) {
        self.Convertorlabel.text=@"";
    }
    if ([self.ejareTextField.text length] == 0) {
        self.ejareConvertorlabel.text=@"";
    }
    if ([self.rahnTextField.text length] == 0) {
        self.rahnConvertorlabel.text=@"";
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.transectionTextField resignFirstResponder];
    [self.typeTextField resignFirstResponder];
    [self.roomnumberTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.transectionTextField resignFirstResponder];
    [self.infoTextField resignFirstResponder];
    [self.areaTextField resignFirstResponder];
    [self.regionTextField resignFirstResponder];
    [self.priceTextField resignFirstResponder];
    [self.floorTextField resignFirstResponder];
    [self.yearTextField resignFirstResponder];
    [self.kitchenTextField resignFirstResponder];
    //[self.Phone resignFirstResponder];
    [self.groundTextField resignFirstResponder];
    [self.positionTextField resignFirstResponder];
    [self.noroomTextField resignFirstResponder];
    [self.nofloorTextField resignFirstResponder];
    [self.mapTextField resignFirstResponder];
    //[self.Name resignFirstResponder];
    [self.yearTextField resignFirstResponder];
    
    return NO;
}

#pragma mark -  CheckboxActions

-(IBAction)CheckboxVazeatsokoonat{
    if (ismogeiat==true){
        [self.checkboxVazeatsokoonatBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        ismogeiat=false;
        self.mogeiatStr=@"1";
    }else{
        ismogeiat=true;
        [self.checkboxVazeatsokoonatBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.mogeiatStr=@"0";
    }
}

-(IBAction)Checkboxbalkon{
    if (isbalkon==true){
        [self.checkboxbalkonBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isbalkon=false;
        self.balkonStr=@"1";
    }else{
        isbalkon=true;
        [self.checkboxbalkonBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.balkonStr=@"0";
    }
}

-(IBAction)Checkboxparking{
    if (isparking==true){
        [self.checkboxparkingBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isparking=false;
        self.parkingStr=@"1";
    }else{
        isparking=true;
        [self.checkboxparkingBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.parkingStr=@"0";
    }
}
-(IBAction)Checkboxanbari{
    if (isanbari==true) {
        [self.checkboxanbariBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isanbari=false;
        self.anbariStr=@"1";
    }else{
        isanbari=true;
        [self.checkboxanbariBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.anbariStr=@"0";
    }
}

-(IBAction)Checkboxasansor{
    if (isasansor==true) {
        [self.checkboxasansorBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isasansor=false;
        self.asansorStr=@"1";
    }else{
        isasansor=true;
        [self.checkboxasansorBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.asansorStr=@"0";}
}

-(IBAction)Checkboxestakhr{
    if (isestakhr==true) {
        [self.checkboxestakhrBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isestakhr=false;
        self.estahkrStr=@"1";
    }else{
        isestakhr=true;
        [self.checkboxestakhrBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.estahkrStr=@"0";
    }
}

-(IBAction)Checkboxsona{
    if (issona==true) {
        [self.checkboxsonaBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        issona=false;
        self.sonaStr=@"1";
    }else{
        issona=true;
        [self.checkboxsonaBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.sonaStr=@"0";
    }
}

-(IBAction)Checkboxjakozi{
    if (isjakozi==true) {
        [self.checkboxjakoziBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isjakozi=false;
        self.jakoziStr=@"1";
    }else{
        isjakozi=true;
        self.jakoziStr=@"0";
        [self.checkboxjakoziBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)Checkboxab{
    if (isab==true) {
        [self.checkboxabBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isab=false;
        self.abStr=@"1";
    }else{
        isab=true;
        [self.checkboxabBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.abStr=@"0";
    }
}

-(IBAction)Checkboxbargh{
    if (isbargh==true) {
        [self.checkboxbarghBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isbargh=false;
        self.barghStr=@"1";
    }else{
        isbargh=true;
        [self.checkboxbarghBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.barghStr=@"0";
    }
}

-(IBAction)Checkboxgaz{
    if (isgaz==true) {
        [self.checkboxgazBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
        isgaz=false;
        self.gazStr=@"1";
    }else{
        isgaz=true;
        [self.checkboxgazBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-on.png"] forState:UIControlStateNormal];
        self.gazStr=@"0";
    }
}

#pragma mark - camera roll and camera delegate
- (void)galleryButtonAction{
    [self selectPhoto];
}

- (void)cameraButtonAction{
    [self takePhoto];
}

- (void)showgalleryCameraMenu{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"لغو" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped do nothing.
        if ([imagesArray count]==0) {
            [imagesScrollView removeFromSuperview];
            if (self.detailScrollview.hidden) {
                [imagesScrollView setFrame:CGRectMake(0, 900, screenWidth, 0)];
                self.scrollView.contentSize = CGSizeMake(screenWidth,screenHeight+600);
                //[self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,self.DetailsBtn.frame.origin.y+self.DetailsBtn.frame.size.height+10, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
                CGRect rect3 = self.AddNew.frame;
                rect3.origin.y = imagesScrollView.frame.origin.y+imagesScrollView.frame.size.height+80;
                self.AddNew.frame = rect3;
                
                CGRect rect = self.DetailsBtn.frame;
                rect.origin.y = imagesScrollView.frame.origin.y+imagesScrollView.frame.size.height+40;
                self.DetailsBtn.frame = rect;
            }else{
                [imagesScrollView setFrame:CGRectMake(0, 900, screenWidth, 0)];
                self.detailScrollview.frame=CGRectMake(self.detailScrollview.frame.origin.x, 930, self.detailScrollview.frame.size.width, self.detailScrollview.frame.size.height);
                [self.AddNew setFrame:CGRectMake(self.AddNew.frame.origin.x,1900, self.AddNew.frame.size.width,self.AddNew.frame.size.height)];
                self.scrollView.contentSize = CGSizeMake(320,2010);
            }
        }
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"دوربین" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // take photo button tapped.
        [self cameraButtonAction];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"گالری تصاویر" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // choose photo button tapped.
        [self galleryButtonAction];
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)takePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)selectPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    chosenImage = info[UIImagePickerControllerEditedImage];
    //image1.image = chosenImage;
    [self AddImageView:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    //[self enableSaveButton];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:0];
}

#pragma mark -  Map
-(void)requestAlwaysAuth{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status==kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString*title;
        title=(status == kCLAuthorizationStatusDenied) ? @"Location Services Are Off" : @"Background use is not enabled";
        NSString *message = @"Go to settings";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Settings", nil];
        [alert show];
    }else if (status==kCLAuthorizationStatusNotDetermined)
    {[self.locationManager requestAlwaysAuthorization];}
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingsURL];
    }
}
-(void)checkStatus{
}

- (IBAction)goToSettings:(id)sender {
    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication]openURL:settingsURL];
}

- (IBAction)changAuth:(id)sender{
    NSLog(@"Trying to change to ALWAYS authorization");
    [self requestAlwaysAuth];
}
/*
 -(void)initMap{
 self.mapView.showsUserLocation=YES;
 self.mapView.delegate = self;
 self.mapView.showsUserLocation = YES;
 //    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
 UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
 lpgr.minimumPressDuration = 0.5; //user needs to press for 2 seconds
 [self.mapView addGestureRecognizer:lpgr];
 flagmap = NO;
 }
 
 -(void)addAnnotationWithLatitude:(NSString *)locationX Longitude:(NSString *)locationY{
 MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
 
 CLLocationDegrees latitude = [locationX doubleValue];
 CLLocationDegrees longitude = [locationY doubleValue];
 if (latitude == 0) {
 NSLog(@"Building no location");
 return;
 }
 NSLog(@"Building string: %@ - %@",locationX,locationY);
 NSLog(@"Building double: %f - %f",latitude,longitude);
 
 annot.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
 annot.title = @"مکان ملک شما";
 
 [self.mapView addAnnotation:annot];
 }
 
 - (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer{
 //    NSLog(@"recognized");
 if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
 [self performSelectorOnMainThread:@selector(removeOtherAnnotations) withObject:nil waitUntilDone:YES];
 
 CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
 CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
 
 //        NSLog(@"user %f - %f",self.mapView.userLocation.coordinate.latitude,self.mapView.userLocation.coordinate.longitude);
 
 NSLog(@"new pin :%f - %f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
 self.MapLatStr=[NSString stringWithFormat:@"%f",touchMapCoordinate.latitude];
 self.MapLongStr=[NSString stringWithFormat:@"%f",touchMapCoordinate.longitude];
 
 NSString*savestring1=self.MapLatStr;
 NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
 [defualt1 setObject:savestring1 forKey:@"Map"];
 [defualt1 synchronize];
 NSString*savestring2=self.MapLongStr;
 NSUserDefaults*defualt2=[NSUserDefaults standardUserDefaults];
 [defualt2 setObject:savestring2 forKey:@"Mapl"];
 [defualt2 synchronize];
 
 self.mapTextField.text=self.MapLatStr;
 
 MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
 annot.coordinate = touchMapCoordinate;
 annot.title = @"مکان ملک شما";
 
 [self.mapView addAnnotation:annot];
 
 [self performSelector:@selector(showCallOut:) withObject:annot afterDelay:1.0];
 
 //        [self.mapView selectAnnotation:annot animated:NO];
 }
 }
 
 
 - (void)showCallOut:(MKPointAnnotation *)annot {
 [self.mapView selectAnnotation:annot animated:YES];
 }
 
 -(IBAction)choosemap{
 self.mapView.hidden=YES;
 self.Action2.hidden=YES;
 }
 
 -(void)removeOtherAnnotations{
 NSInteger toRemoveCount = self.mapView.annotations.count;
 NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
 for (id annotation in self.mapView.annotations)
 if (annotation != self.mapView.userLocation)
 [toRemove addObject:annotation];
 [self.mapView removeAnnotations:toRemove];
 }
 
 - (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
 MKPinAnnotationView *pinView = nil;
 if(annotation!= self.mapView.userLocation){
 static NSString *defaultPin = @"pinIdentifier";
 pinView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPin];
 if(pinView == nil)
 pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultPin];
 pinView.pinColor = MKPinAnnotationColorRed; //Optional
 pinView.canShowCallout = YES; // Optional
 pinView.animatesDrop = YES;
 }else{
 [self.mapView.userLocation setTitle:@"شما اینجا هستید!"];
 }
 return pinView;
 }
 
 - (void)zoomToCurrentLocation{
 float span = 0.11225;
 MKCoordinateRegion region;
 region.center.latitude = self.mapView.userLocation.coordinate.latitude;
 region.center.longitude = self.mapView.userLocation.coordinate.longitude;
 region.span.latitudeDelta = span;
 region.span.longitudeDelta = span;
 [self.mapView setRegion:region];
 }
 
 - (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
 MKCoordinateRegion region;
 MKCoordinateSpan span;
 span.latitudeDelta = 0.005;
 span.longitudeDelta = 0.005;
 CLLocationCoordinate2D location;
 location.latitude = aUserLocation.coordinate.latitude;
 location.longitude = aUserLocation.coordinate.longitude;
 region.span = span;
 region.center = location;
 [aMapView setRegion:region animated:YES];
 }
 
 -(IBAction)Map:(id)sender{
 [self.transectionTextField resignFirstResponder];
 [self.typeTextField resignFirstResponder];
 [self.roomnumberTextField resignFirstResponder];
 [self.addressTextField resignFirstResponder];
 [self.transectionTextField resignFirstResponder];
 [self.infoTextField resignFirstResponder];
 [self.areaTextField resignFirstResponder];
 [self.regionTextField resignFirstResponder];
 [self.priceTextField resignFirstResponder];
 [self.floorTextField resignFirstResponder];
 [self.yearTextField resignFirstResponder];
 [self.kitchenTextField resignFirstResponder];
 //[self.Phone resignFirstResponder];
 [self.groundTextField resignFirstResponder];
 [self.positionTextField resignFirstResponder];
 [self.noroomTextField resignFirstResponder];
 [self.nofloorTextField resignFirstResponder];
 [self.mapTextField resignFirstResponder];
 //[self.Name resignFirstResponder];
 [self.yearTextField resignFirstResponder];
 [self zoomToCurrentLocation];
 self.mapView.hidden=NO;
 self.Action2.hidden=NO;
 //self.mapenableBtn.hidden=NO;
 self.mapenableLabel.hidden=YES;
 //self.mapdisableLabel.hidden=NO;
 }
 
 -(IBAction)Deletemap:(id)sender{
 self.mapTextField.text=@"";
 self.mapenableLabel.hidden=YES;
 self.mapdisableLabel.hidden=YES;
 self.mapenableBtn.hidden=YES;
 }
  */
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
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0){
                // if target host is not reachable
                return NO;
            }
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0){
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)){
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0){
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN){
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
