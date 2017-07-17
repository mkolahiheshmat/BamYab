//
//  DetailViewController.m
//  Yarima App
//
//  Created by sina on 9/9/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import "DetailViewController.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "ReplacerEngToPer.h"
#import "CustomImageView.h"
#import "Upload.h"
#import "MapViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController (){
    NSMutableArray *tableArray;
    NSMutableArray *detail;
    NSMutableArray *info;
    UIAlertView *alertoffline;
    BOOL internet;
    NSMutableArray *imagesDataArray;
    NSMutableArray *imagesArray;
    UIImage *choosenImage;
    UIScrollView *imagesScrollView;
    UIImageView *imageView;
    UIPageControl *pageController;
    Upload *imageToUpload;
    NSMutableArray *flagsArray;
    UIImage *downloadedImage;
    NSString *latitudeStr;
    NSString *longitudeStr;
}
@end

@implementation DetailViewController
- (void)viewDidLoad {
    [self AddEffects];
    internet=true;
    alertoffline.delegate=self;
    self.rahnView.hidden=YES;
    self.Action2.hidden=YES;
    self.mapView.hidden=YES;
    NSUserDefaults *defualt1=[NSUserDefaults standardUserDefaults];
    
    imagesDataArray = [[NSMutableArray alloc]init];
    imagesArray = [[NSMutableArray alloc]init];
    flagsArray = [[NSMutableArray alloc]init];
    if (self.isDetailOfAdd) {
        imagesDataArray = [defualt1 objectForKey:@"imagesDataArray"];
        if ([imagesDataArray count]>0) {
            [self convertDataToImage];
            [self.backgroundColor removeFromSuperview];
            [self.backgroundImage removeFromSuperview];
            
            imagesScrollView = [[UIScrollView alloc]init];
            [imagesScrollView setFrame:CGRectMake(0, 0, 320, 182)];
            imagesScrollView.showsVerticalScrollIndicator = NO;
            imagesScrollView.showsHorizontalScrollIndicator = NO;
            imagesScrollView.delegate = self;
            imagesScrollView.backgroundColor = [UIColor clearColor];
            [imagesScrollView setPagingEnabled:YES];
            [self.Scroll addSubview:imagesScrollView];
            [self makeImagesScrollView];
            
            pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(20,183,screenWidth-40,25)];
            pageController.backgroundColor = [UIColor clearColor];
            pageController.currentPageIndicatorTintColor = MAIN_COLOR;
            pageController.pageIndicatorTintColor = [UIColor lightGrayColor];
            pageController.numberOfPages = [imagesDataArray count];
            pageController.currentPage = 0;
            [self.Scroll addSubview:pageController];
        }
    }
    NSString*loadstring1=[defualt1 objectForKey:@"ID"];
    [self.IDAlabel setText:loadstring1];
    self.confirmId.text=[defualt1 objectForKey:@"finall_id"];
    if ([self.IDAlabel.text isEqualToString:@"1"]){
        self.mapshow.hidden=YES;
        self.addbtn.hidden=NO;
        self.newbtn.hidden=NO;
        self.rahnView.hidden=YES;
        self.addbtn.frame=CGRectMake(self.addbtn.frame.origin.x, 1540, self.addbtn.frame.size.width, self.addbtn.frame.size.height);
        self.newbtn.frame=CGRectMake(self.newbtn.frame.origin.x,1585, self.newbtn.frame.size.width, self.newbtn.frame.size.height);
        self.roomnumberLabel.text=[defualt1 objectForKey:@"roomNumbertextField"];
        self.areafieldLabel.text=[defualt1 objectForKey:@"areatextField"];
        self.typefieldLabel.text=[defualt1 objectForKey:@"TypetextField"];
        self.transectionfieldLabel=[defualt1 objectForKey:@"TransectiontextField"];
        self.pricefieldLabel.text=[defualt1 objectForKey:@"Priceconvert"];
        self.addressfieldLabel.text=[defualt1 objectForKey:@"AddresstextField"];
        self.regionfieldLabel.text=[defualt1 objectForKey:@"RegiontextField"];
        self.floorLabel.text=[defualt1 objectForKey:@"floorTextField"];
        self.nofloorLabel.text=[defualt1 objectForKey:@"noFloortextField"];
        self.noroomLabel.text=[defualt1 objectForKey:@"noRoomtextField"];
        self.yearLabel.text=[defualt1 objectForKey:@"yeartextField"];
        self.kitchenLabel.text=[defualt1 objectForKey:@"kitchentextField"];
        self.groundLabel.text=[defualt1 objectForKey:@"groundtextField"];
        self.positionLabel.text=[defualt1 objectForKey:@"positiontextField"];
        self.infoLabel.text=[defualt1 objectForKey:@"iNFOtextField"];
        self.nameLabel.text=[defualt1 objectForKey:@"nametextField"];
        self.phoneLabel.text=[defualt1 objectForKey:@"phonetextField"];
        self.rahnlabel.text=[defualt1 objectForKey:@"rahnconvert"];
        self.ejarehlabel.text=[defualt1 objectForKey:@"ejareconvert"];
        self.VSStr=[defualt1 objectForKey:@"mogeiatStr"];
        self.balkonStr=[defualt1 objectForKey:@"balkonStr"];
        self.parkingStr=[defualt1 objectForKey:@"parkingStr"];
        self.anbariStr=[defualt1 objectForKey:@"anbariStr"];
        self.asansorStr=[defualt1 objectForKey:@"asansorStr"];
        self.estahkrStr=[defualt1 objectForKey:@"estahkrStr"];
        self.sonaStr=[defualt1 objectForKey:@"sonaStr"];
        self.jakoziStr=[defualt1 objectForKey:@"jakoziStr"];
        self.abStr=[defualt1 objectForKey:@"abStr"];
        self.barghStr=[defualt1 objectForKey:@"barghStr"];
        self.gazStr=[defualt1 objectForKey:@"gazStr"];
        //    self.ejarehlabel.text = [defualt1 objectForKey:@"ejarehlabel"];
        //    self.rahnlabel.text = [defualt1 objectForKey:@"rahnlabel"];
        if ([[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"رهن و اجاره"]||[[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"اجاره موقت"]){
            self.rahnView.hidden=NO;
        }else{
            self.rahnView.hidden=YES;
        }
        [self Checkboxs];
    }else{
        imagesDataArray = [[NSMutableArray alloc]init];
        imagesArray = [[NSMutableArray alloc]init];
        [imagesScrollView removeFromSuperview];
        [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"domain_detail_app"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"domain_id"] =self.IDAlabel.text;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            self.typefieldLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"property_type"];
            self.addressfieldLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"address"];
            self.nameLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"presenter"];
            self.areafieldLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"area"];
            self.kitchenLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"ashpazkhane"];
            self.roomnumberLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"bedroom"];
            self.regionfieldLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"region_name"];
            self.groundLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"kafpoosh"];
            self.positionLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"mogheiyat"];
            self.pricefieldLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"price"];
            self.VSStr = [[responseObject objectForKey:@"result"] objectForKey:@"vaziyatesokonat"];
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
            self.dateLabel = [[responseObject objectForKey:@"result"] objectForKey:@"adddate"];
            self.MapLatStr = [[responseObject objectForKey:@"result"] objectForKey:@"latitude"];
            latitudeStr = [[responseObject objectForKey:@"result"] objectForKey:@"latitude"];
            
            self.MapLongStr = [[responseObject objectForKey:@"result"] objectForKey:@"longitude"];
            longitudeStr = [[responseObject objectForKey:@"result"] objectForKey:@"longitude"];
            self.yearLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"seneBana"];
            self.infoLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"tozihat"];
            self.floorLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"tabaghe"];
            self.phoneLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"tell"];
            self.rahnlabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"mortgage"];
            self.ejarehlabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"rent"];
            self.noroomLabel.text = [[responseObject objectForKey:@"result"] objectForKey:@"tedadeVahed"];
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            #pragma mark  response for images
            imagesDataArray = [[responseObject objectForKey:@"result"]objectForKey:@"picture"];
            if ([imagesDataArray count]>0) {
                [self.backgroundColor removeFromSuperview];
                [self.backgroundImage removeFromSuperview];
                
                imagesScrollView = [[UIScrollView alloc]init];
                [imagesScrollView setFrame:CGRectMake(0, 0, 320, 182)];
                imagesScrollView.showsVerticalScrollIndicator = NO;
                imagesScrollView.showsHorizontalScrollIndicator = NO;
                imagesScrollView.delegate = self;
                imagesScrollView.backgroundColor = [UIColor whiteColor];
                [imagesScrollView setPagingEnabled:YES];
                [self.Scroll addSubview:imagesScrollView];
                [self downloadImages];
                
                pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(20,183,screenWidth-40,25)];
                pageController.backgroundColor = [UIColor clearColor];
                pageController.currentPageIndicatorTintColor = MAIN_COLOR;
                pageController.pageIndicatorTintColor = [UIColor lightGrayColor];
                pageController.numberOfPages = [imagesDataArray count];
                pageController.currentPage = 0;
                [self.Scroll addSubview:pageController];
            }
            if ([[[responseObject objectForKey:@"result"] objectForKey:@"type_of_transaction"] isEqualToString:@"رهن و اجاره"]||[[[responseObject objectForKey:@"result"] objectForKey:@"type_of_transaction"] isEqualToString:@"اجاره موقت"]){
                self.rahnView.hidden=NO;
            }else{
                self.rahnView.hidden=YES;
            }
            if ([self.pricefieldLabel.text length] == 1){
                self.pricefieldLabel.text=[NSString stringWithFormat:@"%@%@",self.pricefieldLabel.text,@"میلیون تومان"];
            }
            if ([self.pricefieldLabel.text length] == 2){
                self.pricefieldLabel.text=[NSString stringWithFormat:@"%@%@",self.pricefieldLabel.text,@"میلیون تومان"];
            }
            if ([self.pricefieldLabel.text length] == 3){
                self.pricefieldLabel.text=[NSString stringWithFormat:@"%@%@",self.pricefieldLabel.text,@"میلیون تومان"];
            }
            if ([self.pricefieldLabel.text length] == 4){
                NSString*text2=[self.pricefieldLabel.text substringToIndex:1];
                NSString*text3=[self.pricefieldLabel.text substringWithRange:(NSMakeRange(1, 3))];
                
                self.pricefieldLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
                if ([self.pricefieldLabel.text isEqualToString:@"1000"]) {
                    self.pricefieldLabel.text=@"۱ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"2000"]) {
                    self.pricefieldLabel.text=@"۲ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"3000"]) {
                    self.pricefieldLabel.text=@"۳ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"4000"]) {
                    self.pricefieldLabel.text=@"۴ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"5000"]) {
                    self.pricefieldLabel.text=@"۵ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"6000"]) {
                    self.pricefieldLabel.text=@"۶ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"7000"]) {
                    self.pricefieldLabel.text=@"۷ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"8000"]) {
                    self.pricefieldLabel.text=@"۸ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"9000"]) {
                    self.pricefieldLabel.text=@"۹ میلیارد تومان";
                }
            }
            if ([self.pricefieldLabel.text length] == 5){
                NSString*text2=[self.pricefieldLabel.text substringToIndex:2];
                NSString*text3=[self.pricefieldLabel.text substringWithRange:(NSMakeRange(2,3))];
                self.pricefieldLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
                if ([self.pricefieldLabel.text isEqualToString:@"10000"]) {
                    self.pricefieldLabel.text=@"۱۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"20000"]) {
                    self.pricefieldLabel.text=@"۲۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"30000"]) {
                    self.pricefieldLabel.text=@"۳۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"40000"]) {
                    self.pricefieldLabel.text=@"۴۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"50000"]) {
                    self.pricefieldLabel.text=@"۵۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"60000"]) {
                    self.pricefieldLabel.text=@"۶۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"70000"]) {
                    self.pricefieldLabel.text=@"۷۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"80000"]) {
                    self.pricefieldLabel.text=@"۸۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"90000"]) {
                    self.pricefieldLabel.text=@"۹۰ میلیارد تومان";
                }
            }
            if ([self.pricefieldLabel.text length] == 6){
                NSString*text2=[self.pricefieldLabel.text substringToIndex:3];
                NSString*text3=[self.pricefieldLabel.text substringWithRange:(NSMakeRange(3, 3))];
                self.pricefieldLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
                if ([self.pricefieldLabel.text isEqualToString:@"100000"]) {
                    self.pricefieldLabel.text=@"۱۰۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"200000"]) {
                    self.pricefieldLabel.text=@"۲۰۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"300000"]) {
                    self.pricefieldLabel.text=@"۳۰۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"400000"]) {
                    self.pricefieldLabel.text=@"۴۰۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"500000"]) {
                    self.pricefieldLabel.text=@"۵۰۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"600000"]) {
                    self.pricefieldLabel.text=@"۶۰۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"700000"]) {
                    self.pricefieldLabel.text=@"۷۰۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"800000"]) {
                    self.pricefieldLabel.text=@"۸۰۰ میلیارد تومان";
                }
                if ([self.pricefieldLabel.text isEqualToString:@"900000"]) {
                    self.pricefieldLabel.text=@"۹۰۰ میلیارد تومان";
                }
            }
            self.rahnlabel.text=[defualt1 valueForKey:@"Tablerahn"];
            self.ejarehlabel.text=[defualt1 valueForKey:@"Tableejareh"];
            [self Checkboxs];
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.menu addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self.Scroll setScrollEnabled:YES];
    [self.Scroll setContentSize:CGSizeMake(320,1625)];
    [super viewDidLoad];
}

