//
//  SearchViewController.m
//  Yarima App
//
//  Created by sina on 9/9/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import "SearchViewController.h"
#import "ListTableViewCell.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"

@interface SearchViewController (){
    NSArray*typeArray;
    UIPickerView *forooshTypePickerView;
    NSString*khabid;
    NSString *strFromInt1;
    NSString *strFromInt2;
    NSString *strFromInt3;
    NSString *strFromInt4;
    int pageInt;
    
    NSDictionary*dic3;
    NSMutableArray*kitchenArray2;
    NSMutableArray*groundArray;
    NSMutableArray*propertyArray;
    NSMutableArray*positionArray;
    
    NSArray *matches;
}
@end
@implementation SearchViewController{
    NSMutableArray *tableArray;
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

-(void)viewWillAppear:(BOOL)animated{
    if ([self hasConnectivity]) {
        [self fetchDataFromServer];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    if (![self hasConnectivity]) {
        // [self performSelector:@selector(showAlert) withObject:nil afterDelay:3.0];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"در حالت آفلاین هستید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self presentViewController:alert animated:YES completion:nil];
        });
    }
    [self.backButton2 setHidden:YES];
    self.backButton2.backgroundColor = [UIColor redColor];
    
    NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
    self.forooshregionTextField.text=[defualt objectForKey:@"AName"];
    self.ejareregionTextField.text=[defualt objectForKey:@"AName"];
    [self method:self.forooshpriceslider];
    NSString*loadstring2=[defualt objectForKey:@"id"];
    [self.regionidLabel setText:loadstring2];
    self.SearchTypelabel.text=@"فروش";
    self.anbariStr=@"0";
    self.anbari2Str=@"0";
    self.ParkingStr=@"0";
    self.Parking2Str=@"0";
    self.asansorStr=@"0";
    self.asansor2Str=@"0";
    khabid=@"5";
    self.ejarehUnitone.hidden=YES;
    self.noresultview.hidden=YES;
    self.tableview.hidden=YES;
    self.backbtn.hidden=YES;
    self.ejareregionTextField.delegate=self;
    self.forooshregionTextField.delegate=self;
    self.ejareTypetextField.delegate=self;
    self.ejareTypetextField.inputView = forooshTypePickerView;
    self.forooshTypetextField.delegate=self;
    [self addPickerView];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menu addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        
        //  [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    typeArray = [[NSArray alloc]initWithObjects:@"آپارتمان",
                 @"هتل آپارتمان",@"کافی شاپ و رستوران",@"پمپ بنزین",@"پنت هاوس",@"برج",@"برج باغ",@"مستغلات",@"کلنگی",@"خانه",@"مرغداری و دامداری",@"انبار",@"کارخانه",@"باغچه",@"باغ",@"زمین",@"کارگاه",@"گاراژ",@"سوله",@"دفتر کار",@"مغازه",@"سوئیت",@"ویلا",@"مجتمع آپارتمانی", nil];
    
    [self.forooshpriceslider setDisplayMode:BJRSWPAudioSetTrimMode];
    [self.rahnSlider setDisplayMode:BJRSWPAudioSetTrimMode];
    [self.ejarehSlider setDisplayMode:BJRSWPAudioSetTrimMode2];
    [self.Areaslider setDisplayMode:BJRSWPAudioSetTrimMode];
    [self.EjarehAreaslider setDisplayMode:BJRSWPAudioSetTrimMode];
    [self.forooshScrollView setContentSize:CGSizeMake(320,630)];
    [self.ejareScrollView setContentSize:CGSizeMake(320,730)];
    self.ejareScrollView.hidden=YES;
    UIImage * thumb= [[UIImage imageNamed:@"poE.png"] stretchableImageWithLeftCapWidth:1.0 topCapHeight:0.0];;
    [self.forooshareaslider setThumbImage: thumb forState: UIControlStateNormal];
    UIImage *sliderTrackImage = [[UIImage imageNamed: @"S.png"] stretchableImageWithLeftCapWidth: 7 topCapHeight: 0];
    
    UIImage *sliderTrackImage2 = [[UIImage imageNamed: @"kl.png"] stretchableImageWithLeftCapWidth: 7 topCapHeight: 0];
    [self.forooshareaslider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.forooshareaslider setMaximumTrackImage: sliderTrackImage2 forState: UIControlStateNormal];
    [self.forooshroomslider setThumbImage: thumb forState: UIControlStateNormal];
    [self.forooshroomslider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.forooshroomslider setMaximumTrackImage: sliderTrackImage2 forState: UIControlStateNormal];
    [self.ejarehroomsSlider setThumbImage: thumb forState: UIControlStateNormal];
    [self.ejarehroomsSlider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.ejarehroomsSlider setMaximumTrackImage: sliderTrackImage2 forState: UIControlStateNormal];
    [self.ejarehareaSlider setThumbImage: thumb forState: UIControlStateNormal];
    [self.ejarehareaSlider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.ejarehareaSlider setMaximumTrackImage: sliderTrackImage2 forState: UIControlStateNormal];
    self.Tab1Img.hidden=YES;
    self.Tab2Img.hidden=YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touches)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touches)];
    [recognizer2 setNumberOfTapsRequired:1];
    [recognizer2 setNumberOfTouchesRequired:1];
    [self.forooshScrollView addGestureRecognizer:recognizer];
    [self.ejareScrollView addGestureRecognizer:recognizer2];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    ListTableViewCell *cell = (ListTableViewCell *)[self.tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.rahnView.hidden=YES;
    
    if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"price"] isKindOfClass:[NSNull class]]||[[[tableArray objectAtIndex:indexPath.row]objectForKey:@"price"] isEqualToString:@"0"]){
        cell.priceLabel.text=@"مشخص نشده";
    }else{
        cell.priceLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"price"]];
        if ([cell.priceLabel.text length] == 1)
        {
            cell.priceLabel.text=[NSString stringWithFormat:@"%@%@",cell.priceLabel.text,@"میلیون تومان"];
        }
        if ([cell.priceLabel.text length] == 2)
        {
            cell.priceLabel.text=[NSString stringWithFormat:@"%@%@",cell.priceLabel.text,@"میلیون تومان"];
        }
        if ([cell.priceLabel.text length] == 3)
        {
            cell.priceLabel.text=[NSString stringWithFormat:@"%@%@",cell.priceLabel.text,@"میلیون تومان"];
        }
        if ([cell.priceLabel.text length] == 4)
        {
            
            NSString*text2=[cell.priceLabel.text substringToIndex:1];
            NSString*text3=[cell.priceLabel.text substringWithRange:(NSMakeRange(1, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            
            
            cell.priceLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            
            if ([cell.priceLabel.text isEqualToString:@"1000"]) {
                cell.priceLabel.text=@"۱ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"2000"]) {
                cell.priceLabel.text=@"۲ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"3000"]) {
                cell.priceLabel.text=@"۳ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"4000"]) {
                cell.priceLabel.text=@"۴ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"5000"]) {
                cell.priceLabel.text=@"۵ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"6000"]) {
                cell.priceLabel.text=@"۶ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"7000"]) {
                cell.priceLabel.text=@"۷ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"8000"]) {
                cell.priceLabel.text=@"۸ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"9000"]) {
                cell.priceLabel.text=@"۹ میلیارد تومان";
            }
        }
        if ([cell.priceLabel.text length] == 5)
        {
            NSString*text2=[cell.priceLabel.text substringToIndex:2];
            NSString*text3=[cell.priceLabel.text substringWithRange:(NSMakeRange(2,3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            cell.priceLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            
            if ([cell.priceLabel.text isEqualToString:@"10000"]) {
                cell.priceLabel.text=@"۱۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"20000"]) {
                cell.priceLabel.text=@"۲۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"30000"]) {
                cell.priceLabel.text=@"۳۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"40000"]) {
                cell.priceLabel.text=@"۴۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"50000"]) {
                cell.priceLabel.text=@"۵۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"60000"]) {
                cell.priceLabel.text=@"۶۰ میلیارد تومان";
            }
            
            if ([cell.priceLabel.text isEqualToString:@"70000"]) {
                cell.priceLabel.text=@"۷۰ میلیارد تومان";
            }
            
            if ([cell.priceLabel.text isEqualToString:@"80000"]) {
                cell.priceLabel.text=@"۸۰ میلیارد تومان";
            }
            
            if ([cell.priceLabel.text isEqualToString:@"90000"]) {
                cell.priceLabel.text=@"۹۰ میلیارد تومان";
            }
            
        }
        if ([cell.priceLabel.text length] == 6)
        {
            NSString*text2=[cell.priceLabel.text substringToIndex:3];
            NSString*text3=[cell.priceLabel.text substringWithRange:(NSMakeRange(3, 3))];
            
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            
            
            cell.priceLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            
            
            if ([cell.priceLabel.text isEqualToString:@"100000"]) {
                cell.priceLabel.text=@"۱۰۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"200000"]) {
                cell.priceLabel.text=@"۲۰۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"300000"]) {
                cell.priceLabel.text=@"۳۰۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"400000"]) {
                cell.priceLabel.text=@"۴۰۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"500000"]) {
                cell.priceLabel.text=@"۵۰۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"600000"]) {
                cell.priceLabel.text=@"۶۰۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"700000"]) {
                cell.priceLabel.text=@"۷۰۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"800000"]) {
                cell.priceLabel.text=@"۸۰۰ میلیارد تومان";
            }
            if ([cell.priceLabel.text isEqualToString:@"900000"]) {
                cell.priceLabel.text=@"۹۰۰ میلیارد تومان";
            }
        }
        
    }
    
    if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isKindOfClass:[NSNull class]]||[[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"0"]){
        cell.ejareLabel.text=@"مشخص نشده";
    }
    else{
        cell.ejareLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"];
        if ([cell.ejareLabel.text length] == 1)
        {
            
            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@",cell.ejareLabel.text,@"تومان"];
        }
        if ([cell.ejareLabel.text length] == 2)
        {
            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@",cell.ejareLabel.text,@"تومان"];
        }
        if ([cell.ejareLabel.text length] == 3)
        {
            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@",cell.ejareLabel.text,@"تومان"];
        }
        if ([cell.ejareLabel.text length] == 4)
        {
            NSString*text2=[cell.ejareLabel.text substringToIndex:1];
            NSString*text3=[cell.ejareLabel.text substringWithRange:(NSMakeRange(1, 3))];
            
            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
            
            if ([cell.ejareLabel.text isEqualToString:@"1000"]) {
                cell.ejareLabel.text=@"۱ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"2000"]) {
                cell.ejareLabel.text=@"۲ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"3000"]) {
                cell.ejareLabel.text=@"۳ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"4000"]) {
                cell.ejareLabel.text=@"۴ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"5000"]) {
                cell.ejareLabel.text=@"۵ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"6000"]) {
                cell.ejareLabel.text=@"۶ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"7000"]) {
                cell.ejareLabel.text=@"۷ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"8000"]) {
                cell.ejareLabel.text=@"۸ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"9000"]) {
                cell.ejareLabel.text=@"۹ هزار";
            }
            
        }
        if ([cell.ejareLabel.text length] == 5)
        {
            NSString*text2=[cell.ejareLabel.text substringToIndex:2];
            NSString*text3=[cell.ejareLabel.text substringWithRange:(NSMakeRange(2, 3))];
            
            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
            if ([cell.ejareLabel.text isEqualToString:@"10000"]) {
                cell.ejareLabel.text=@"۱۰ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"20000"]) {
                cell.ejareLabel.text=@"۲۰ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"30000"]) {
                cell.ejareLabel.text=@"۳۰ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"40000"]) {
                cell.ejareLabel.text=@"۴۰ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"50000"]) {
                cell.ejareLabel.text=@"۵۰ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"60000"]) {
                cell.ejareLabel.text=@"۶۰ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"70000"]) {
                cell.ejareLabel.text=@"۷۰ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"80000"]) {
                cell.ejareLabel.text=@"۸۰ هزار";
            }
            if ([cell.ejareLabel.text isEqualToString:@"90000"]) {
                cell.ejareLabel.text=@"۹۰ هزار";
            }
            
        }
        if ([cell.ejareLabel.text length] == 6)
        {
            NSString*text2=[cell.ejareLabel.text substringToIndex:3];
            NSString*text3=[cell.ejareLabel.text substringWithRange:(NSMakeRange(3, 3))];
            
            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"100000"]) {
                cell.ejareLabel.text=@"۱۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"200000"]) {
                cell.ejareLabel.text=@"۲۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"300000"]) {
                cell.ejareLabel.text=@"۳۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"400000"]) {
                cell.ejareLabel.text=@"۴۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"500000"]) {
                cell.ejareLabel.text=@"۵۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"600000"]) {
                cell.ejareLabel.text=@"۶۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"700000"]) {
                cell.ejareLabel.text=@"۷۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"800000"]) {
                cell.ejareLabel.text=@"۸۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"900000"]) {
                cell.ejareLabel.text=@"۹۰۰ هزار تومان";
            }
        }
        if ([cell.ejareLabel.text length] == 7)
        {
            NSString*text2=[cell.ejareLabel.text substringToIndex:1];
            NSString*text3=[cell.ejareLabel.text substringWithRange:(NSMakeRange(1, 3))];
            
            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
            
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"1000000"]) {
                cell.ejareLabel.text=@"۱ میلیون";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"2000000"]) {
                cell.ejareLabel.text=@"۲ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"3000000"]) {
                cell.ejareLabel.text=@"۳ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"4000000"]) {
                cell.ejareLabel.text=@"۴ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"5000000"]) {
                cell.ejareLabel.text=@"۵ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"6000000"]) {
                cell.ejareLabel.text=@"۶ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"7000000"]) {
                cell.ejareLabel.text=@"۷ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"8000000"]) {
                cell.ejareLabel.text=@"۸ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"rent"] isEqualToString:@"9000000"]) {
                cell.ejareLabel.text=@"۹ میلیون تومان";
            }
        }
        if ([cell.ejareLabel.text length] == 8)
        {
            //NSString*text2=[cell.ejareLabel.text substringToIndex:2];
            //NSString*text3=[cell.ejareLabel.text substringWithRange:(NSMakeRange(2,3))];
            //            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار"];
            if ([cell.ejareLabel.text isEqualToString:@"10000000"]) {
                cell.ejareLabel.text=@"۱۰ میلیون تومان";
            }
            if ([cell.ejareLabel.text isEqualToString:@"20000000"]) {
                cell.ejareLabel.text=@"۲۰ میلیون تومان";
            }
            if ([cell.ejareLabel.text isEqualToString:@"30000000"]) {
                cell.ejareLabel.text=@"۳۰ میلیون تومان";
            }
            if ([cell.ejareLabel.text isEqualToString:@"40000000"]) {
                cell.ejareLabel.text=@"۴۰ میلیون تومان";
            }
            if ([cell.ejareLabel.text isEqualToString:@"50000000"]) {
                cell.ejareLabel.text=@"۵۰ میلیون تومان";
            }
            if ([cell.ejareLabel.text isEqualToString:@"60000000"]) {
                cell.ejareLabel.text=@"۶۰ میلیون تومان";
            }
            if ([cell.ejareLabel.text isEqualToString:@"70000000"]) {
                cell.ejareLabel.text=@"۷۰ میلیون تومان";
            }
            if ([cell.ejareLabel.text isEqualToString:@"80000000"]) {
                cell.ejareLabel.text=@"۸۰ میلیون تومان";
            }
            if ([cell.ejareLabel.text isEqualToString:@"90000000"]) {
                cell.ejareLabel.text=@"۹۰ میلیون تومان";
            }
        }
        if ([cell.ejareLabel.text length] == 9)
        {
            NSString*text2=[cell.ejareLabel.text substringToIndex:3];
            NSString*text3=[cell.ejareLabel.text substringWithRange:(NSMakeRange(3, 3))];
            cell.ejareLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
            if ([cell.ejareLabel.text isEqualToString:@"100000000"]) {
                cell.ejareLabel.text=@"۱۰۰ میلیون";
            }
            if ([cell.ejareLabel.text isEqualToString:@"200000000"]) {
                cell.ejareLabel.text=@"۲۰۰ میلیون";
            }
            if ([cell.ejareLabel.text isEqualToString:@"300000000"]) {
                cell.ejareLabel.text=@"۳۰۰ میلیون";
            }
            if ([cell.ejareLabel.text isEqualToString:@"400000000"]) {
                cell.ejareLabel.text=@"۴۰۰ میلیون";
            }
            if ([cell.ejareLabel.text isEqualToString:@"500000000"]) {
                cell.ejareLabel.text=@"۵۰۰ میلیون";
            }
            if ([cell.ejareLabel.text isEqualToString:@"600000000"]) {
                cell.ejareLabel.text=@"۶۰۰ میلیون";
            }
            if ([cell.ejareLabel.text isEqualToString:@"700000000"]) {
                cell.ejareLabel.text=@"۷۰۰ میلیون";
            }
            if ([cell.ejareLabel.text isEqualToString:@"800000000"]) {
                cell.ejareLabel.text=@"۸۰۰ میلیون";
            }
            if ([cell.ejareLabel.text isEqualToString:@"900000000"]) {
                cell.ejareLabel.text=@"۹۰۰ میلیون";
            }
        }
    }
    if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isKindOfClass:[NSNull class]]||[[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"0"]){
        cell.rahnLabel.text=@"مشخص نشده";
    }
    else{
        cell.rahnLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"];
        if ([cell.rahnLabel.text length] == 1)
        {
            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@",cell.rahnLabel.text,@"تومان"];
        }
        if ([cell.rahnLabel.text length] == 2)
        {
            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@",cell.rahnLabel.text,@"تومان"];
        }
        if ([cell.rahnLabel.text length] == 3)
        {
            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@",cell.rahnLabel.text,@"تومان"];
        }
        
        if ([cell.rahnLabel.text length] == 9)
        {
            NSString*text2=[cell.rahnLabel.text substringToIndex:3];
            NSString*text3=[cell.rahnLabel.text substringWithRange:(NSMakeRange(3, 3))];
            
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&[[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            
            if([text3 isEqualToString:@""]){
                cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@",[text2 substringToIndex:[text2 length]],@"میلیون تومان"];
            }
            else{
                cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
            }
            if ([cell.rahnLabel.text isEqualToString:@"100000000"]) {
                cell.rahnLabel.text=@"۱۰۰ میلیون";
            }
            if ([cell.rahnLabel.text isEqualToString:@"200000000"]) {
                cell.rahnLabel.text=@"۲۰۰ میلیون";
            }
            if ([cell.rahnLabel.text isEqualToString:@"300000000"]) {
                cell.rahnLabel.text=@"۳۰۰ میلیون";
            }
            if ([cell.rahnLabel.text isEqualToString:@"400000000"]) {
                cell.rahnLabel.text=@"۴۰۰ میلیون";
            }
            if ([cell.rahnLabel.text isEqualToString:@"500000000"]) {
                cell.rahnLabel.text=@"۵۰۰ میلیون";
            }
            if ([cell.rahnLabel.text isEqualToString:@"600000000"]) {
                cell.rahnLabel.text=@"۶۰۰ میلیون";
            }
            if ([cell.rahnLabel.text isEqualToString:@"700000000"]) {
                cell.rahnLabel.text=@"۷۰۰ میلیون";
            }
            if ([cell.rahnLabel.text isEqualToString:@"800000000"]) {
                cell.rahnLabel.text=@"۸۰۰ میلیون";
            }
            if ([cell.rahnLabel.text isEqualToString:@"900000000"]) {
                cell.rahnLabel.text=@"۹۰۰ میلیون";
            }
            
        }
        
        if ([cell.rahnLabel.text length] == 8)
        {
            //            NSString*text2=[cell.rahnLabel.text substringToIndex:2];
            //            NSString*text3=[cell.rahnLabel.text substringWithRange:(NSMakeRange(2,3))];
            //            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
            
            
            NSString*text2=[cell.rahnLabel.text substringToIndex:2];
            NSString*text3=[cell.rahnLabel.text substringWithRange:(NSMakeRange(2, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            
            if([text3 isEqualToString:@""]){
                cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@",[text2 substringToIndex:[text2 length]],@"میلیون تومان"];
            }
            else{
                cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"10000000"]) {
                cell.rahnLabel.text=@"۱۰ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"20000000"]) {
                cell.rahnLabel.text=@"۲۰ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"30000000"]) {
                cell.rahnLabel.text=@"۳۰ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"40000000"]) {
                cell.rahnLabel.text=@"۴۰ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"50000000"]) {
                cell.rahnLabel.text=@"۵۰ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"60000000"]) {
                cell.rahnLabel.text=@"۶۰ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"70000000"]) {
                cell.rahnLabel.text=@"۷۰ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"80000000"]) {
                cell.rahnLabel.text=@"۸۰ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"90000000"]) {
                cell.rahnLabel.text=@"۹۰ میلیون تومان";
            }
            
        }
        
        
        if ([cell.rahnLabel.text length] == 7)
        {
            NSString*text2=[cell.rahnLabel.text substringToIndex:1];
            NSString*text3=[cell.rahnLabel.text substringWithRange:(NSMakeRange(1, 3))];
            
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            
            
            
            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
            
            //            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"1000000"]) {
                cell.rahnLabel.text=@"۱ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"2000000"]) {
                cell.rahnLabel.text=@"۲ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"3000000"]) {
                cell.rahnLabel.text=@"۳ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"4000000"]) {
                cell.rahnLabel.text=@"۴ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"5000000"]) {
                cell.rahnLabel.text=@"۵ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"6000000"]) {
                cell.rahnLabel.text=@"۶ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"7000000"]) {
                cell.rahnLabel.text=@"۷ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"8000000"]) {
                cell.rahnLabel.text=@"۸ میلیون تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"9000000"]) {
                cell.rahnLabel.text=@"۹ میلیون تومان";
            }
        }
        
        if ([cell.rahnLabel.text length] == 6)
        {
            NSString*text2=[cell.rahnLabel.text substringToIndex:3];
            NSString*text3=[cell.rahnLabel.text substringWithRange:(NSMakeRange(3, 3))];
            
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            
            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
            
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"100000"]) {
                cell.rahnLabel.text=@"۱۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"200000"]) {
                cell.rahnLabel.text=@"۲۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"300000"]) {
                cell.rahnLabel.text=@"۳۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"400000"]) {
                cell.rahnLabel.text=@"۴۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"500000"]) {
                cell.rahnLabel.text=@"۵۰۰ هزار د";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"600000"]) {
                cell.rahnLabel.text=@"۶۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"700000"]) {
                cell.rahnLabel.text=@"۷۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"800000"]) {
                cell.rahnLabel.text=@"۸۰۰ هزار تومان";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"900000"]) {
                cell.rahnLabel.text=@"۹۰۰ هزار تومان";
            }
        }
        
        
        if ([cell.rahnLabel.text length] == 5)
        {
            NSString*text2=[cell.rahnLabel.text substringToIndex:2];
            NSString*text3=[cell.rahnLabel.text substringWithRange:(NSMakeRange(2, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            
            
            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
            
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"10000"]) {
                cell.rahnLabel.text=@"۱۰ هزار";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"20000"]) {
                cell.rahnLabel.text=@"۲۰ هزار";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"30000"]) {
                cell.rahnLabel.text=@"۳۰ هزار";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"40000"]) {
                cell.rahnLabel.text=@"۴۰ هزار";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"50000"]) {
                cell.rahnLabel.text=@"۵۰ هزار";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"60000"]) {
                cell.rahnLabel.text=@"۶۰ هزار";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"70000"]) {
                cell.rahnLabel.text=@"۷۰ هزار";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"80000"]) {
                cell.rahnLabel.text=@"۸۰ هزار";
            }
            if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"Mortgage"] isEqualToString:@"90000"]) {
                cell.rahnLabel.text=@"۹۰ هزار";
            }
            
        }
        
        if ([cell.rahnLabel.text length] == 4)
        {
            NSString*text2=[cell.rahnLabel.text substringToIndex:1];
            NSString*text3=[cell.rahnLabel.text substringWithRange:(NSMakeRange(1, 3))];
            
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
                
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            
            
            
            cell.rahnLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
            
            if ([cell.rahnLabel.text isEqualToString:@"1000"]) {
                cell.rahnLabel.text=@"۱ هزار";
            }
            if ([cell.rahnLabel.text isEqualToString:@"2000"]) {
                cell.rahnLabel.text=@"۲ هزار";
            }
            if ([cell.rahnLabel.text isEqualToString:@"3000"]) {
                cell.rahnLabel.text=@"۳ هزار";
            }
            if ([cell.rahnLabel.text isEqualToString:@"4000"]) {
                cell.rahnLabel.text=@"۴ هزار";
            }
            if ([cell.rahnLabel.text isEqualToString:@"5000"]) {
                cell.rahnLabel.text=@"۵ هزار";
            }
            if ([cell.rahnLabel.text isEqualToString:@"6000"]) {
                cell.rahnLabel.text=@"۶ هزار";
            }
            if ([cell.rahnLabel.text isEqualToString:@"7000"]) {
                cell.rahnLabel.text=@"۷ هزار";
            }
            if ([cell.rahnLabel.text isEqualToString:@"8000"]) {
                cell.rahnLabel.text=@"۸ هزار";
            }
            if ([cell.rahnLabel.text isEqualToString:@"9000"]) {
                cell.rahnLabel.text=@"۹ هزار";
            }
            
        }
        
    }
    
    if ([[[tableArray objectAtIndex:indexPath.row]objectForKey:@"type_of_transaction"] isEqualToString:@"رهن و اجاره"]) {
        cell.rahnView.hidden=NO;
    }
    cell.typeLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"type_of_transaction"];
    cell.nameLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"property_type"];
    cell.locationLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"region"];
    cell.dateLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"adddate"];
    cell.IDlabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
    cell.areaLabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"area"]];
    //cell.bedroomlabel.text=[NSString stringWithFormat:@"%@",[[tableArray objectAtIndex:indexPath.row]objectForKey:@"bedroom"]];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark -  NSTouch
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touches)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer];
    [self.forooshScrollView addGestureRecognizer:recognizer];
    [self.ejareScrollView addGestureRecognizer:recognizer];
    [self.forooshTypetextField endEditing:YES];
    [self.forooshregionTextField endEditing:YES];
    [self.ejareTypetextField endEditing:YES];
    [self.ejareregionTextField endEditing:YES];
}
-(void)touches
{
    [self.forooshregionTextField endEditing:YES];
    [self.forooshTypetextField endEditing:YES];
    [self.ejareTypetextField endEditing:YES];
    [self.ejareregionTextField endEditing:YES];
}
#pragma mark -  PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if (pickerView==forooshTypePickerView) {
        return [typeArray count];
    }
    return NO;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==forooshTypePickerView) {
        [self.forooshTypetextField setText:[typeArray objectAtIndex:row]];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView==forooshTypePickerView) {
        return [typeArray objectAtIndex:row];
    }
    return 0;
}