-(void)viewDidDisappear:(BOOL)animated{
    NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
    [defualt setObject:@"0" forKey:@"backID"];
    [defualt synchronize];
}

#pragma mark -  Custom Methods

-(void)Checkboxs{
    if ([self.VSStr isEqualToString:@"1"]) {
        [self.checkboxVazeatsokoonatBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.balkonStr isEqualToString:@"1"]) {
        [self.checkboxbalkonBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.parkingStr isEqualToString:@"1"]) {
        [self.checkboxparkingBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.anbariStr isEqualToString:@"1"]) {
        [self.checkboxanbariBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.asansorStr isEqualToString:@"1"]) {
        [self.checkboxasansorBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.estahkrStr isEqualToString:@"1"]) {
        [self.checkboxestakhrBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.sonaStr isEqualToString:@"1"]) {
        [self.checkboxsonaBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.jakoziStr isEqualToString:@"1"]) {
        [self.checkboxjakoziBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.abStr isEqualToString:@"1"]) {
        [self.checkboxabBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.barghStr isEqualToString:@"1"]) {
        [self.checkboxbarghBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
    if ([self.gazStr isEqualToString:@"1"]) {
        [self.checkboxgazBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-off.png"] forState:UIControlStateNormal];
    }
}

-(void)AddEffects{
    self.addbtn.hidden=YES;
    self.newbtn.hidden=YES;
    self.addbtn.layer.cornerRadius=15;
    self.newbtn.layer.cornerRadius=15;
    self.newbtn.clipsToBounds=YES;
    self.addbtn.clipsToBounds=YES;
    self.finalladdBtn.layer.cornerRadius=15;
    self.finallhomeBtn.layer.cornerRadius=15;
    self.finalladdBtn.clipsToBounds=YES;
    self.finallhomeBtn.clipsToBounds=YES;
}

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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

-(IBAction)callPhone:(id)sender {
    NSString*string=[NSString stringWithFormat:@"%@%@",@"tel:",self.phoneLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

- (void)testInternetConnection{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
        });
    };
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Someone broke the internet :(");
        });
    };
    [internetReachableFoo startNotifier];
}