#pragma mark -  Scrollview
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"search_app"];
        if ([self.SearchTypelabel.text isEqualToString:@"رهن و اجاره"])
        {
            
            [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
            NSString*pageStr;
            pageInt++;
            
            NSString* string1 = [NSString stringWithFormat:@"%d%@",(int)self.ejarehSlider.leftValue,@"0000"];
            NSString* string2 = [NSString stringWithFormat:@"%d%@",(int)self.ejarehSlider.leftValue,@"0000"];
            NSString* string3 = [NSString stringWithFormat:@"%d%@",(int)self.ejarehSlider.leftValue,@"00000"];
            NSString* string4 = [NSString stringWithFormat:@"%d%@",(int)self.ejarehSlider.leftValue,@"00000"];
            strFromInt1 = [NSString stringWithFormat:@"%@",string1];
            strFromInt2 = [NSString stringWithFormat:@"%@",string2];
            strFromInt3 = [NSString stringWithFormat:@"%@",string3];
            strFromInt4 = [NSString stringWithFormat:@"%@",string4];
            
            
            pageStr=[NSString stringWithFormat:@"%d", pageInt];
            params[@"page"] =pageStr;
            params[@"type_of_transaction"] =self.SearchTypelabel.text;
            params[@"property_type"] = self.ejareTypetextField.text;
            params[@"region"] = self.regionidLabel.text;
            params[@"khab"] = khabid;
            params[@"min_area"] = self.EjarehleftValuearea.text;
            params[@"max_area"] = self.EjarehrightValuearea.text;
            params[@"min_rent"] = strFromInt1;
            params[@"max_rent"] = strFromInt2;
            params[@"min_mortgage"] = strFromInt3;
            params[@"max_mortgage"] = strFromInt4;
            params[@"min_price"] =@"";
            params[@"max_price"] = @"";
            params[@"channel"] = @"baamyab";
    
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                for (NSDictionary *dic in [responseObject objectForKey:@"result"] ) {
                    
                    [tableArray addObject:dic];
                }
                
                [SVProgressHUD dismiss];
                [self.tableview reloadData];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        }
        else
        {
            [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
            NSString*pageStr;
            pageInt++;
            NSString *strFromInt = [NSString stringWithFormat:@"%d",(int)self.forooshpriceslider.leftValue];
            NSString *strFromInt5 = [NSString stringWithFormat:@"%d",(int)self.forooshpriceslider.rightValue];
            params[@"type_of_transaction"] =self.SearchTypelabel.text;
            params[@"property_type"] = self.forooshTypetextField.text;
            params[@"region"] = self.regionidLabel.text;
            params[@"khab"] = khabid;
            params[@"min_area"] = self.leftValuearea.text;
            params[@"max_area"] = self.rightValuearea.text;
            params[@"min_price"] =strFromInt;
            params[@"max_price"] =strFromInt5;
            //  params[@"min_rent"] = @"";
            //  params[@"max_rent"] = @"";
            //  params[@"min_mortgage"] = @"";
            //  params[@"max_mortgage"] = @"";
            pageStr=[NSString stringWithFormat:@"%d", pageInt];
            params[@"page"] =pageStr;
            params[@"channel"] = @"baamyab";
        }
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            for (NSDictionary *dic in [responseObject objectForKey:@"result"] ) {
                [tableArray addObject:dic];
            }
            [self.tableview reloadData];
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }
}

#pragma mark -  Textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.ejareTypetextField resignFirstResponder];
    [self.forooshTypetextField resignFirstResponder];
    [self.ejareregionTextField resignFirstResponder];
    [self.forooshregionTextField resignFirstResponder];
    return NO;
}
#pragma mark -  custom
-(void)addPickerView
{
    forooshTypePickerView = [[UIPickerView alloc]init];
    forooshTypePickerView.dataSource = self;
    forooshTypePickerView.delegate = self;
    forooshTypePickerView.showsSelectionIndicator = YES;
    forooshTypePickerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.forooshTypetextField.inputView = forooshTypePickerView;
    self.ejareTypetextField.inputView = forooshTypePickerView;
}
-(IBAction)search
{ Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"به اینترنت متصل شوید" delegate:self cancelButtonTitle:@"تایید" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        
        [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"search_app"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        if ([self.SearchTypelabel.text isEqualToString:@"رهن و اجاره"])
        {
            NSString* string1 = [NSString stringWithFormat:@"%d%@",(int)self.ejarehSlider.leftValue,@""];
            NSString* string2 = [NSString stringWithFormat:@"%d%@",(int)self.ejarehSlider.rightValue,@""];
            NSString* string3 = [NSString stringWithFormat:@"%d%@",(int)self.rahnSlider.leftValue,@""];
            NSString* string4 = [NSString stringWithFormat:@"%d%@",(int)self.rahnSlider.rightValue,@""];
            if ([self.ejarehleftvalueLabel.text isEqualToString:@"1"]) {
                strFromInt1=@"0";
            }else{
                strFromInt1 = [NSString stringWithFormat:@"%@%@",string1,@"000"];
            }
            strFromInt2 = [NSString stringWithFormat:@"%@%@",string2,@"000"];
            if ([self.rahnleftvalueLabel.text isEqualToString:@"1"]) {
                strFromInt3=@"0";
            }else{
                strFromInt3 = [NSString stringWithFormat:@"%@%@",string3,@"000000"];
            }
            strFromInt4 = [NSString stringWithFormat:@"%@%@",string4,@"000000"];
            params[@"type_of_transaction"] =self.SearchTypelabel.text;
            params[@"property_type"] = self.ejareTypetextField.text;
            params[@"region"] = self.regionidLabel.text;
            params[@"khab"] = khabid;
            params[@"min_area"] = self.EjarehleftValuearea.text;
            params[@"max_area"] = self.EjarehrightValuearea.text;
            params[@"min_rent"] = strFromInt1;
            params[@"max_rent"] = strFromInt2;
            params[@"min_mortgage"] = strFromInt3;
            params[@"max_mortgage"] = strFromInt4;
            params[@"min_price"] =@"";
            params[@"max_price"] = @"";
            params[@"channel"] = @"baamyab";
        }
        else
        {
            NSString *strFromInt = [NSString stringWithFormat:@"%d",(int)self.forooshpriceslider.leftValue];
            NSString *str = [NSString stringWithFormat:@"%d",(int)self.forooshpriceslider.rightValue];
            params[@"type_of_transaction"] =self.SearchTypelabel.text;
            params[@"property_type"] = self.forooshTypetextField.text;
            params[@"region"] = self.regionidLabel.text;
            params[@"khab"] = khabid;
            params[@"min_area"] = self.leftValuearea.text;
            params[@"max_area"] = self.rightValuearea.text;
            params[@"min_price"] =strFromInt;
            params[@"max_price"] = str;
            //  params[@"min_rent"] = @"";
            //  params[@"max_rent"] = @"";
            //  params[@"min_mortgage"] = @"";
            //  params[@"max_mortgage"] = @"";
            //  params[@"page"] = @"0";
            params[@"channel"] = @"baamyab";
        }
        //
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            tableArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in [responseObject objectForKey:@"result"] ) {
                [tableArray addObject:dic];
            }
            [self.tableview reloadData];
            self.tableview.hidden=NO;
            self.backbtn.hidden=NO;
            if (tableArray.count==0) {
                self.tableview.hidden=YES;
                self.noresultview.hidden=NO;
            }
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}
-(IBAction)close{
    self.noresultview.hidden=YES;
    self.tableview.hidden=YES;
    self.backbtn.hidden=YES;
}
-(IBAction)back{
    NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
    [defualt setObject:@"3" forKey:@"backID"];
    [defualt synchronize];
}
-(IBAction)getregion{
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:@"1" forKey:@"regionid"];
    [defualt1 synchronize];
    [self.backButton2 setHidden:NO];
}


- (void)sliderChanged3 {
    //    if (((int)self.slider.leftValue>1000&&(int)self.slider.leftValue<1100)) {
    //        self.leftValueLabel.text=@"1000";
    //    }
    //    if (((int)self.slider.leftValue>1100&&(int)self.slider.leftValue<1200)) {
    //        self.leftValueLabel.text=@"1100";
    //    }
    //    if (((int)self.slider.leftValue>1200&&(int)self.slider.leftValue<1300)) {
    //        self.leftValueLabel.text=@"1200";
    //    }
    //    if (((int)self.slider.leftValue>1300&&(int)self.slider.leftValue<1400)) {
    //        self.leftValueLabel.text=@"1300";
    //    }
    //    if (((int)self.slider.leftValue>1400&&(int)self.slider.leftValue<1500)) {
    //        self.leftValueLabel.text=@"1400";
    //    }
    //    if (((int)self.slider.leftValue>1500&&(int)self.slider.leftValue<1600)) {
    //        self.leftValueLabel.text=@"1500";
    //    }
    //    if (((int)self.slider.leftValue>1600&&(int)self.slider.leftValue<1700)) {
    //        self.leftValueLabel.text=@"1600";
    //    }
    //    if (((int)self.slider.leftValue>1700&&(int)self.slider.leftValue<1800)) {
    //        self.leftValueLabel.text=@"1700";
    //    }
    //    if (((int)self.slider.leftValue>1800&&(int)self.slider.leftValue<1900)) {
    //        self.leftValueLabel.text=@"1800";
    //    }
    //    if (((int)self.slider.leftValue>1900&&(int)self.slider.leftValue<2000)) {
    //        self.leftValueLabel.text=@"1900";
    //    }
    //    if (((int)self.slider.leftValue>2000&&(int)self.slider.leftValue<2100)) {
    //        self.leftValueLabel.text=@"2000";
    //    }
    //    if (((int)self.slider.leftValue>2100&&(int)self.slider.leftValue<2200)) {
    //        self.leftValueLabel.text=@"2200";
    //    }
    //    if (((int)self.slider.leftValue>2200&&(int)self.slider.leftValue<2300)) {
    //        self.leftValueLabel.text=@"2300";
    //    }
    //    if (((int)self.slider.leftValue>2300&&(int)self.slider.leftValue<2400)) {
    //        self.leftValueLabel.text=@"2400";
    //    }
    //    if (((int)self.slider.leftValue>2400&&(int)self.slider.leftValue<2500)) {
    //        self.leftValueLabel.text=@"2500";
    //    }
    //    self.Area2.text =  [NSString stringWithFormat:@"%d", (int)self.myslider.value];
    self.forooshroomLabel.text =  [NSString stringWithFormat:@"%d", (int)self.forooshroomslider.value];
    if ([self.forooshroomLabel.text isEqualToString:@"0"]) {
        self.forooshroomLabel.text=@"بدون اهمیت";
        khabid=@"0";
    }
    if ([self.forooshroomLabel.text isEqualToString:@"1"]) {
        self.forooshroomLabel.text=@"۱ خواب";
        khabid=@"1";
    }
    if ([self.forooshroomLabel.text isEqualToString:@"2"]) {
        self.forooshroomLabel.text=@"۲ خواب";
        khabid=@"2";
    }
    if ([self.forooshroomLabel.text isEqualToString:@"3"]) {
        self.forooshroomLabel.text=@"۳ خواب";
        khabid=@"3";
    }
    if ([self.forooshroomLabel.text isEqualToString:@"4"]) {
        self.forooshroomLabel.text=@"۴ خواب";
        khabid=@"4";
    }
    if ([self.forooshroomLabel.text isEqualToString:@"5"]) {
        self.forooshroomLabel.text=@"۵ خواب";
        khabid=@"5";
    }
    if ([self.forooshroomLabel.text isEqualToString:@"6"]) {
        self.forooshroomLabel.text=@"بیش از ۵";
        khabid=@"6";
    }
    
    self.ejareroomLabel.text =  [NSString stringWithFormat:@"%d", (int)self.ejarehareaSlider.value];
    
    if ([self.ejareroomLabel.text isEqualToString:@"0"]) {
        self.ejareroomLabel.text=@"بدون اهمیت";
        khabid=@"0";
    }
    if ([self.ejareroomLabel.text isEqualToString:@"1"]) {
        self.ejareroomLabel.text=@"۱ خواب";
        khabid=@"1";
    }
    if ([self.ejareroomLabel.text isEqualToString:@"2"]) {
        self.ejareroomLabel.text=@"۲ خواب";
        khabid=@"2";
    }
    if ([self.ejareroomLabel.text isEqualToString:@"3"]) {
        self.ejareroomLabel.text=@"۳ خواب";
        khabid=@"3";
    }
    if ([self.ejareroomLabel.text isEqualToString:@"4"]) {
        self.ejareroomLabel.text=@"۴ خواب";
        khabid=@"4";
    }
    if ([self.ejareroomLabel.text isEqualToString:@"5"]) {
        self.ejareroomLabel.text=@"۵ خواب";
        khabid=@"5";
    }
    if ([self.ejareroomLabel.text isEqualToString:@"6"]) {
        self.ejareroomLabel.text=@"بیش از ۵";
        khabid=@"6";
    }
}