-(void)dismiss:(UIAlertView*)alert{
    [alertoffline dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)close{
    [self performSegueWithIdentifier:@"BackOffline" sender:nil];
}

-(IBAction)upload{
    NSString *latitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"Latitude"];
    NSString *longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"Longitude"];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        alertoffline = [[UIAlertView alloc]initWithTitle:@"پیام" message:@"لطفا به اینترنت متصل شوید" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertoffline show];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:2.0];
        [self performSelector:@selector(close) withObject:nil afterDelay:3.0];
    }else{
        [SVProgressHUD showWithStatus:@"در حال ارسال اطلاعات"];
        NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
        self.noroomLabel.text=[defualt1 objectForKey:@"noRoomtextField"];
        self.yearLabel.text=[defualt1 objectForKey:@"yeartextField"];
        self.kitchenLabel.text=[defualt1 objectForKey:@"kitchentextField"];
        self.groundLabel.text=[defualt1 objectForKey:@"groundtextField"];
        self.positionLabel.text=[defualt1 objectForKey:@"positiontextField"];
        self.infoLabel.text=[defualt1 objectForKey:@"iNFOtextField"];
        self.nameLabel.text=[defualt1 objectForKey:@"nametextField"];
        self.phoneLabel.text=[defualt1 objectForKey:@"phonetextField"];
        self.VSStr=[defualt1 objectForKey:@"mogeiatStr"];
        self.balkonStr=[defualt1 objectForKey:@"balkonStr"];
        self.parkingStr=[defualt1 objectForKey:@"parkingStr"];
        self.anbariStr=[defualt1 objectForKey:@"anbariStr"];
        self.asansorStr=[defualt1 objectForKey:@"asansorStr"];
        self.estahkrStr=[defualt1 objectForKey:@"estahkrStr"];
        self.sonaStr=[defualt1 objectForKey:@"sonaStr"];
        self.jakoziStr=[defualt1 objectForKey:@"jakoziStr"];
        self.abStr=[defualt1 objectForKey:@"abStr"];
        self.barghStr=[defualt1 objectForKey:@"barghStr"];
        self.gazStr=[defualt1 objectForKey:@"gazStr"];
        
        [SVProgressHUD showWithStatus:@"در حال ارسال اطلاعات"];
        
        if ([[defualt1 objectForKey:@"login"] isEqualToString:@"1"]){
            NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
            [fetchRequest setReturnsObjectsAsFaults:NO];
            info = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
            NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"add_domain_app"];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"email"] = [info valueForKey:@"user"];
            params[@"password"] =[info valueForKey:@"pass"];
            params[@"TypeOfTransaction"] = [defualt1 objectForKey:@"TransectiontextField"];
            params[@"PropertyType"] = [defualt1 objectForKey:@"TypetextField"];
            params[@"Region"] =[defualt1 objectForKey:@"id"];
            
            NSString *str = [defualt1 objectForKey:@"areatextField"];
            str = [ReplacerEngToPer replacer2:str];
            params[@"Area"] = str;
            
            NSLog(@"%@",str);
            
            params[@"tabaghe"] = [defualt1 objectForKey:@"floorTextField"];
            params[@"khab"] =[defualt1 objectForKey:@"roomNumbertextField"];
            //  NSString* string1 = [NSString stringWithFormat:@"%@%@",[defualt1 objectForKey:@"ejarehlabel"],@"100000"];
            //   NSString* string2 = [NSString stringWithFormat:@"%@%@",[defualt1 objectForKey:@"rahnlabel"],@"100000"];
            if ([[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"رهن و اجاره"]||[[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"اجاره موقت"]||[[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"رهن"]){
                if ([[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"رهن"]) {
                    
                    NSString *str3 = [defualt1 objectForKey:@"PricetextField"];
                    str3 = [ReplacerEngToPer replacer2:str3];
                    
                    NSString*price=[NSString stringWithFormat:@"%@%@",str3,@"000000"];
                    if ([[defualt1 objectForKey:@"PricetextField"] isEqualToString:@"0"]) {
                        params[@"Mortgage"] = @"0";
                    }
                    params[@"Mortgage"] = price;
                }else{
                    NSString *str4 = [defualt1 objectForKey:@"rahntextField"];
                    str4 = [ReplacerEngToPer replacer2:str4];
                    
                    NSString*price=[NSString stringWithFormat:@"%@%@",str4,@"000000"];
                    if ([[defualt1 objectForKey:@"rahntextField"] isEqualToString:@"0"]) {
                        params[@"Mortgage"] = @"0";
                    }
                    params[@"Mortgage"] = price;
                    
                    //          params[@"Rent"] = [defualt1 objectForKey:@"ejarehlabel"];
                    //          params[@"Mortgage"] = [defualt1 objectForKey:@"rahnlabel"];
                    NSString *str5 = [defualt1 objectForKey:@"ejaretextField"];
                    str5 = [ReplacerEngToPer replacer2:str5];
                    params[@"Rent"] = str5;
                    //            params[@"Mortgage"] = [defualt1 objectForKey:@"rahntextField"];
                }
            }else{
                NSString *str2 = [defualt1 objectForKey:@"PricetextField"];
                str2 = [ReplacerEngToPer replacer2:str2];
                params[@"Price"] = str2;
            }
            params[@"kafpoosh"] =[defualt1 objectForKey:@"groundtextField"];
            params[@"mogheiyat"] = [defualt1 objectForKey:@"mogeiatStr"];
            params[@"ashpazkhane"] = [defualt1 objectForKey:@"kitchentextField"];
            params[@"Presenter"] = [defualt1 objectForKey:@"nametextField"];
            params[@"Tel"] = [defualt1 objectForKey:@"phonetextField"];
            params[@"Address"] = [defualt1 objectForKey:@"AddresstextField"];
            params[@"Tozihat"] = [defualt1 objectForKey:@"iNFOtextField"];
            
            NSString *str6 = [defualt1 objectForKey:@"yeartextField"];
            str6 = [ReplacerEngToPer replacer2:str6];
            params[@"seneBana"] = str6;
            
            NSString *str7 = [defualt1 objectForKey:@"noRoomtextField"];
            str7 = [ReplacerEngToPer replacer2:str7];
            params[@"tedadeVahed"] = str7;
            
            NSString *str8 = [defualt1 objectForKey:@"noFloortextField"];
            str8 = [ReplacerEngToPer replacer2:str8];
            params[@"koleTabaghat"] = str8;
            
            //params[@"longitude"] = [defualt1 objectForKey:@"MapLatStr"];
            //params[@"latitude"] = [defualt1 objectForKey:@"MapLongStr"];
            if ((latitude != nil) && (longitude != nil)) {
                params[@"latitude"] = latitude;//self.viewMapLatStr;
                params[@"longitude"] = longitude;//self.viewMapLongStr;
            }else{
                params[@"latitude"] = @"";
                params[@"longitude"] = @"";
            }

            params[@"IsForce"] = @"0";
            params[@"balkon"] = [defualt1 objectForKey:@"balkonStr"];
            params[@"Asansoor"] = [defualt1 objectForKey:@"asansorStr"];
            params[@"sona"] = [defualt1 objectForKey:@"sonaStr"];
            params[@"jakozi"] =[defualt1 objectForKey:@"jakoziStr"];
            params[@"parking"] =[defualt1 objectForKey:@"parkingStr"];
            params[@"Anbari"] = [defualt1 objectForKey:@"anbariStr"];
            params[@"estakhr"] = [defualt1 objectForKey:@"estahkrStr"];
            params[@"Ab"] =[defualt1 objectForKey:@"abStr"];
            params[@"gaz"] = [defualt1 objectForKey:@"gazStr"];
            params[@"bargh"] = [defualt1 objectForKey:@"barghStr"];
            params[@"Asansoor"] = [defualt1 objectForKey:@"asansorStr"];
            params[@"vaziyatesokonat"] = [defualt1 objectForKey:@"mogeiatStr"];
            params[@"channel"] = channel;
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSString * ID=[responseObject valueForKey:@"domain_id"];
                NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
                [defualt1 setObject:ID forKey:@"finall_id"];
                [defualt1 synchronize];
                NSManagedObjectContext *context = [self managedObjectContext];
                NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Detail" inManagedObjectContext:context];
                
                [newDevice setValue:self.roomnumberLabel.text forKey:@"roomnumber"];
                [newDevice setValue:self.areafieldLabel.text forKey:@"area"];
                [newDevice setValue:self.typefieldLabel.text forKey:@"type"];
                [newDevice setValue:self.transectionfieldLabel forKey:@"transection"];
                [newDevice setValue:self.regionfieldLabel.text forKey:@"region"];
                if ([[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"رهن و اجاره"]) {
                    [newDevice setValue:self.rahnlabel.text forKey:@"rahn"];
                    [newDevice setValue:self.ejarehlabel.text forKey:@"ejareh"];
                }
                else
                {
                    [newDevice setValue:self.pricefieldLabel.text forKey:@"price"];
                }
                [newDevice setValue:ID forKey:@"id"];
                [self saveContext];
                if ([imagesDataArray count]>0) {
                    for (int n=0; n<[imagesDataArray count]; n++) {
                        NSString *base64Encoded = [[imagesDataArray objectAtIndex:n] base64EncodedStringWithOptions:0];
                        NSTimeInterval time = ([[NSDate date] timeIntervalSince1970]); // returned as a double
                        long digits = (long)time; // this is the first 10 digits
                        int decimalDigits = (int)(fmod(time, 1) * 1000); // this will get the 3 missing digits
                        NSString *timestampString = [NSString stringWithFormat:@"%ld%d",digits ,decimalDigits];
                        
                        imageToUpload = [[Upload alloc]init];
                        imageToUpload.title = timestampString;
                        imageToUpload.flag = NO;
                        imageToUpload.imageID = n;
                            [self uploadImage:timestampString imageData:base64Encoded domainID:ID];
                    }
                }else{
                    [SVProgressHUD dismiss];
//                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"پیام" message:@"ثبت شد" delegate:self cancelButtonTitle:@"تایید" otherButtonTitles: nil];
//                    [alert show];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"پیام" message:@"ملک با موفقیت ثبت گردید" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self performSegueWithIdentifier:@"finall" sender:nil];
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        }else{
            ////NSString *str = [defualt1 objectForKey:@"areatextField"];
            ////str = [ReplacerEngToPer replacer2:str];
            ////params[@"Area"] = str;
            NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"add_domain_free_app"];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"TypeOfTransaction"] = [defualt1 objectForKey:@"TransectiontextField"];
            params[@"PropertyType"] = [defualt1 objectForKey:@"TypetextField"];
            params[@"Region"] =[defualt1 objectForKey:@"id"];
            
            NSString *str = [defualt1 objectForKey:@"areatextField"];
            str = [ReplacerEngToPer replacer2:str];
            params[@"Area"] = str;
            
            //params[@"Area"] = [defualt1 objectForKey:@"areatextField"];
            params[@"tabaghe"] = [defualt1 objectForKey:@"floorTextField"];
            
            params[@"khab"] =[defualt1 objectForKey:@"roomNumbertextField"];
            if ([[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"رهن"]||[[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"رهن و اجاره"]||[[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"اجاره موقت"]){
                if ([[defualt1 objectForKey:@"TransectiontextField"] isEqualToString:@"رهن"]) {
                    NSString*price=[NSString stringWithFormat:@"%@%@",[defualt1 objectForKey:@"PricetextField"],@"000000"];
                    if ([[defualt1 objectForKey:@"PricetextField"] isEqualToString:@"0"]) {
                        params[@"Mortgage"] = @"0";
                    }
                    NSString *str10 = price;
                    str10 = [ReplacerEngToPer replacer2:str10];
                    params[@"Mortgage"] = str10;
                    //params[@"Mortgage"] = price;
                }else{
                    NSString*price=[NSString stringWithFormat:@"%@%@",[defualt1 objectForKey:@"rahntextField"],@"000000"];
                    if ([[defualt1 objectForKey:@"rahntextField"] isEqualToString:@"0"]) {
                        params[@"Mortgage"] = @"0";
                    }
                    NSString *str3 = price;
                    str3 = [ReplacerEngToPer replacer2:str3];
                    params[@"Mortgage"] = str3;
                    // params[@"Mortgage"] = price;
                    
                    //          params[@"Rent"] = [defualt1 objectForKey:@"ejarehlabel"];
                    //          params[@"Mortgage"] = [defualt1 objectForKey:@"rahnlabel"];
                    
                    NSString *str4 = [defualt1 objectForKey:@"ejaretextField"];
                    str4 = [ReplacerEngToPer replacer2:str4];
                    params[@"Rent"] = str4;
                    //params[@"Rent"] = [defualt1 objectForKey:@"ejaretextField"];
                    //            params[@"Mortgage"] = [defualt1 objectForKey:@"rahntextField"];
                }
            }else{
                NSString *str5 = [defualt1 objectForKey:@"PricetextField"];
                str5 = [ReplacerEngToPer replacer2:str5];
                params[@"Price"] = str5;
                //params[@"Price"] = [defualt1 objectForKey:@"PricetextField"];
            }
            params[@"kafpoosh"] =[defualt1 objectForKey:@"groundtextField"];
            params[@"mogheiyat"] = [defualt1 objectForKey:@"mogeiatStr"];
            params[@"ashpazkhane"] = [defualt1 objectForKey:@"kitchentextField"];
            params[@"Presenter"] = [defualt1 objectForKey:@"nametextField"];
            
            NSString *str6 = [defualt1 objectForKey:@"phonetextField"];
            str6 = [ReplacerEngToPer replacer2:str6];
            params[@"Tel"] = str6;
            
            //params[@"Tel"] = [defualt1 objectForKey:@"phonetextField"];
            params[@"Address"] = [defualt1 objectForKey:@"AddresstextField"];
            params[@"Tozihat"] = [defualt1 objectForKey:@"iNFOtextField"];
            
            NSString *str2 = [defualt1 objectForKey:@"yeartextField"];
            str2 = [ReplacerEngToPer replacer2:str2];
            params[@"seneBana"] = str2;
            
            // params[@"seneBana"] = [defualt1 objectForKey:@"yeartextField"];
            NSString *str7 = [defualt1 objectForKey:@"noRoomtextField"];
            str7 = [ReplacerEngToPer replacer2:str7];
            params[@"tedadeVahed"] = str7;
            
            //params[@"tedadeVahed"] = [defualt1 objectForKey:@"noRoomtextField"];
            
            NSString *str8 = [defualt1 objectForKey:@"noFloortextField"];
            str8 = [ReplacerEngToPer replacer2:str8];
            params[@"koleTabaghat"] = str8;
            
            //params[@"koleTabaghat"] = [defualt1 objectForKey:@"noFloortextField"];
//            params[@"longitude"] = [defualt1 objectForKey:@"MapLatStr"];
//            params[@"latitude"] = [defualt1 objectForKey:@"MapLongStr"];
            if ((latitude != nil) && (longitude != nil)) {
                params[@"latitude"] = latitude;//self.viewMapLatStr;
                params[@"longitude"] = longitude;//self.viewMapLongStr;
            }else{
                params[@"latitude"] = @"";
                params[@"longitude"] = @"";
            }
            params[@"IsForce"] = @"0";
            params[@"balkon"] = [defualt1 objectForKey:@"balkonStr"];
            params[@"Asansoor"] = [defualt1 objectForKey:@"asansorStr"];
            params[@"sona"] = [defualt1 objectForKey:@"sonaStr"];
            params[@"jakozi"] =[defualt1 objectForKey:@"jakoziStr"];
            params[@"parking"] =[defualt1 objectForKey:@"parkingStr"];
            params[@"Anbari"] = [defualt1 objectForKey:@"anbariStr"];
            params[@"estakhr"] = [defualt1 objectForKey:@"estahkrStr"];
            params[@"Ab"] =[defualt1 objectForKey:@"abStr"];
            params[@"gaz"] = [defualt1 objectForKey:@"gazStr"];
            params[@"bargh"] = [defualt1 objectForKey:@"barghStr"];
            params[@"vaziyatesokonat"] = [defualt1 objectForKey:@"mogeiatStr"];
            params[@"channel"] = channel;
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSString * ID=[responseObject valueForKey:@"domain_id"];
                NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
                [defualt1 setObject:ID forKey:@"finall_id"];
                [defualt1 synchronize];
                NSManagedObjectContext *context = [self managedObjectContext];
                NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Detail" inManagedObjectContext:context];
                [newDevice setValue:self.roomnumberLabel.text forKey:@"roomnumber"];
                [newDevice setValue:self.areafieldLabel.text forKey:@"area"];
                [newDevice setValue:self.typefieldLabel.text forKey:@"type"];
                [newDevice setValue:self.transectionfieldLabel forKey:@"transection"];
                [newDevice setValue:self.pricefieldLabel.text forKey:@"price"];
                [newDevice setValue:self.regionfieldLabel.text forKey:@"region"];
                [newDevice setValue:ID forKey:@"id"];
                [self saveContext];
                if ([imagesDataArray count]>0) {
                    for (int m=0; m<[imagesDataArray count]; m++) {
                        NSString *base64Encoded2 = [[imagesDataArray objectAtIndex:m] base64EncodedStringWithOptions:0];
                        NSTimeInterval time2 = ([[NSDate date] timeIntervalSince1970]); // returned as a double
                        long digits2 = (long)time; // this is the first 10 digits
                        int decimalDigits2 = (int)(fmod(time2, 1) * 1000); // this will get the 3 missing digits
                        NSString *timestampString2 = [NSString stringWithFormat:@"%ld%d",digits2 ,decimalDigits2];
                        
                        imageToUpload = [[Upload alloc]init];
                        imageToUpload.title = timestampString2;
                        imageToUpload.flag = NO;
                        imageToUpload.imageID = m;
                           [self uploadImage:timestampString2 imageData:base64Encoded2 domainID:ID];
                    }
                }else{
                    [SVProgressHUD dismiss];
//                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"پیام" message:@"ثبت شد" delegate:self cancelButtonTitle:@"تایید" otherButtonTitles: nil];
//                    [alert show];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"پیام" message:@"ملک با موفقیت ثبت گردید" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self performSegueWithIdentifier:@"finall" sender:nil];
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        }
    }
}

-(IBAction)Edit{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)showmap{
//    [self performSelector:@selector(addAnnotationWithLatitude:Longitude:) withObject:nil];
//    self.mapView.hidden=NO;
//    self.Action2.hidden=NO;
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *view = (MapViewController *)[story instantiateViewControllerWithIdentifier:@"MapViewController"];
    //view.latitudeStr = self.MapLatStr;
    //view.longitudeStr = self.MapLongStr;
    view.latitudeStr = latitudeStr;
    view.longitudeStr = longitudeStr;
    view.isComingFromDetailVC = YES;
    [self presentViewController:view animated:YES completion:nil];
}

-(IBAction)closemap{
    self.mapView.hidden=YES;
    self.Action2.hidden=YES;
}

-(IBAction)Back{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    NSString*loadstring1=[defualt1 objectForKey:@"backID"];
    //  if ([self.IDAlabel.text isEqualToString:@"1"]) {
    //      [self performSegueWithIdentifier:@"ADD" sender:nil];
    //  }
    if ([loadstring1 isEqualToString:@"4"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([loadstring1 isEqualToString:@"2"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([loadstring1 isEqualToString:@"3"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([loadstring1 isEqualToString:@"1"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([loadstring1 isEqualToString:@"0"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//- (void)alertView:(UIAlertView *)alertView
//clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == [alertView cancelButtonIndex])
//    {
//        [self performSegueWithIdentifier:@"finall" sender:nil];
//    }
//}

-(void) convertDataToImage{
    for (int i=0; i<[imagesDataArray count]; i++) {
        choosenImage = [UIImage imageWithData:[imagesDataArray objectAtIndex:i]];
        [imagesArray addObject:choosenImage];
    }
}

-(void) makeImagesScrollView{
    CGFloat xPos = 0;
    for (int j=0; j<[imagesArray count]; j++) {
        imageView = [CustomImageView initImageViewWithImage:@"" withFrame:CGRectMake(xPos,0,screenWidth,190)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [imagesArray objectAtIndex:j];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = j;
        [imagesScrollView addSubview: imageView];
        
        xPos = xPos+imageView.frame.size.width;
    }
    imagesScrollView.contentSize = CGSizeMake((screenWidth*[imagesDataArray count]), 110);
}

-(void) downloadImages{
    CGFloat xPos = 0;
    for (int k=0; k<[imagesDataArray count]; k++) {
        imageView = [CustomImageView initImageViewWithImage:@"" withFrame:CGRectMake(xPos,0,screenWidth,190)];
        imageView.backgroundColor = [UIColor clearColor];
        NSString *imageURL = [[imagesDataArray objectAtIndex:k]objectForKey:@"url"];
         [SVProgressHUD showWithStatus:@"در حال دریافت تصاویر"];
        [imageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"BamYabLogo"]];
        [SVProgressHUD dismiss];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = k;
        [imagesScrollView addSubview: imageView];
        xPos = xPos+imageView.frame.size.width;
    }
    imagesScrollView.contentSize = CGSizeMake((screenWidth*[imagesDataArray count]), 110);
}

#pragma mark -  PickerView Delegates
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 50;
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == imagesScrollView) {
        CGFloat rightEdge = scrollView.contentOffset.x + scrollView.frame.size.width;
        CGFloat currentPage = floor(rightEdge/screenWidth);
        pageController.currentPage = currentPage-1;
    }
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

-(void)checkStatus{
    //  CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    //   if (status==kCLAuthorizationStatusNotDetermined) {
    //
    //        _status.text = @"Not Determined";
    //    }
    //    if (status==kCLAuthorizationStatusDenied) {
    //
    //        _status.text = @"Denied";
    //    }
    //    if (status==kCLAuthorizationStatusRestricted) {
    //        _status.text = @"Restricted";
    //    }
    //    if (status==kCLAuthorizationStatusAuthorizedAlways) {
    //        _status.text = @"Always Allowed";
    //    }
    //    if (status==kCLAuthorizationStatusAuthorizedWhenInUse) {
    //        _status.text = @"When In Use Allowed";
    //
    //    }
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
    flagmap = NO;
}

-(void)addAnnotationWithLatitude:(NSString *)locationX Longitude:(NSString *)locationY{
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
//    //set up zoom level
//    MKCoordinateSpan zoom;
//    zoom.latitudeDelta = .1f; //the zoom level in degrees
//    zoom.longitudeDelta = .1f;//the zoom level in degrees
    
    CLLocationDegrees latitude = [self.MapLatStr doubleValue];
    CLLocationDegrees longitude = [self.MapLongStr doubleValue];
    
    
    NSLog(@"Building string: %@ - %@",locationX,locationY);
    NSLog(@"Building double: %f - %f",latitude,longitude);
    
    annot.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    annot.title = @"مکان ملک شما";
    
    [self.mapView addAnnotation:annot];
    [self showCallOut:annot];
}

- (void)showCallOut:(MKPointAnnotation *)annot {
    [self.mapView selectAnnotation:annot animated:YES];
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
*/
#pragma mark - connection
- (void)uploadImage:(NSString *)imageTitle imageData:(NSString *)base64 domainID:(NSString *)domainID{
    NSDictionary *params = @{@"email":@"public_app_user@gmail.com",
                             @"password":@"1234567",
                             @"domain_id":domainID,
                             @"title":imageTitle,
                             @"type":@"jpg",
                             @"photo":base64
                             };
    [SVProgressHUD showWithStatus:@"در حال ارسال تصاویر"];
    NSString *url = @"http://yarima.ir/Domains/upload_pic_app";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 60;
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        if ([[tempDic objectForKey:@"status"]integerValue] == 0) {
            for (int index=0; index<[imagesArray count]; index++) {
                if (imageToUpload.imageID == index) {
                    imageToUpload.flag = YES;
                    [flagsArray addObject:imageToUpload];
                }
            }
            if ([flagsArray count]==[imagesArray count]) {
                [SVProgressHUD dismiss];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"پیام" message:@"ملک و تصاویر با موفقیت ثبت گردید" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self performSegueWithIdentifier:@"finall" sender:nil];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"در ذخیره تصاویر خطایی رخ داده است،لطفا دوباره تلاش کنید." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SVProgressHUD dismiss];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end