-(void)method:(BJRangeSliderWithProgress*)slide{
    self.forooshleftValueLabel.text =  [NSString stringWithFormat:@"%d", (int)self.forooshpriceslider.leftValue];
    self.forooshrightValueLabel.text =  [NSString stringWithFormat:@"%d", (int)self.forooshpriceslider.rightValue];
    self.leftValuearea.text =  [NSString stringWithFormat:@"%d", (int)self.Areaslider.leftValue];
    self.rightValuearea.text =  [NSString stringWithFormat:@"%d", (int)self.Areaslider.rightValue];
    self.EjarehleftValuearea.text =  [NSString stringWithFormat:@"%d", (int)self.EjarehAreaslider.leftValue];
    self.EjarehrightValuearea.text =  [NSString stringWithFormat:@"%d", (int)self.EjarehAreaslider.rightValue];
    self.ejarehleftvalueLabel.text =  [NSString stringWithFormat:@"%d", (int)self.ejarehSlider.leftValue];
    self.ejarehrightvalueLabel.text =  [NSString stringWithFormat:@"%d", (int)self.ejarehSlider.rightValue];
    self.rahnleftvalueLabel.text =  [NSString stringWithFormat:@"%d", (int)self.rahnSlider.leftValue];
    self.rahnrightvalueLabel.text =  [NSString stringWithFormat:@"%d", (int)self.rahnSlider.rightValue];
    
    if ((int)self.forooshpriceslider.leftValue==0) {
        self.forooshleftValueLabel.text=@"1";
    }
    if ((int)self.forooshpriceslider.rightValue==0) {
        self.forooshrightValueLabel.text=@"1";
    }
    if ((int)self.ejarehSlider.leftValue==0) {
        self.ejarehleftvalueLabel.text=@"1";
    }
    if ((int)self.ejarehSlider.rightValue==0) {
        self.forooshrightValueLabel.text=@"1";
    }
    
    if ((int)self.rahnSlider.leftValue==0) {
        self.rahnleftvalueLabel.text=@"1";
    }
    if ((int)self.rahnSlider.rightValue==0) {
        self.rahnrightvalueLabel.text=@"1";
    }
    if (((int)self.forooshpriceslider.leftValue>1&&(int)self.forooshpriceslider.leftValue<10)) {
        self.forooshleftValueLabel.text=@"10";
    }
    if (((int)self.forooshpriceslider.leftValue>10&&(int)self.forooshpriceslider.leftValue<20)){
        self.forooshleftValueLabel.text=@"20";
    }
    if (((int)self.forooshpriceslider.leftValue>20&&(int)self.forooshpriceslider.leftValue<30)) {
        self.forooshleftValueLabel.text=@"30";
    }
    if (((int)self.forooshpriceslider.leftValue>30&&(int)self.forooshpriceslider.leftValue<40)) {
        self.forooshleftValueLabel.text=@"40";
    }
    if (((int)self.forooshpriceslider.leftValue>40&&(int)self.forooshpriceslider.leftValue<50)) {
        self.forooshleftValueLabel.text=@"50";
    }
    if (((int)self.forooshpriceslider.leftValue>50&&(int)self.forooshpriceslider.leftValue<60)) {
        self.forooshleftValueLabel.text=@"60";
    }
    if (((int)self.forooshpriceslider.leftValue>60&&(int)self.forooshpriceslider.leftValue<70)) {
        self.forooshleftValueLabel.text=@"70";
    }
    if (((int)self.forooshpriceslider.leftValue>70&&(int)self.forooshpriceslider.leftValue<80)) {
        self.forooshleftValueLabel.text=@"80";
    }
    if (((int)self.forooshpriceslider.leftValue>80&&(int)self.forooshpriceslider.leftValue<90)) {
        self.forooshleftValueLabel.text=@"90";
    }
    if (((int)self.forooshpriceslider.leftValue>100&&(int)self.forooshpriceslider.leftValue<200)) {
        self.forooshleftValueLabel.text=@"100";
    }
    if (((int)self.forooshpriceslider.leftValue>200&&(int)self.forooshpriceslider.leftValue<300)){
        self.forooshleftValueLabel.text=@"200";
    }
    if (((int)self.forooshpriceslider.leftValue>300&&(int)self.forooshpriceslider.leftValue<400)) {
        self.forooshleftValueLabel.text=@"300";
    }
    if (((int)self.forooshpriceslider.leftValue>400&&(int)self.forooshpriceslider.leftValue<500)) {
        self.forooshleftValueLabel.text=@"400";
    }
    if (((int)self.forooshpriceslider.leftValue>500&&(int)self.forooshpriceslider.leftValue<600)) {
        self.forooshleftValueLabel.text=@"500";
    }
    if (((int)self.forooshpriceslider.leftValue>600&&(int)self.forooshpriceslider.leftValue<700)) {
        self.forooshleftValueLabel.text=@"600";
    }
    if (((int)self.forooshpriceslider.leftValue>700&&(int)self.forooshpriceslider.leftValue<800)) {
        self.forooshleftValueLabel.text=@"700";
    }
    if (((int)self.forooshpriceslider.leftValue>800&&(int)self.forooshpriceslider.leftValue<900)) {
        self.forooshleftValueLabel.text=@"800";
    }
    if (((int)self.forooshpriceslider.leftValue>900&&(int)self.forooshpriceslider.leftValue<1000)) {
        self.forooshleftValueLabel.text=@"900";
    }
    if (((int)self.forooshpriceslider.leftValue>1000&&(int)self.forooshpriceslider.leftValue<1100)) {
        self.forooshleftValueLabel.text=@"1000";
    }
    if (((int)self.forooshpriceslider.leftValue>1100&&(int)self.forooshpriceslider.leftValue<1200)){
        self.forooshleftValueLabel.text=@"1100";
    }
    if (((int)self.forooshpriceslider.leftValue>1200&&(int)self.forooshpriceslider.leftValue<1300)) {
        self.forooshleftValueLabel.text=@"1200";
    }
    if (((int)self.forooshpriceslider.leftValue>1300&&(int)self.forooshpriceslider.leftValue<1400)) {
        self.forooshleftValueLabel.text=@"1300";
    }
    if (((int)self.forooshpriceslider.leftValue>1400&&(int)self.forooshpriceslider.leftValue<1500)) {
        self.forooshleftValueLabel.text=@"1400";
    }
    if (((int)self.forooshpriceslider.leftValue>1500&&(int)self.forooshpriceslider.leftValue<1600)) {
        self.forooshleftValueLabel.text=@"1500";
    }
    if (((int)self.forooshpriceslider.leftValue>1600&&(int)self.forooshpriceslider.leftValue<1700)) {
        self.forooshleftValueLabel.text=@"1600";
    }
    if (((int)self.forooshpriceslider.leftValue>1700&&(int)self.forooshpriceslider.leftValue<1800)) {
        self.forooshleftValueLabel.text=@"1700";
    }
    if (((int)self.forooshpriceslider.leftValue>1800&&(int)self.forooshpriceslider.leftValue<1900)) {
        self.forooshleftValueLabel.text=@"1800";
    }
    if (((int)self.forooshpriceslider.leftValue>1900&&(int)self.forooshpriceslider.leftValue<2000)) {
        self.forooshleftValueLabel.text=@"1900";
    }
    if (((int)self.forooshpriceslider.leftValue>2000&&(int)self.forooshpriceslider.leftValue<2100)) {
        self.forooshleftValueLabel.text=@"2000";
    }
    if (((int)self.forooshpriceslider.leftValue>2100&&(int)self.forooshpriceslider.leftValue<2200)) {
        self.forooshleftValueLabel.text=@"2100";
    }
    if (((int)self.forooshpriceslider.leftValue>2200&&(int)self.forooshpriceslider.leftValue<2300)) {
        self.forooshleftValueLabel.text=@"2200";
    }
    if (((int)self.forooshpriceslider.leftValue>2300&&(int)self.forooshpriceslider.leftValue<2400)) {
        self.forooshleftValueLabel.text=@"2300";
    }
    if (((int)self.forooshpriceslider.leftValue>2400&&(int)self.forooshpriceslider.leftValue<2500)) {
        self.forooshleftValueLabel.text=@"2400";
    }
    
    
    if (((int)self.forooshpriceslider.rightValue>1&&(int)self.forooshpriceslider.rightValue<10)) {
        self.forooshrightValueLabel.text=@"10";
    }
    if (((int)self.forooshpriceslider.rightValue>10&&(int)self.forooshpriceslider.rightValue<20)){
        self.forooshrightValueLabel.text=@"20";
    }
    if (((int)self.forooshpriceslider.rightValue>20&&(int)self.forooshpriceslider.rightValue<30)) {
        self.forooshrightValueLabel.text=@"30";
    }
    if (((int)self.forooshpriceslider.rightValue>30&&(int)self.forooshpriceslider.rightValue<40)) {
        self.forooshrightValueLabel.text=@"40";
    }
    if (((int)self.forooshpriceslider.rightValue>40&&(int)self.forooshpriceslider.rightValue<50)) {
        self.forooshrightValueLabel.text=@"50";
    }
    if (((int)self.forooshpriceslider.rightValue>50&&(int)self.forooshpriceslider.rightValue<60)) {
        self.forooshrightValueLabel.text=@"60";
    }
    if (((int)self.forooshpriceslider.rightValue>60&&(int)self.forooshpriceslider.rightValue<70)) {
        self.forooshrightValueLabel.text=@"70";
    }
    if (((int)self.forooshpriceslider.rightValue>70&&(int)self.forooshpriceslider.rightValue<80)) {
        self.forooshrightValueLabel.text=@"80";
    }
    if (((int)self.forooshpriceslider.rightValue>80&&(int)self.forooshpriceslider.rightValue<90))
    {
        self.forooshrightValueLabel.text=@"90";
    }
    
    
    if (((int)self.forooshpriceslider.rightValue>100&&(int)self.forooshpriceslider.rightValue<200)) {
        self.forooshrightValueLabel.text=@"100";
    }
    if (((int)self.forooshpriceslider.rightValue>200&&(int)self.forooshpriceslider.rightValue<300)){
        self.forooshrightValueLabel.text=@"200";
    }
    if (((int)self.forooshpriceslider.rightValue>300&&(int)self.forooshpriceslider.rightValue<400)) {
        self.forooshrightValueLabel.text=@"300";
    }
    if (((int)self.forooshpriceslider.rightValue>400&&(int)self.forooshpriceslider.rightValue<500)) {
        self.forooshrightValueLabel.text=@"400";
    }
    if (((int)self.forooshpriceslider.rightValue>500&&(int)self.forooshpriceslider.rightValue<600)) {
        self.forooshrightValueLabel.text=@"500";
    }
    if (((int)self.forooshpriceslider.rightValue>600&&(int)self.forooshpriceslider.rightValue<700)) {
        self.forooshrightValueLabel.text=@"600";
    }
    if (((int)self.forooshpriceslider.rightValue>700&&(int)self.forooshpriceslider.rightValue<800)) {
        self.forooshrightValueLabel.text=@"700";
    }
    if (((int)self.forooshpriceslider.rightValue>800&&(int)self.forooshpriceslider.rightValue<900)) {
        self.forooshrightValueLabel.text=@"800";
    }
    if (((int)self.forooshpriceslider.rightValue>900&&(int)self.forooshpriceslider.rightValue<1000))
    {
        self.forooshrightValueLabel.text=@"900";
    }
    if (((int)self.forooshpriceslider.rightValue>1000&&(int)self.forooshpriceslider.rightValue<1100)) {
        self.forooshrightValueLabel.text=@"1000";
    }
    if (((int)self.forooshpriceslider.rightValue>1100&&(int)self.forooshpriceslider.rightValue<1200)){
        self.forooshrightValueLabel.text=@"1100";
    }
    if (((int)self.forooshpriceslider.rightValue>1200&&(int)self.forooshpriceslider.rightValue<1300)) {
        self.forooshrightValueLabel.text=@"1200";
    }
    if (((int)self.forooshpriceslider.rightValue>1300&&(int)self.forooshpriceslider.rightValue<1400)) {
        self.forooshrightValueLabel.text=@"1300";
    }
    if (((int)self.forooshpriceslider.rightValue>1400&&(int)self.forooshpriceslider.rightValue<1500)) {
        self.forooshrightValueLabel.text=@"1400";
    }
    if (((int)self.forooshpriceslider.rightValue>1500&&(int)self.forooshpriceslider.rightValue<1600)) {
        self.forooshrightValueLabel.text=@"1500";
    }
    if (((int)self.forooshpriceslider.rightValue>1600&&(int)self.forooshpriceslider.rightValue<1700)) {
        self.forooshrightValueLabel.text=@"1600";
    }
    if (((int)self.forooshpriceslider.rightValue>1700&&(int)self.forooshpriceslider.rightValue<1800)) {
        self.forooshrightValueLabel.text=@"1700";
    }
    if (((int)self.forooshpriceslider.rightValue>1800&&(int)self.forooshpriceslider.rightValue<1900)) {
        self.forooshrightValueLabel.text=@"1800";
    }
    if (((int)self.forooshpriceslider.rightValue>1900&&(int)self.forooshpriceslider.rightValue<2000)) {
        self.forooshrightValueLabel.text=@"1900";
    }
    if (((int)self.forooshpriceslider.rightValue>2000&&(int)self.forooshpriceslider.rightValue<2100)) {
        self.forooshrightValueLabel.text=@"2000";
    }
    if (((int)self.forooshpriceslider.rightValue>2100&&(int)self.forooshpriceslider.rightValue<2200)) {
        self.forooshrightValueLabel.text=@"2100";
    }
    if (((int)self.forooshpriceslider.rightValue>2200&&(int)self.forooshpriceslider.rightValue<2300)) {
        self.forooshrightValueLabel.text=@"2200";
    }
    if (((int)self.forooshpriceslider.rightValue>2300&&(int)self.forooshpriceslider.rightValue<2400)) {
        self.forooshrightValueLabel.text=@"2300";
    }
    if (((int)self.forooshpriceslider.rightValue>2400&&(int)self.forooshpriceslider.rightValue<2500)) {
        self.forooshrightValueLabel.text=@"2400";
    }
    
    
    if (((int)self.Areaslider.rightValue>1&&(int)self.Areaslider.rightValue<5)){
        self.rightValuearea.text=@"5";
    }
    if (((int)self.Areaslider.rightValue>5&&(int)self.Areaslider.rightValue<10)){
        self.rightValuearea.text=@"10";
    }
    if (((int)self.Areaslider.rightValue>10&&(int)self.Areaslider.rightValue<15)) {
        self.rightValuearea.text=@"15";
    }
    if (((int)self.Areaslider.rightValue>15&&(int)self.Areaslider.rightValue<20)) {
        self.rightValuearea.text=@"20";
    }
    if (((int)self.Areaslider.rightValue>20&&(int)self.Areaslider.rightValue<25)) {
        self.rightValuearea.text=@"25";
    }
    if (((int)self.Areaslider.rightValue>25&&(int)self.Areaslider.rightValue<30)) {
        self.rightValuearea.text=@"30";
    }
    if (((int)self.Areaslider.rightValue>30&&(int)self.Areaslider.rightValue<35)) {
        self.rightValuearea.text=@"35";
    }
    if (((int)self.Areaslider.rightValue>35&&(int)self.Areaslider.rightValue<40)) {
        self.rightValuearea.text=@"40";
    }
    if (((int)self.Areaslider.rightValue>40&&(int)self.Areaslider.rightValue<45))
    {
        self.rightValuearea.text=@"45";
    }
    if (((int)self.Areaslider.rightValue>45&&(int)self.Areaslider.rightValue<50)){
        self.rightValuearea.text=@"50";
    }
    if (((int)self.Areaslider.rightValue>50&&(int)self.Areaslider.rightValue<55)){
        self.rightValuearea.text=@"55";
    }
    if (((int)self.Areaslider.rightValue>55&&(int)self.Areaslider.rightValue<60)) {
        self.rightValuearea.text=@"60";
    }
    if (((int)self.Areaslider.rightValue>60&&(int)self.Areaslider.rightValue<65)) {
        self.rightValuearea.text=@"65";
    }
    if (((int)self.Areaslider.rightValue>65&&(int)self.Areaslider.rightValue<70)) {
        self.rightValuearea.text=@"70";
    }
    if (((int)self.Areaslider.rightValue>70&&(int)self.Areaslider.rightValue<75)) {
        self.rightValuearea.text=@"75";
    }
    if (((int)self.Areaslider.rightValue>75&&(int)self.Areaslider.rightValue<80)) {
        self.rightValuearea.text=@"80";
    }
    if (((int)self.Areaslider.rightValue>80&&(int)self.Areaslider.rightValue<85)) {
        self.rightValuearea.text=@"85";
    }
    if (((int)self.Areaslider.rightValue>85&&(int)self.Areaslider.rightValue<90))
    {
        self.rightValuearea.text=@"90";
    }
    if (((int)self.Areaslider.rightValue>90&&(int)self.Areaslider.rightValue<95))
    {
        self.rightValuearea.text=@"95";
    }
    if (((int)self.Areaslider.rightValue>95&&(int)self.Areaslider.rightValue<100))
    {
        self.rightValuearea.text=@"100";
    }
    
    if (((int)self.Areaslider.rightValue>100&&(int)self.Areaslider.rightValue<200)){
        self.rightValuearea.text=@"100";
    }
    if (((int)self.Areaslider.rightValue>200&&(int)self.Areaslider.rightValue<300)){
        self.rightValuearea.text=@"200";
    }
    if (((int)self.Areaslider.rightValue>300&&(int)self.Areaslider.rightValue<400)) {
        self.rightValuearea.text=@"300";
    }
    if (((int)self.Areaslider.rightValue>400&&(int)self.Areaslider.rightValue<500)) {
        self.rightValuearea.text=@"400";
    }
    if (((int)self.Areaslider.rightValue>500&&(int)self.Areaslider.rightValue<600)) {
        self.rightValuearea.text=@"500";
    }
    if (((int)self.Areaslider.rightValue>600&&(int)self.Areaslider.rightValue<700)) {
        self.rightValuearea.text=@"600";
    }
    if (((int)self.Areaslider.rightValue>700&&(int)self.Areaslider.rightValue<800)) {
        self.rightValuearea.text=@"700";
    }
    if (((int)self.Areaslider.rightValue>800&&(int)self.Areaslider.rightValue<900)) {
        self.rightValuearea.text=@"800";
    }
    if (((int)self.Areaslider.rightValue>900&&(int)self.Areaslider.rightValue<1000))
    {
        self.rightValuearea.text=@"900";
    }
    if (((int)self.Areaslider.rightValue>1000&&(int)self.Areaslider.rightValue<1100)) {
        self.rightValuearea.text=@"1000";
    }
    if (((int)self.Areaslider.rightValue>1000&&(int)self.Areaslider.rightValue<1100)) {
        self.rightValuearea.text=@"1000";
    }
    if (((int)self.Areaslider.rightValue>1100&&(int)self.Areaslider.rightValue<1200)){
        self.rightValuearea.text=@"1100";
    }
    if (((int)self.Areaslider.rightValue>1200&&(int)self.Areaslider.rightValue<1300)) {
        self.rightValuearea.text=@"1200";
    }
    if (((int)self.Areaslider.rightValue>1300&&(int)self.Areaslider.rightValue<1400)) {
        self.rightValuearea.text=@"1300";
    }
    if (((int)self.Areaslider.rightValue>1400&&(int)self.Areaslider.rightValue<1500)) {
        self.rightValuearea.text=@"1400";
    }
    if (((int)self.Areaslider.rightValue>1500&&(int)self.Areaslider.rightValue<1600)) {
        self.rightValuearea.text=@"1500";
    }
    if (((int)self.Areaslider.rightValue>1600&&(int)self.Areaslider.rightValue<1700)) {
        self.rightValuearea.text=@"1600";
    }
    if (((int)self.Areaslider.rightValue>1700&&(int)self.Areaslider.rightValue<1800)) {
        self.rightValuearea.text=@"1700";
    }
    if (((int)self.Areaslider.rightValue>1800&&(int)self.Areaslider.rightValue<1900)) {
        self.rightValuearea.text=@"1800";
    }
    if (((int)self.Areaslider.rightValue>1900&&(int)self.Areaslider.rightValue<2000)) {
        self.rightValuearea.text=@"1900";
    }
    if (((int)self.Areaslider.rightValue>2000&&(int)self.Areaslider.rightValue<2100)) {
        self.rightValuearea.text=@"2000";
    }
    if (((int)self.Areaslider.rightValue>2100&&(int)self.Areaslider.rightValue<2200)) {
        self.rightValuearea.text=@"2100";
    }
    if (((int)self.Areaslider.rightValue>2200&&(int)self.Areaslider.rightValue<2300)) {
        self.rightValuearea.text=@"2200";
    }
    if (((int)self.Areaslider.rightValue>2300&&(int)self.Areaslider.rightValue<2400)) {
        self.rightValuearea.text=@"2300";
    }
    if (((int)self.Areaslider.rightValue>2400&&(int)self.Areaslider.rightValue<2500)) {
        self.rightValuearea.text=@"2400";
    }
    if (((int)self.Areaslider.leftValue>1&&(int)self.Areaslider.leftValue<5)){
        self.leftValuearea.text=@"5";
    }
    if (((int)self.Areaslider.leftValue>5&&(int)self.Areaslider.leftValue<10)){
        self.leftValuearea.text=@"10";
    }
    if (((int)self.Areaslider.leftValue>10&&(int)self.Areaslider.leftValue<15)) {
        self.leftValuearea.text=@"15";
    }
    if (((int)self.Areaslider.leftValue>15&&(int)self.Areaslider.leftValue<20)) {
        self.leftValuearea.text=@"20";
    }
    if (((int)self.Areaslider.leftValue>20&&(int)self.Areaslider.leftValue<25)) {
        self.leftValuearea.text=@"25";
    }
    if (((int)self.Areaslider.leftValue>25&&(int)self.Areaslider.leftValue<30)) {
        self.leftValuearea.text=@"30";
    }
    if (((int)self.Areaslider.leftValue>30&&(int)self.Areaslider.leftValue<35)) {
        self.leftValuearea.text=@"35";
    }
    if (((int)self.Areaslider.leftValue>35&&(int)self.Areaslider.leftValue<40)) {
        self.leftValuearea.text=@"40";
    }
    if (((int)self.Areaslider.leftValue>40&&(int)self.Areaslider.leftValue<45))
    {
        self.leftValuearea.text=@"45";
    }
    if (((int)self.Areaslider.leftValue>45&&(int)self.Areaslider.leftValue<50)){
        self.leftValuearea.text=@"50";
    }
    if (((int)self.Areaslider.leftValue>50&&(int)self.Areaslider.leftValue<55)){
        self.leftValuearea.text=@"55";
    }
    if (((int)self.Areaslider.leftValue>55&&(int)self.Areaslider.leftValue<60)) {
        self.leftValuearea.text=@"60";
    }
    if (((int)self.Areaslider.leftValue>60&&(int)self.Areaslider.leftValue<65)) {
        self.leftValuearea.text=@"65";
    }
    if (((int)self.Areaslider.leftValue>65&&(int)self.Areaslider.leftValue<70)) {
        self.leftValuearea.text=@"70";
    }
    if (((int)self.Areaslider.leftValue>70&&(int)self.Areaslider.leftValue<75)) {
        self.leftValuearea.text=@"75";
    }
    if (((int)self.Areaslider.leftValue>75&&(int)self.Areaslider.leftValue<80)) {
        self.leftValuearea.text=@"80";
    }
    if (((int)self.Areaslider.leftValue>80&&(int)self.Areaslider.leftValue<85)) {
        self.leftValuearea.text=@"85";
    }
    if (((int)self.Areaslider.leftValue>85&&(int)self.Areaslider.leftValue<90))
    {
        self.leftValuearea.text=@"90";
    }
    if (((int)self.Areaslider.leftValue>90&&(int)self.Areaslider.leftValue<95))
    {
        self.leftValuearea.text=@"95";
    }
    if (((int)self.Areaslider.leftValue>95&&(int)self.Areaslider.leftValue<100))
    {
        self.leftValuearea.text=@"100";
    }
    
    if (((int)self.Areaslider.leftValue>100&&(int)self.Areaslider.leftValue<200)) {
        self.leftValuearea.text=@"100";
    }
    if (((int)self.Areaslider.leftValue>200&&(int)self.Areaslider.leftValue<300)){
        self.leftValuearea.text=@"200";
    }
    if (((int)self.Areaslider.leftValue>300&&(int)self.Areaslider.leftValue<400)) {
        self.leftValuearea.text=@"300";
    }
    if (((int)self.Areaslider.leftValue>400&&(int)self.Areaslider.leftValue<500)) {
        self.leftValuearea.text=@"400";
    }
    if (((int)self.Areaslider.leftValue>500&&(int)self.Areaslider.leftValue<600)) {
        self.leftValuearea.text=@"500";
    }
    if (((int)self.Areaslider.leftValue>600&&(int)self.Areaslider.leftValue<700)) {
        self.leftValuearea.text=@"600";
    }
    if (((int)self.Areaslider.leftValue>700&&(int)self.Areaslider.leftValue<800)) {
        self.leftValuearea.text=@"700";
    }
    if (((int)self.Areaslider.leftValue>800&&(int)self.Areaslider.leftValue<900)) {
        self.leftValuearea.text=@"800";
    }
    if (((int)self.Areaslider.leftValue>900&&(int)self.Areaslider.leftValue<1000)) {
        self.leftValuearea.text=@"900";
    }
    if (((int)self.Areaslider.leftValue>1000&&(int)self.Areaslider.leftValue<1100)) {
        self.leftValuearea.text=@"1000";
    }
    if (((int)self.Areaslider.leftValue>1100&&(int)self.Areaslider.leftValue<1200)){
        self.leftValuearea.text=@"1100";
    }
    if (((int)self.Areaslider.leftValue>1200&&(int)self.Areaslider.leftValue<1300)) {
        self.leftValuearea.text=@"1200";
    }
    if (((int)self.Areaslider.leftValue>1300&&(int)self.Areaslider.leftValue<1400)) {
        self.leftValuearea.text=@"1300";
    }
    if (((int)self.Areaslider.leftValue>1400&&(int)self.Areaslider.leftValue<1500)) {
        self.leftValuearea.text=@"1400";
    }
    if (((int)self.Areaslider.leftValue>1500&&(int)self.Areaslider.leftValue<1600)) {
        self.leftValuearea.text=@"1500";
    }
    if (((int)self.Areaslider.leftValue>1600&&(int)self.Areaslider.leftValue<1700)) {
        self.leftValuearea.text=@"1600";
    }
    if (((int)self.Areaslider.leftValue>1700&&(int)self.Areaslider.leftValue<1800)) {
        self.leftValuearea.text=@"1700";
    }
    if (((int)self.Areaslider.leftValue>1800&&(int)self.Areaslider.leftValue<1900)) {
        self.leftValuearea.text=@"1800";
    }
    if (((int)self.Areaslider.leftValue>1900&&(int)self.Areaslider.leftValue<2000)) {
        self.leftValuearea.text=@"1900";
    }
    if (((int)self.Areaslider.leftValue>2000&&(int)self.Areaslider.leftValue<2100)) {
        self.leftValuearea.text=@"2000";
    }
    if (((int)self.Areaslider.leftValue>2100&&(int)self.Areaslider.leftValue<2200)) {
        self.leftValuearea.text=@"2100";
    }
    if (((int)self.Areaslider.leftValue>2200&&(int)self.Areaslider.leftValue<2300)) {
        self.leftValuearea.text=@"2200";
    }
    if (((int)self.Areaslider.leftValue>2300&&(int)self.Areaslider.leftValue<2400)) {
        self.leftValuearea.text=@"2300";
    }
    if (((int)self.Areaslider.leftValue>2400&&(int)self.Areaslider.leftValue<2500)) {
        self.leftValuearea.text=@"2400";
    }
    
    
    
    if (((int)self.EjarehAreaslider.leftValue>1&&(int)self.EjarehAreaslider.leftValue<5)){
        self.EjarehleftValuearea.text=@"5";
    }
    if (((int)self.EjarehAreaslider.leftValue>5&&(int)self.EjarehAreaslider.leftValue<10)){
        self.EjarehleftValuearea.text=@"10";
    }
    if (((int)self.EjarehAreaslider.leftValue>10&&(int)self.EjarehAreaslider.leftValue<15)) {
        self.EjarehleftValuearea.text=@"15";
    }
    if (((int)self.EjarehAreaslider.leftValue>15&&(int)self.EjarehAreaslider.leftValue<20)) {
        self.EjarehleftValuearea.text=@"20";
    }
    if (((int)self.EjarehAreaslider.leftValue>20&&(int)self.EjarehAreaslider.leftValue<25)) {
        self.EjarehleftValuearea.text=@"25";
    }
    if (((int)self.EjarehAreaslider.leftValue>25&&(int)self.EjarehAreaslider.leftValue<30)) {
        self.EjarehleftValuearea.text=@"30";
    }
    if (((int)self.EjarehAreaslider.leftValue>30&&(int)self.EjarehAreaslider.leftValue<35)) {
        self.EjarehleftValuearea.text=@"35";
    }
    if (((int)self.EjarehAreaslider.leftValue>35&&(int)self.EjarehAreaslider.leftValue<40)) {
        self.EjarehleftValuearea.text=@"40";
    }
    if (((int)self.EjarehAreaslider.leftValue>40&&(int)self.EjarehAreaslider.leftValue<45))
    {
        self.EjarehleftValuearea.text=@"45";
    }
    if (((int)self.EjarehAreaslider.leftValue>45&&(int)self.EjarehAreaslider.leftValue<50)){
        self.EjarehleftValuearea.text=@"50";
    }
    if (((int)self.EjarehAreaslider.leftValue>50&&(int)self.EjarehAreaslider.leftValue<55)){
        self.EjarehleftValuearea.text=@"55";
    }
    if (((int)self.EjarehAreaslider.leftValue>55&&(int)self.EjarehAreaslider.leftValue<60)) {
        self.EjarehleftValuearea.text=@"60";
    }
    if (((int)self.EjarehAreaslider.leftValue>60&&(int)self.EjarehAreaslider.leftValue<65)) {
        self.EjarehleftValuearea.text=@"65";
    }
    if (((int)self.EjarehAreaslider.leftValue>65&&(int)self.EjarehAreaslider.leftValue<70)) {
        self.EjarehleftValuearea.text=@"70";
    }
    if (((int)self.EjarehAreaslider.leftValue>70&&(int)self.EjarehAreaslider.leftValue<75)) {
        self.EjarehleftValuearea.text=@"75";
    }
    if (((int)self.EjarehAreaslider.leftValue>75&&(int)self.EjarehAreaslider.leftValue<80)) {
        self.EjarehleftValuearea.text=@"80";
    }
    if (((int)self.EjarehAreaslider.leftValue>80&&(int)self.EjarehAreaslider.leftValue<85)) {
        self.EjarehleftValuearea.text=@"85";
    }
    if (((int)self.EjarehAreaslider.leftValue>85&&(int)self.EjarehAreaslider.leftValue<90))
    {
        self.EjarehleftValuearea.text=@"90";
    }
    if (((int)self.EjarehAreaslider.leftValue>90&&(int)self.EjarehAreaslider.leftValue<95))
    {
        self.EjarehleftValuearea.text=@"95";
    }
    if (((int)self.EjarehAreaslider.leftValue>95&&(int)self.EjarehAreaslider.leftValue<100))
    {
        self.EjarehleftValuearea.text=@"100";
    }
    
    
    
    
    if (((int)self.EjarehAreaslider.leftValue>100&&(int)self.EjarehAreaslider.leftValue<200)) {
        self.EjarehleftValuearea.text=@"100";
    }
    if (((int)self.EjarehAreaslider.leftValue>200&&(int)self.EjarehAreaslider.leftValue<300)){
        self.EjarehleftValuearea.text=@"200";
    }
    if (((int)self.EjarehAreaslider.leftValue>300&&(int)self.EjarehAreaslider.leftValue<400)) {
        self.EjarehleftValuearea.text=@"300";
    }
    if (((int)self.EjarehAreaslider.leftValue>400&&(int)self.EjarehAreaslider.leftValue<500)) {
        self.EjarehleftValuearea.text=@"400";
    }
    if (((int)self.EjarehAreaslider.leftValue>500&&(int)self.EjarehAreaslider.leftValue<600)) {
        self.EjarehleftValuearea.text=@"500";
    }
    if (((int)self.EjarehAreaslider.leftValue>600&&(int)self.EjarehAreaslider.leftValue<700)) {
        self.EjarehleftValuearea.text=@"600";
    }
    if (((int)self.EjarehAreaslider.leftValue>700&&(int)self.EjarehAreaslider.leftValue<800)) {
        self.EjarehleftValuearea.text=@"700";
    }
    if (((int)self.EjarehAreaslider.leftValue>800&&(int)self.EjarehAreaslider.leftValue<900)) {
        self.EjarehleftValuearea.text=@"800";
    }
    if (((int)self.EjarehAreaslider.leftValue>900&&(int)self.EjarehAreaslider.leftValue<1000)) {
        self.EjarehleftValuearea.text=@"900";
    }
    if (((int)self.EjarehAreaslider.leftValue>1000&&(int)self.EjarehAreaslider.leftValue<1100)) {
        self.EjarehleftValuearea.text=@"1000";
    }
    if (((int)self.EjarehAreaslider.leftValue>1100&&(int)self.EjarehAreaslider.leftValue<1200)){
        self.EjarehleftValuearea.text=@"1100";
    }
    if (((int)self.EjarehAreaslider.leftValue>1200&&(int)self.EjarehAreaslider.leftValue<1300)) {
        self.EjarehleftValuearea.text=@"1200";
    }
    if (((int)self.EjarehAreaslider.leftValue>1300&&(int)self.EjarehAreaslider.leftValue<1400)) {
        self.EjarehleftValuearea.text=@"1300";
    }
    if (((int)self.EjarehAreaslider.leftValue>1400&&(int)self.EjarehAreaslider.leftValue<1500)) {
        self.EjarehleftValuearea.text=@"1400";
    }
    if (((int)self.EjarehAreaslider.leftValue>1500&&(int)self.EjarehAreaslider.leftValue<1600)) {
        self.EjarehleftValuearea.text=@"1500";
    }
    if (((int)self.EjarehAreaslider.leftValue>1600&&(int)self.EjarehAreaslider.leftValue<1700)) {
        self.EjarehleftValuearea.text=@"1600";
    }
    if (((int)self.EjarehAreaslider.leftValue>1700&&(int)self.EjarehAreaslider.leftValue<1800)) {
        self.EjarehleftValuearea.text=@"1700";
    }
    if (((int)self.EjarehAreaslider.leftValue>1800&&(int)self.EjarehAreaslider.leftValue<1900)) {
        self.EjarehleftValuearea.text=@"1800";
    }
    if (((int)self.EjarehAreaslider.leftValue>1900&&(int)self.EjarehAreaslider.leftValue<2000)) {
        self.EjarehleftValuearea.text=@"1900";
    }
    if (((int)self.EjarehAreaslider.leftValue>2000&&(int)self.EjarehAreaslider.leftValue<2100)) {
        self.EjarehleftValuearea.text=@"2000";
    }
    if (((int)self.EjarehAreaslider.leftValue>2100&&(int)self.EjarehAreaslider.leftValue<2200)) {
        self.EjarehleftValuearea.text=@"2100";
    }
    if (((int)self.EjarehAreaslider.leftValue>2200&&(int)self.EjarehAreaslider.leftValue<2300)) {
        self.EjarehleftValuearea.text=@"2200";
    }
    if (((int)self.EjarehAreaslider.leftValue>2300&&(int)self.EjarehAreaslider.leftValue<2400)) {
        self.EjarehleftValuearea.text=@"2300";
    }
    if (((int)self.EjarehAreaslider.leftValue>2400&&(int)self.EjarehAreaslider.leftValue<2500)) {
        self.EjarehleftValuearea.text=@"2400";
    }
    
    
    if (((int)self.EjarehAreaslider.rightValue>1&&(int)self.EjarehAreaslider.rightValue<5)){
        self.EjarehrightValuearea.text=@"5";
    }
    if (((int)self.EjarehAreaslider.rightValue>5&&(int)self.EjarehAreaslider.rightValue<10)){
        self.EjarehrightValuearea.text=@"10";
    }
    if (((int)self.EjarehAreaslider.rightValue>10&&(int)self.EjarehAreaslider.rightValue<15)) {
        self.EjarehrightValuearea.text=@"15";
    }
    if (((int)self.EjarehAreaslider.rightValue>15&&(int)self.EjarehAreaslider.rightValue<20)) {
        self.EjarehrightValuearea.text=@"20";
    }
    if (((int)self.EjarehAreaslider.rightValue>20&&(int)self.EjarehAreaslider.rightValue<25)) {
        self.EjarehrightValuearea.text=@"25";
    }
    if (((int)self.EjarehAreaslider.rightValue>25&&(int)self.EjarehAreaslider.rightValue<30)) {
        self.EjarehrightValuearea.text=@"30";
    }
    if (((int)self.EjarehAreaslider.rightValue>30&&(int)self.EjarehAreaslider.rightValue<35)) {
        self.EjarehrightValuearea.text=@"35";
    }
    if (((int)self.EjarehAreaslider.rightValue>35&&(int)self.EjarehAreaslider.rightValue<40)) {
        self.EjarehrightValuearea.text=@"40";
    }
    if (((int)self.EjarehAreaslider.rightValue>40&&(int)self.EjarehAreaslider.rightValue<45))
    {
        self.EjarehrightValuearea.text=@"45";
    }
    if (((int)self.EjarehAreaslider.rightValue>45&&(int)self.EjarehAreaslider.rightValue<50)){
        self.EjarehrightValuearea.text=@"50";
    }
    if (((int)self.EjarehAreaslider.rightValue>50&&(int)self.EjarehAreaslider.rightValue<55)){
        self.EjarehrightValuearea.text=@"55";
    }
    if (((int)self.EjarehAreaslider.rightValue>55&&(int)self.EjarehAreaslider.rightValue<60)) {
        self.EjarehrightValuearea.text=@"60";
    }
    if (((int)self.EjarehAreaslider.rightValue>60&&(int)self.EjarehAreaslider.rightValue<65)) {
        self.EjarehrightValuearea.text=@"65";
    }
    if (((int)self.EjarehAreaslider.rightValue>65&&(int)self.EjarehAreaslider.rightValue<70)) {
        self.EjarehrightValuearea.text=@"70";
    }
    if (((int)self.EjarehAreaslider.rightValue>70&&(int)self.EjarehAreaslider.rightValue<75)) {
        self.EjarehrightValuearea.text=@"75";
    }
    if (((int)self.EjarehAreaslider.rightValue>75&&(int)self.EjarehAreaslider.rightValue<80)) {
        self.EjarehrightValuearea.text=@"80";
    }
    if (((int)self.EjarehAreaslider.rightValue>80&&(int)self.EjarehAreaslider.rightValue<85)) {
        self.EjarehrightValuearea.text=@"85";
    }
    if (((int)self.EjarehAreaslider.rightValue>85&&(int)self.EjarehAreaslider.rightValue<90))
    {
        self.EjarehrightValuearea.text=@"90";
    }
    if (((int)self.EjarehAreaslider.leftValue>90&&(int)self.EjarehAreaslider.rightValue<95))
    {
        self.EjarehrightValuearea.text=@"95";
    }
    if (((int)self.EjarehAreaslider.rightValue>95&&(int)self.EjarehAreaslider.rightValue<100))
    {
        self.EjarehrightValuearea.text=@"100";
    }
    
    
    
    
    
    if (((int)self.EjarehAreaslider.rightValue>100&&(int)self.EjarehAreaslider.rightValue<200)){
        self.EjarehrightValuearea.text=@"100";
    }
    if (((int)self.EjarehAreaslider.rightValue>200&&(int)self.EjarehAreaslider.rightValue<300)){
        self.EjarehrightValuearea.text=@"200";
    }
    if (((int)self.EjarehAreaslider.rightValue>300&&(int)self.EjarehAreaslider.rightValue<400)) {
        self.EjarehrightValuearea.text=@"300";
    }
    if (((int)self.EjarehAreaslider.rightValue>400&&(int)self.EjarehAreaslider.rightValue<500)) {
        self.EjarehrightValuearea.text=@"400";
    }
    if (((int)self.EjarehAreaslider.rightValue>500&&(int)self.EjarehAreaslider.rightValue<600)) {
        self.EjarehrightValuearea.text=@"500";
    }
    if (((int)self.EjarehAreaslider.rightValue>600&&(int)self.EjarehAreaslider.rightValue<700)) {
        self.EjarehrightValuearea.text=@"600";
    }
    if (((int)self.EjarehAreaslider.rightValue>700&&(int)self.EjarehAreaslider.rightValue<800)) {
        self.EjarehrightValuearea.text=@"700";
    }
    if (((int)self.EjarehAreaslider.rightValue>800&&(int)self.EjarehAreaslider.rightValue<900)) {
        self.EjarehrightValuearea.text=@"800";
    }
    if (((int)self.EjarehAreaslider.rightValue>900&&(int)self.EjarehAreaslider.rightValue<1000))
    {
        self.EjarehrightValuearea.text=@"900";
    }
    if (((int)self.EjarehAreaslider.rightValue>1000&&(int)self.EjarehAreaslider.rightValue<1100)) {
        self.EjarehrightValuearea.text=@"1000";
    }
    if (((int)self.EjarehAreaslider.rightValue>1000&&(int)self.EjarehAreaslider.rightValue<1100)) {
        self.EjarehrightValuearea.text=@"1000";
    }
    if (((int)self.EjarehAreaslider.rightValue>1100&&(int)self.EjarehAreaslider.rightValue<1200)){
        self.EjarehrightValuearea.text=@"1100";
    }
    if (((int)self.EjarehAreaslider.rightValue>1200&&(int)self.EjarehAreaslider.rightValue<1300)) {
        self.EjarehrightValuearea.text=@"1200";
    }
    if (((int)self.EjarehAreaslider.rightValue>1300&&(int)self.EjarehAreaslider.rightValue<1400)) {
        self.EjarehrightValuearea.text=@"1300";
    }
    if (((int)self.EjarehAreaslider.rightValue>1400&&(int)self.EjarehAreaslider.rightValue<1500)) {
        self.EjarehrightValuearea.text=@"1400";
    }
    if (((int)self.EjarehAreaslider.rightValue>1500&&(int)self.EjarehAreaslider.rightValue<1600)) {
        self.EjarehrightValuearea.text=@"1500";
    }
    if (((int)self.EjarehAreaslider.rightValue>1600&&(int)self.EjarehAreaslider.rightValue<1700)) {
        self.EjarehrightValuearea.text=@"1600";
    }
    if (((int)self.EjarehAreaslider.rightValue>1700&&(int)self.EjarehAreaslider.rightValue<1800)) {
        self.EjarehrightValuearea.text=@"1700";
    }
    if (((int)self.EjarehAreaslider.rightValue>1800&&(int)self.EjarehAreaslider.rightValue<1900)) {
        self.EjarehrightValuearea.text=@"1800";
    }
    if (((int)self.EjarehAreaslider.rightValue>1900&&(int)self.EjarehAreaslider.rightValue<2000)) {
        self.EjarehrightValuearea.text=@"1900";
    }
    if (((int)self.EjarehAreaslider.rightValue>2000&&(int)self.EjarehAreaslider.rightValue<2100)) {
        self.EjarehrightValuearea.text=@"2000";
    }
    if (((int)self.EjarehAreaslider.rightValue>2100&&(int)self.EjarehAreaslider.rightValue<2200)) {
        self.EjarehrightValuearea.text=@"2100";
    }
    if (((int)self.EjarehAreaslider.rightValue>2200&&(int)self.EjarehAreaslider.rightValue<2300)) {
        self.EjarehrightValuearea.text=@"2200";
    }
    if (((int)self.EjarehAreaslider.rightValue>2300&&(int)self.EjarehAreaslider.rightValue<2400)) {
        self.EjarehrightValuearea.text=@"2300";
    }
    if (((int)self.EjarehAreaslider.rightValue>2400&&(int)self.EjarehAreaslider.rightValue<2500)) {
        self.EjarehrightValuearea.text=@"2400";
    }
    
    
    if (((int)self.rahnSlider.rightValue>1&&(int)self.rahnSlider.rightValue<10)){
        self.rahnrightvalueLabel.text=@"10";
    }
    if (((int)self.rahnSlider.rightValue>10&&(int)self.rahnSlider.rightValue<20)){
        self.rahnrightvalueLabel.text=@"20";
    }
    if (((int)self.rahnSlider.rightValue>20&&(int)self.rahnSlider.rightValue<30)) {
        self.rahnrightvalueLabel.text=@"30";
    }
    if (((int)self.rahnSlider.rightValue>30&&(int)self.rahnSlider.rightValue<40)) {
        self.rahnrightvalueLabel.text=@"40";
    }
    if (((int)self.rahnSlider.rightValue>40&&(int)self.rahnSlider.rightValue<50)) {
        self.rahnrightvalueLabel.text=@"50";
    }
    if (((int)self.rahnSlider.rightValue>50&&(int)self.rahnSlider.rightValue<60)) {
        self.rahnrightvalueLabel.text=@"60";
    }
    if (((int)self.rahnSlider.rightValue>60&&(int)self.rahnSlider.rightValue<70)) {
        self.rahnrightvalueLabel.text=@"70";
    }
    if (((int)self.rahnSlider.rightValue>70&&(int)self.rahnSlider.rightValue<80)) {
        self.rahnrightvalueLabel.text=@"80";
    }
    if (((int)self.rahnSlider.rightValue>80&&(int)self.rahnSlider.rightValue<90))
    {
        self.rahnrightvalueLabel.text=@"90";
    }
    
    
    
    if (((int)self.rahnSlider.rightValue>100&&(int)self.rahnSlider.rightValue<200)){
        self.rahnrightvalueLabel.text=@"100";
    }
    if (((int)self.rahnSlider.rightValue>200&&(int)self.rahnSlider.rightValue<300)){
        self.rahnrightvalueLabel.text=@"200";
    }
    if (((int)self.rahnSlider.rightValue>300&&(int)self.rahnSlider.rightValue<400)) {
        self.rahnrightvalueLabel.text=@"300";
    }
    if (((int)self.rahnSlider.rightValue>400&&(int)self.rahnSlider.rightValue<500)) {
        self.rahnrightvalueLabel.text=@"400";
    }
    if (((int)self.rahnSlider.rightValue>500&&(int)self.rahnSlider.rightValue<600)) {
        self.rahnrightvalueLabel.text=@"500";
    }
    if (((int)self.rahnSlider.rightValue>600&&(int)self.rahnSlider.rightValue<700)) {
        self.rahnrightvalueLabel.text=@"600";
    }
    if (((int)self.rahnSlider.rightValue>700&&(int)self.rahnSlider.rightValue<800)) {
        self.rahnrightvalueLabel.text=@"700";
    }
    if (((int)self.rahnSlider.rightValue>800&&(int)self.rahnSlider.rightValue<900)) {
        self.rahnrightvalueLabel.text=@"800";
    }
    if (((int)self.rahnSlider.rightValue>900&&(int)self.rahnSlider.rightValue<1000))
    {
        self.rahnrightvalueLabel.text=@"900";
    }
    if (((int)self.rahnSlider.rightValue>1000&&(int)self.rahnSlider.rightValue<1100)) {
        self.rahnrightvalueLabel.text=@"1000";
    }
    if (((int)self.rahnSlider.rightValue>1000&&(int)self.rahnSlider.rightValue<1100)) {
        self.rahnrightvalueLabel.text=@"1000";
    }
    if (((int)self.rahnSlider.rightValue>1100&&(int)self.rahnSlider.rightValue<1200)){
        self.rahnrightvalueLabel.text=@"1100";
    }
    if (((int)self.rahnSlider.rightValue>1200&&(int)self.rahnSlider.rightValue<1300)) {
        self.rahnrightvalueLabel.text=@"1200";
    }
    if (((int)self.rahnSlider.rightValue>1300&&(int)self.rahnSlider.rightValue<1400)) {
        self.rahnrightvalueLabel.text=@"1300";
    }
    if (((int)self.rahnSlider.rightValue>1400&&(int)self.rahnSlider.rightValue<1500)) {
        self.rahnrightvalueLabel.text=@"1400";
    }
    if (((int)self.rahnSlider.rightValue>1500&&(int)self.rahnSlider.rightValue<1600)) {
        self.rahnrightvalueLabel.text=@"1500";
    }
    if (((int)self.rahnSlider.rightValue>1600&&(int)self.rahnSlider.rightValue<1700)) {
        self.rahnrightvalueLabel.text=@"1600";
    }
    if (((int)self.rahnSlider.rightValue>1700&&(int)self.rahnSlider.rightValue<1800)) {
        self.rahnrightvalueLabel.text=@"1700";
    }
    if (((int)self.rahnSlider.rightValue>1800&&(int)self.rahnSlider.rightValue<1900)) {
        self.rahnrightvalueLabel.text=@"1800";
    }
    if (((int)self.rahnSlider.rightValue>1900&&(int)self.rahnSlider.rightValue<2000)) {
        self.rahnrightvalueLabel.text=@"1900";
    }
    if (((int)self.rahnSlider.rightValue>2000&&(int)self.rahnSlider.rightValue<2100)) {
        self.rahnrightvalueLabel.text=@"2000";
    }
    if (((int)self.rahnSlider.rightValue>2100&&(int)self.rahnSlider.rightValue<2200)) {
        self.rahnrightvalueLabel.text=@"2100";
    }
    if (((int)self.rahnSlider.rightValue>2200&&(int)self.rahnSlider.rightValue<2300)) {
        self.rahnrightvalueLabel.text=@"2200";
    }
    if (((int)self.rahnSlider.rightValue>2300&&(int)self.rahnSlider.rightValue<2400)) {
        self.rahnrightvalueLabel.text=@"2300";
    }
    if (((int)self.rahnSlider.rightValue>2400&&(int)self.rahnSlider.rightValue<2500)) {
        self.rahnrightvalueLabel.text=@"2400";
    }
    
    if (((int)self.rahnSlider.leftValue>1&&(int)self.rahnSlider.leftValue<10)){
        self.rahnleftvalueLabel.text=@"10";
    }
    if (((int)self.rahnSlider.leftValue>10&&(int)self.rahnSlider.leftValue<20)){
        self.rahnleftvalueLabel.text=@"20";
    }
    if (((int)self.rahnSlider.leftValue>20&&(int)self.rahnSlider.leftValue<30)) {
        self.rahnleftvalueLabel.text=@"30";
    }
    if (((int)self.rahnSlider.leftValue>30&&(int)self.rahnSlider.leftValue<40)) {
        self.rahnleftvalueLabel.text=@"40";
    }
    if (((int)self.rahnSlider.leftValue>40&&(int)self.rahnSlider.leftValue<50)) {
        self.rahnleftvalueLabel.text=@"50";
    }
    if (((int)self.rahnSlider.leftValue>50&&(int)self.rahnSlider.leftValue<60)) {
        self.rahnleftvalueLabel.text=@"60";
    }
    if (((int)self.rahnSlider.leftValue>60&&(int)self.rahnSlider.leftValue<70)) {
        self.rahnleftvalueLabel.text=@"70";
    }
    if (((int)self.rahnSlider.leftValue>70&&(int)self.rahnSlider.leftValue<80)) {
        self.rahnleftvalueLabel.text=@"80";
    }
    if (((int)self.rahnSlider.leftValue>80&&(int)self.rahnSlider.leftValue<90)){
        self.rahnleftvalueLabel.text=@"90";
    }
    
    
    
    if (((int)self.rahnSlider.leftValue>100&&(int)self.rahnSlider.leftValue<200)){
        self.rahnleftvalueLabel.text=@"100";
    }
    if (((int)self.rahnSlider.leftValue>200&&(int)self.rahnSlider.leftValue<300)){
        self.rahnleftvalueLabel.text=@"200";
    }
    if (((int)self.rahnSlider.leftValue>300&&(int)self.rahnSlider.leftValue<400)) {
        self.rahnleftvalueLabel.text=@"300";
    }
    if (((int)self.rahnSlider.leftValue>400&&(int)self.rahnSlider.leftValue<500)) {
        self.rahnleftvalueLabel.text=@"400";
    }
    if (((int)self.rahnSlider.leftValue>500&&(int)self.rahnSlider.leftValue<600)) {
        self.rahnleftvalueLabel.text=@"500";
    }
    if (((int)self.rahnSlider.leftValue>600&&(int)self.rahnSlider.leftValue<700)) {
        self.rahnleftvalueLabel.text=@"600";
    }
    if (((int)self.rahnSlider.leftValue>700&&(int)self.rahnSlider.leftValue<800)) {
        self.rahnleftvalueLabel.text=@"700";
    }
    if (((int)self.rahnSlider.leftValue>800&&(int)self.rahnSlider.leftValue<900)) {
        self.rahnleftvalueLabel.text=@"800";
    }
    if (((int)self.rahnSlider.leftValue>900&&(int)self.rahnSlider.leftValue<1000)){
        self.rahnleftvalueLabel.text=@"900";
    }
    if (((int)self.rahnSlider.leftValue>1000&&(int)self.rahnSlider.leftValue<1100)) {
        self.rahnleftvalueLabel.text=@"1000";
    }
    if (((int)self.rahnSlider.leftValue>1000&&(int)self.rahnSlider.leftValue<1100)) {
        self.rahnleftvalueLabel.text=@"1000";
    }
    if (((int)self.rahnSlider.leftValue>1100&&(int)self.rahnSlider.leftValue<1200)){
        self.rahnleftvalueLabel.text=@"1100";
    }
    if (((int)self.rahnSlider.leftValue>1200&&(int)self.rahnSlider.leftValue<1300)) {
        self.rahnleftvalueLabel.text=@"1200";
    }
    if (((int)self.rahnSlider.leftValue>1300&&(int)self.rahnSlider.leftValue<1400)) {
        self.rahnleftvalueLabel.text=@"1300";
    }
    if (((int)self.rahnSlider.leftValue>1400&&(int)self.rahnSlider.leftValue<1500)) {
        self.rahnleftvalueLabel.text=@"1400";
    }
    if (((int)self.rahnSlider.leftValue>1500&&(int)self.rahnSlider.leftValue<1600)) {
        self.rahnleftvalueLabel.text=@"1500";
    }
    if (((int)self.rahnSlider.leftValue>1600&&(int)self.rahnSlider.leftValue<1700)) {
        self.rahnleftvalueLabel.text=@"1600";
    }
    if (((int)self.rahnSlider.leftValue>1700&&(int)self.rahnSlider.leftValue<1800)) {
        self.rahnleftvalueLabel.text=@"1700";
    }
    if (((int)self.rahnSlider.leftValue>1800&&(int)self.rahnSlider.leftValue<1900)) {
        self.rahnleftvalueLabel.text=@"1800";
    }
    if (((int)self.rahnSlider.leftValue>1900&&(int)self.rahnSlider.leftValue<2000)) {
        self.rahnleftvalueLabel.text=@"1900";
    }
    if (((int)self.rahnSlider.leftValue>2000&&(int)self.rahnSlider.leftValue<2100)) {
        self.rahnleftvalueLabel.text=@"2000";
    }
    if (((int)self.rahnSlider.leftValue>2100&&(int)self.rahnSlider.leftValue<2200)) {
        self.rahnleftvalueLabel.text=@"2100";
    }
    if (((int)self.rahnSlider.leftValue>2200&&(int)self.rahnSlider.leftValue<2300)) {
        self.rahnleftvalueLabel.text=@"2200";
    }
    if (((int)self.rahnSlider.leftValue>2300&&(int)self.rahnSlider.leftValue<2400)) {
        self.rahnleftvalueLabel.text=@"2300";
    }
    if (((int)self.rahnSlider.leftValue>2400&&(int)self.rahnSlider.leftValue<2500)) {
        self.rahnleftvalueLabel.text=@"2400";
    }
    
    
    
    if (((int)self.ejarehSlider.rightValue>1&&(int)self.ejarehSlider.rightValue<100)){
        self.ejarehrightvalueLabel.text=@"1";
    }
    if (((int)self.ejarehSlider.rightValue>100&&(int)self.ejarehSlider.rightValue<200)){
        self.ejarehrightvalueLabel.text=@"100";
    }
    if (((int)self.ejarehSlider.rightValue>200&&(int)self.ejarehSlider.rightValue<300)) {
        self.ejarehrightvalueLabel.text=@"200";
    }
    if (((int)self.ejarehSlider.rightValue>300&&(int)self.ejarehSlider.rightValue<400)) {
        self.ejarehrightvalueLabel.text=@"300";
    }
    if (((int)self.ejarehSlider.rightValue>400&&(int)self.ejarehSlider.rightValue<500)) {
        self.ejarehrightvalueLabel.text=@"400";
    }
    if (((int)self.ejarehSlider.rightValue>500&&(int)self.ejarehSlider.rightValue<600)) {
        self.ejarehrightvalueLabel.text=@"500";
    }
    if (((int)self.ejarehSlider.rightValue>600&&(int)self.ejarehSlider.rightValue<700)) {
        self.ejarehrightvalueLabel.text=@"600";
    }
    if (((int)self.ejarehSlider.rightValue>700&&(int)self.ejarehSlider.rightValue<800)) {
        self.ejarehrightvalueLabel.text=@"700";
    }
    if (((int)self.ejarehSlider.rightValue>800&&(int)self.ejarehSlider.rightValue<900)){
        self.ejarehrightvalueLabel.text=@"800";
    }
    if (((int)self.ejarehSlider.rightValue>900&&(int)self.ejarehSlider.rightValue<1000)){
        self.ejarehrightvalueLabel.text=@"900";
    }
    if (((int)self.ejarehSlider.rightValue>1000&&(int)self.ejarehSlider.rightValue<1100)){
        self.ejarehrightvalueLabel.text=@"1000";
    }
    if (((int)self.ejarehSlider.rightValue>1100&&(int)self.ejarehSlider.rightValue<1200)) {
        self.ejarehrightvalueLabel.text=@"1100";
    }
    if (((int)self.ejarehSlider.rightValue>1200&&(int)self.ejarehSlider.rightValue<1300)) {
        self.ejarehrightvalueLabel.text=@"1200";
    }
    if (((int)self.ejarehSlider.rightValue>1300&&(int)self.ejarehSlider.rightValue<1400)) {
        self.ejarehrightvalueLabel.text=@"1300";
    }
    if (((int)self.ejarehSlider.rightValue>1400&&(int)self.ejarehSlider.rightValue<1500)) {
        self.ejarehrightvalueLabel.text=@"1400";
    }
    if (((int)self.ejarehSlider.rightValue>1500&&(int)self.ejarehSlider.rightValue<1600)) {
        self.ejarehrightvalueLabel.text=@"1500";
    }
    if (((int)self.ejarehSlider.rightValue>1600&&(int)self.ejarehSlider.rightValue<1700)) {
        self.ejarehrightvalueLabel.text=@"1600";
    }
    if (((int)self.ejarehSlider.rightValue>1700&&(int)self.ejarehSlider.rightValue<1800))
    {
        self.ejarehrightvalueLabel.text=@"1700";
    }
    if (((int)self.ejarehSlider.rightValue>1800&&(int)self.ejarehSlider.rightValue<1900)) {
        self.ejarehrightvalueLabel.text=@"1800";
    }
    if (((int)self.ejarehSlider.rightValue>1900&&(int)self.ejarehSlider.rightValue<2000)) {
        self.ejarehrightvalueLabel.text=@"1900";
    }
    if (((int)self.ejarehSlider.rightValue>2000&&(int)self.ejarehSlider.rightValue<2500)){
        self.ejarehrightvalueLabel.text=@"2000";
    }
    if (((int)self.ejarehSlider.rightValue>2500&&(int)self.ejarehSlider.rightValue<3000)) {
        self.ejarehrightvalueLabel.text=@"2500";
    }
    if (((int)self.ejarehSlider.rightValue>3000&&(int)self.ejarehSlider.rightValue<3500)) {
        self.ejarehrightvalueLabel.text=@"3000";
    }
    if (((int)self.ejarehSlider.rightValue>3500&&(int)self.ejarehSlider.rightValue<4000)) {
        self.ejarehrightvalueLabel.text=@"3500";
    }
    if (((int)self.ejarehSlider.rightValue>4000&&(int)self.ejarehSlider.rightValue<4500)) {
        self.ejarehrightvalueLabel.text=@"4000";
    }
    if (((int)self.ejarehSlider.rightValue>4500&&(int)self.ejarehSlider.rightValue<5000)) {
        self.ejarehrightvalueLabel.text=@"4500";
    }
    if (((int)self.ejarehSlider.rightValue>5000&&(int)self.ejarehSlider.rightValue<5500)) {
        self.ejarehrightvalueLabel.text=@"5000";
    }
    if (((int)self.ejarehSlider.rightValue>5500&&(int)self.ejarehSlider.rightValue<6000)) {
        self.ejarehrightvalueLabel.text=@"5500";
    }
    if (((int)self.ejarehSlider.rightValue>6000&&(int)self.ejarehSlider.rightValue<6500)) {
        self.ejarehrightvalueLabel.text=@"6000";
    }
    if (((int)self.ejarehSlider.rightValue>6500&&(int)self.ejarehSlider.rightValue<7000)) {
        self.ejarehrightvalueLabel.text=@"6500";
    }
    if (((int)self.ejarehSlider.rightValue>7000&&(int)self.ejarehSlider.rightValue<7500)) {
        self.ejarehrightvalueLabel.text=@"7000";
    }
    if (((int)self.ejarehSlider.rightValue>7500&&(int)self.ejarehSlider.rightValue<8000)) {
        self.ejarehrightvalueLabel.text=@"7500";
    }
    if (((int)self.ejarehSlider.rightValue>8000&&(int)self.ejarehSlider.rightValue<8500)) {
        self.ejarehrightvalueLabel.text=@"8000";
    }
    if (((int)self.ejarehSlider.rightValue>8500&&(int)self.ejarehSlider.rightValue<9000)) {
        self.ejarehrightvalueLabel.text=@"8500";
    }
    if (((int)self.ejarehSlider.rightValue>9000&&(int)self.ejarehSlider.rightValue<9500)) {
        self.ejarehrightvalueLabel.text=@"9000";
    }
    if (((int)self.ejarehSlider.rightValue>9500&&(int)self.ejarehSlider.rightValue<9800)) {
        self.ejarehrightvalueLabel.text=@"9500";
    }
    if (((int)self.ejarehSlider.rightValue>9800&&(int)self.ejarehSlider.rightValue<10000)) {
        self.ejarehrightvalueLabel.text=@"10000";
    }
    
    if (((int)self.ejarehSlider.leftValue>1&&(int)self.ejarehSlider.leftValue<100)){
        self.ejarehleftvalueLabel.text=@"1";
    }
    if (((int)self.ejarehSlider.leftValue>100&&(int)self.ejarehSlider.leftValue<200)){
        self.ejarehleftvalueLabel.text=@"100";
    }
    if (((int)self.ejarehSlider.leftValue>200&&(int)self.ejarehSlider.leftValue<300)) {
        self.ejarehleftvalueLabel.text=@"200";
    }
    if (((int)self.ejarehSlider.leftValue>300&&(int)self.ejarehSlider.leftValue<400)) {
        self.ejarehleftvalueLabel.text=@"300";
    }
    if (((int)self.ejarehSlider.leftValue>400&&(int)self.ejarehSlider.leftValue<500)) {
        self.ejarehleftvalueLabel.text=@"400";
    }
    if (((int)self.ejarehSlider.leftValue>500&&(int)self.ejarehSlider.leftValue<600)) {
        self.ejarehleftvalueLabel.text=@"500";
    }
    if (((int)self.ejarehSlider.leftValue>600&&(int)self.ejarehSlider.leftValue<700)) {
        self.ejarehleftvalueLabel.text=@"600";
    }
    if (((int)self.ejarehSlider.leftValue>700&&(int)self.ejarehSlider.leftValue<800)) {
        self.ejarehleftvalueLabel.text=@"700";
    }
    if (((int)self.ejarehSlider.leftValue>800&&(int)self.ejarehSlider.leftValue<900)){
        self.ejarehleftvalueLabel.text=@"800";
    }
    if (((int)self.ejarehSlider.leftValue>900&&(int)self.ejarehSlider.leftValue<1000)){
        self.ejarehleftvalueLabel.text=@"900";
    }
    if (((int)self.ejarehSlider.leftValue>1000&&(int)self.ejarehSlider.leftValue<1100)){
        self.ejarehleftvalueLabel.text=@"1000";
    }
    if (((int)self.ejarehSlider.leftValue>1100&&(int)self.ejarehSlider.leftValue<1200)) {
        self.ejarehleftvalueLabel.text=@"1100";
    }
    if (((int)self.ejarehSlider.leftValue>1200&&(int)self.ejarehSlider.leftValue<1300)) {
        self.ejarehleftvalueLabel.text=@"1200";
    }
    if (((int)self.ejarehSlider.leftValue>1300&&(int)self.ejarehSlider.leftValue<1400)) {
        self.ejarehleftvalueLabel.text=@"1300";
    }
    if (((int)self.ejarehSlider.leftValue>1400&&(int)self.ejarehSlider.leftValue<1500)) {
        self.ejarehleftvalueLabel.text=@"1400";
    }
    if (((int)self.ejarehSlider.leftValue>1500&&(int)self.ejarehSlider.leftValue<1600)) {
        self.ejarehleftvalueLabel.text=@"1500";
    }
    if (((int)self.ejarehSlider.leftValue>1600&&(int)self.ejarehSlider.leftValue<1700)) {
        self.ejarehleftvalueLabel.text=@"1600";
    }
    if (((int)self.ejarehSlider.leftValue>1700&&(int)self.ejarehSlider.leftValue<1800))
    {
        self.ejarehleftvalueLabel.text=@"1700";
    }
    if (((int)self.ejarehSlider.leftValue>1800&&(int)self.ejarehSlider.leftValue<1900)) {
        self.ejarehleftvalueLabel.text=@"1800";
    }
    if (((int)self.ejarehSlider.leftValue>1900&&(int)self.ejarehSlider.leftValue<2000)) {
        self.ejarehleftvalueLabel.text=@"1900";
    }
    if (((int)self.ejarehSlider.leftValue>2000&&(int)self.ejarehSlider.leftValue<2500)){
        self.ejarehleftvalueLabel.text=@"2000";
    }
    if (((int)self.ejarehSlider.leftValue>2500&&(int)self.ejarehSlider.leftValue<3000)) {
        self.ejarehleftvalueLabel.text=@"2500";
    }
    if (((int)self.ejarehSlider.leftValue>3000&&(int)self.ejarehSlider.leftValue<3500)) {
        self.ejarehleftvalueLabel.text=@"3000";
    }
    if (((int)self.ejarehSlider.leftValue>3500&&(int)self.ejarehSlider.leftValue<4000)) {
        self.ejarehleftvalueLabel.text=@"3500";
    }
    if (((int)self.ejarehSlider.leftValue>4000&&(int)self.ejarehSlider.leftValue<4500)) {
        self.ejarehleftvalueLabel.text=@"4000";
    }
    if (((int)self.ejarehSlider.leftValue>4500&&(int)self.ejarehSlider.leftValue<5000)) {
        self.ejarehleftvalueLabel.text=@"4500";
    }
    if (((int)self.ejarehSlider.leftValue>5000&&(int)self.ejarehSlider.leftValue<5500)) {
        self.ejarehleftvalueLabel.text=@"5000";
    }
    if (((int)self.ejarehSlider.leftValue>5500&&(int)self.ejarehSlider.leftValue<6000)) {
        self.ejarehleftvalueLabel.text=@"5500";
    }
    if (((int)self.ejarehSlider.leftValue>6000&&(int)self.ejarehSlider.leftValue<6500)) {
        self.ejarehleftvalueLabel.text=@"6000";
    }
    if (((int)self.ejarehSlider.leftValue>6500&&(int)self.ejarehSlider.leftValue<7000)) {
        self.ejarehleftvalueLabel.text=@"6500";
    }
    if (((int)self.ejarehSlider.leftValue>7000&&(int)self.ejarehSlider.leftValue<7500)) {
        self.ejarehleftvalueLabel.text=@"7000";
    }
    if (((int)self.ejarehSlider.leftValue>7500&&(int)self.ejarehSlider.leftValue<8000)) {
        self.ejarehleftvalueLabel.text=@"7500";
    }
    if (((int)self.ejarehSlider.leftValue>8000&&(int)self.ejarehSlider.leftValue<8500)) {
        self.ejarehleftvalueLabel.text=@"8000";
    }
    if (((int)self.ejarehSlider.leftValue>8500&&(int)self.ejarehSlider.leftValue<9000)) {
        self.ejarehleftvalueLabel.text=@"8500";
    }
    if (((int)self.ejarehSlider.leftValue>9000&&(int)self.ejarehSlider.leftValue<9500)) {
        self.ejarehleftvalueLabel.text=@"9000";
    }
    if (((int)self.ejarehSlider.leftValue>9500&&(int)self.ejarehSlider.leftValue<9800)) {
        self.ejarehleftvalueLabel.text=@"9500";
    }
    if (((int)self.ejarehSlider.leftValue>9800&&(int)self.ejarehSlider.leftValue<10000)) {
        self.ejarehleftvalueLabel.text=@"10000";
    }
    
    
    
    
    
    
    if ([self.ejarehrightvalueLabel.text length] == 4)
    {
        self.ejarehUnitone.hidden=YES;
        NSString*text2=[self.ejarehrightvalueLabel.text substringToIndex:1];
        NSString*text3=[self.ejarehrightvalueLabel.text substringWithRange:(NSMakeRange(1, 3))];
        
        self.ejarehrightvalueLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
        
        if (((int)self.ejarehSlider.rightValue>1000&&(int)self.ejarehSlider.rightValue<1100)) {
            self.ejarehrightvalueLabel.text=@"۱ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>2000&&(int)self.ejarehSlider.rightValue<2500)) {
            self.ejarehrightvalueLabel.text=@"۲ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>2500&&(int)self.ejarehSlider.rightValue<3000)) {
            self.ejarehrightvalueLabel.text=@"۲ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.rightValue>3000&&(int)self.ejarehSlider.rightValue<3500)) {
            self.ejarehrightvalueLabel.text=@"۳ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>3500&&(int)self.ejarehSlider.rightValue<4000)) {
            self.ejarehrightvalueLabel.text=@"۳ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.rightValue>4000&&(int)self.ejarehSlider.rightValue<4500)) {
            self.ejarehrightvalueLabel.text=@"۴ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>4500&&(int)self.ejarehSlider.rightValue<5000)) {
            self.ejarehrightvalueLabel.text=@"۴ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.rightValue>5000&&(int)self.ejarehSlider.rightValue<5500)) {
            self.ejarehrightvalueLabel.text=@"۵ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>5500&&(int)self.ejarehSlider.rightValue<6000)) {
            self.ejarehrightvalueLabel.text=@"۵ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.rightValue>6000&&(int)self.ejarehSlider.rightValue<6500)) {
            self.ejarehrightvalueLabel.text=@"۶ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>6500&&(int)self.ejarehSlider.rightValue<7000)) {
            self.ejarehrightvalueLabel.text=@"۶ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.rightValue>7000&&(int)self.ejarehSlider.rightValue<7500)) {
            self.ejarehrightvalueLabel.text=@"۷ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>7500&&(int)self.ejarehSlider.rightValue<8000)) {
            self.ejarehrightvalueLabel.text=@"۷ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.rightValue>8000&&(int)self.ejarehSlider.rightValue<8500)) {
            self.ejarehrightvalueLabel.text=@"۸ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>8500&&(int)self.ejarehSlider.rightValue<9000)) {
            self.ejarehrightvalueLabel.text=@"۸ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.rightValue>9000&&(int)self.ejarehSlider.rightValue<9500)) {
            self.ejarehrightvalueLabel.text=@"۹ میلیون";
        }
        if (((int)self.ejarehSlider.rightValue>9500&&(int)self.ejarehSlider.rightValue<98000)) {
            self.ejarehrightvalueLabel.text=@"۹ میلیون و ۵۰۰ هزار تومان";
        }
        
        
    }
    if ([self.ejarehrightvalueLabel.text length] == 3){
        self.ejarehUnitone.hidden=NO;
    }
    if ([self.ejarehrightvalueLabel.text length] == 5){
        
        self.ejarehrightvalueLabel.text=@"۱۰ میلیون";
        
        
    }
    
    
    
    if ([self.ejarehleftvalueLabel.text length] == 4)
    {
        self.ejarehUnittwo.hidden=YES;
        NSString*text2=[self.ejarehleftvalueLabel.text substringToIndex:1];
        NSString*text3=[self.ejarehleftvalueLabel.text substringWithRange:(NSMakeRange(1, 3))];
        
        self.ejarehleftvalueLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار تومان"];
        if (((int)self.ejarehSlider.leftValue>1000&&(int)self.ejarehSlider.leftValue<1100)) {
            self.ejarehleftvalueLabel.text=@"۱ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>2000&&(int)self.ejarehSlider.leftValue<2500)) {
            self.ejarehleftvalueLabel.text=@"۲ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>2500&&(int)self.ejarehSlider.leftValue<3000)) {
            self.ejarehleftvalueLabel.text=@"۲ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.leftValue>3000&&(int)self.ejarehSlider.leftValue<3500)) {
            self.ejarehleftvalueLabel.text=@"۳ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>3500&&(int)self.ejarehSlider.leftValue<4000)) {
            self.ejarehleftvalueLabel.text=@"۳ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.leftValue>4000&&(int)self.ejarehSlider.leftValue<4500)) {
            self.ejarehleftvalueLabel.text=@"۴ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>4500&&(int)self.ejarehSlider.leftValue<5000)) {
            self.ejarehleftvalueLabel.text=@"۴ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.leftValue>5000&&(int)self.ejarehSlider.leftValue<5500)) {
            self.ejarehleftvalueLabel.text=@"۵ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>5500&&(int)self.ejarehSlider.leftValue<6000)) {
            self.ejarehleftvalueLabel.text=@"۵ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.leftValue>6000&&(int)self.ejarehSlider.leftValue<6500)) {
            self.ejarehleftvalueLabel.text=@"۶ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>6500&&(int)self.ejarehSlider.leftValue<7000)) {
            self.ejarehleftvalueLabel.text=@"۶ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.leftValue>7000&&(int)self.ejarehSlider.leftValue<7500)) {
            self.ejarehleftvalueLabel.text=@"۷ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>7500&&(int)self.ejarehSlider.leftValue<8000)) {
            self.ejarehleftvalueLabel.text=@"۷ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.leftValue>8000&&(int)self.ejarehSlider.leftValue<8500)) {
            self.ejarehleftvalueLabel.text=@"۸ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>8500&&(int)self.ejarehSlider.leftValue<9000)) {
            self.ejarehleftvalueLabel.text=@"۸ میلیون و ۵۰۰ هزار تومان";
        }
        if (((int)self.ejarehSlider.leftValue>9000&&(int)self.ejarehSlider.leftValue<9500)) {
            self.ejarehleftvalueLabel.text=@"۹ میلیون";
        }
        if (((int)self.ejarehSlider.leftValue>9500&&(int)self.ejarehSlider.leftValue<9800)) {
            self.ejarehleftvalueLabel.text=@"۹ میلیون و ۵۰۰ هزار تومان";
        }
    }
    if ([self.ejarehleftvalueLabel.text length] == 3){
        self.ejarehUnittwo.hidden=NO;
    }
    if ([self.ejarehleftvalueLabel.text length] == 5){
        
        self.ejarehleftvalueLabel.text=@"۱۰ میلیون";
        
    }
    
    if ([self.rahnrightvalueLabel.text length] == 4)
    {
        self.rahnUnitone.hidden=YES;
        NSString*text2=[self.rahnrightvalueLabel.text substringToIndex:1];
        NSString*text3=[self.rahnrightvalueLabel.text substringWithRange:(NSMakeRange(1, 3))];
        
        self.rahnrightvalueLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"و",[text3 substringToIndex:[text3 length]],@"میلیون"];
        
        if (((int)self.rahnSlider.rightValue>1000&&(int)self.rahnSlider.rightValue<1100)) {
            self.rahnrightvalueLabel.text=@"۱ میلیارد";
        }
        if (((int)self.rahnSlider.rightValue>2000&&(int)self.rahnSlider.rightValue<2100)) {
            self.rahnrightvalueLabel.text=@"۲ میلیارد";
        }
    }
    else{
        self.rahnUnitone.hidden=NO;
    }
    
    if ([self.rahnleftvalueLabel.text length] == 4)
    {
        self.rahnUnittwo.hidden=YES;
        NSString*text2=[self.rahnleftvalueLabel.text substringToIndex:1];
        NSString*text3=[self.rahnleftvalueLabel.text substringWithRange:(NSMakeRange(1, 3))];
        
        self.rahnleftvalueLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"و",[text3 substringToIndex:[text3 length]],@"میلیون"];
        
        if (((int)self.rahnSlider.leftValue>1000&&(int)self.rahnSlider.leftValue<1100)) {
            self.rahnleftvalueLabel.text=@"۱ میلیارد";
        }
        if (((int)self.rahnSlider.leftValue>2000&&(int)self.rahnSlider.leftValue<2100)) {
            self.rahnleftvalueLabel.text=@"۲ میلیارد";
        }
    }
    else{
        self.rahnUnittwo.hidden=NO;
    }
    
    
    if ([self.forooshleftValueLabel.text length] == 4)
    {
        self.Unittwo.hidden=YES;
        NSString*text2=[self.forooshleftValueLabel.text substringToIndex:1];
        NSString*text3=[self.forooshleftValueLabel.text substringWithRange:(NSMakeRange(1, 3))];
        
        self.forooshleftValueLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"و",[text3 substringToIndex:[text3 length]],@"میلیون"];
        
        
        if (((int)self.forooshpriceslider.leftValue>1000&&(int)self.forooshpriceslider.leftValue<1100)) {
            self.forooshleftValueLabel.text=@"۱ میلیارد";
        }
        if (((int)self.forooshpriceslider.leftValue>2000&&(int)self.forooshpriceslider.leftValue<2100)) {
            self.forooshleftValueLabel.text=@"۲ میلیارد";
        }
        
    }
    else{
        self.Unittwo.hidden=NO;
    }
    
    
    if ([self.forooshrightValueLabel.text length] == 4)
    {
        self.Unitone.hidden=YES;
        NSString*text2=[self.forooshrightValueLabel.text substringToIndex:1];
        NSString*text3=[self.forooshrightValueLabel.text substringWithRange:(NSMakeRange(1, 3))];
        
        self.forooshrightValueLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"و",[text3 substringToIndex:[text3 length]],@"میلیون"];
        if (((int)self.forooshpriceslider.rightValue>1000&&(int)self.forooshpriceslider.rightValue<1100)) {
            self.forooshrightValueLabel.text=@"۱ میلیارد";
        }
        if (((int)self.forooshpriceslider.rightValue>2000&&(int)self.forooshpriceslider.rightValue<2099)) {
            self.forooshrightValueLabel.text=@"۲ میلیارد";
        }
        
    }else{
        self.Unitone.hidden=NO;
    }
    
    
    
    
    
    if (self.forooshScrollView.hidden==NO) {
        
        
        self.forooshroomLabel.text =  [NSString stringWithFormat:@"%d", (int)self.forooshroomslider.value];
        if ([self.forooshroomLabel.text isEqualToString:@"0"]) {
            self.forooshroomLabel.text=@"بدون اهمیت";
            khabid=@"0";
        }
        if ([self.forooshroomLabel.text isEqualToString:@"1"]) {
            self.forooshroomLabel.text=@"۱ خواب";
            khabid=@"1";
        }
        if ([self.forooshroomLabel.text isEqualToString:@"2"]) {
            self.forooshroomLabel.text=@"۲ خواب";
            khabid=@"2";
        }
        if ([self.forooshroomLabel.text isEqualToString:@"3"]) {
            self.forooshroomLabel.text=@"۳ خواب";
            khabid=@"3";
        }
        if ([self.forooshroomLabel.text isEqualToString:@"4"]) {
            self.forooshroomLabel.text=@"۴ خواب";
            khabid=@"4";
        }
        if ([self.forooshroomLabel.text isEqualToString:@"5"]) {
            self.forooshroomLabel.text=@"۵ خواب";
            khabid=@"5";
        }
        if ([self.forooshroomLabel.text isEqualToString:@"6"]) {
            self.forooshroomLabel.text=@"بیش از ۵ خواب";
            khabid=@"6";
        }
    }
    else{
        self.ejareroomLabel.text =  [NSString stringWithFormat:@"%d", (int)self.ejarehroomsSlider.value];
        
        if ([self.ejareroomLabel.text isEqualToString:@"0"]) {
            self.ejareroomLabel.text=@"بدون اهمیت";
            khabid=@"0";
        }
        if ([self.ejareroomLabel.text isEqualToString:@"1"]) {
            self.ejareroomLabel.text=@"۱ خواب";
            khabid=@"1";
        }
        if ([self.ejareroomLabel.text isEqualToString:@"2"]) {
            self.ejareroomLabel.text=@"۲ خواب";
            khabid=@"2";
        }
        if ([self.ejareroomLabel.text isEqualToString:@"3"]) {
            self.ejareroomLabel.text=@"۳ خواب";
            khabid=@"3";
        }
        if ([self.ejareroomLabel.text isEqualToString:@"4"]) {
            self.ejareroomLabel.text=@"۴ خواب";
            khabid=@"4";
        }
        if ([self.ejareroomLabel.text isEqualToString:@"5"]) {
            self.ejareroomLabel.text=@"۵ خواب";
            khabid=@"5";
        }
        if ([self.ejareroomLabel.text isEqualToString:@"6"]) {
            self.ejareroomLabel.text=@"بیش از ۵ خواب";
            khabid=@"6";
        }
    }
    [self performSelector:@selector(method:) withObject:nil afterDelay:0.01];
}

- (IBAction)PISH:(id)sender {
    self.Tab1Img.hidden=NO;
    self.Tab2Img.hidden=YES;
    self.Tab3Img.hidden=YES;
    self.SearchTypelabel.text=@"پیش فروش";
    self.ejareScrollView.hidden=YES;
    self.forooshScrollView.hidden=NO;
}
- (IBAction)EJARE:(id)sender {
    self.Tab1Img.hidden=YES;
    self.Tab2Img.hidden=NO;
    self.Tab3Img.hidden=YES;
    self.ejareScrollView.hidden=NO;
    self.forooshScrollView.hidden=YES;
    self.SearchTypelabel.text=@"رهن و اجاره";
}
- (IBAction)FOROSH:(id)sender {
    self.Tab1Img.hidden=YES;
    self.Tab2Img.hidden=YES;
    self.Tab3Img.hidden=NO;
    self.ejareScrollView.hidden=YES;
    self.forooshScrollView.hidden=NO;
    self.SearchTypelabel.text=@"فروش";
}
- (IBAction)backButton2:(id)sender {
    [self.tableview setHidden:YES];
    [self.backButton2 setHidden:YES];
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
