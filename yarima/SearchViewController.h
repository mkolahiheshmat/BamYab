//
//  SearchViewController.h
//  Yarima App
//
//  Created by sina on 9/9/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "BJRangeSliderWithProgress.h"
#import "BJRangeViewController.h"
#import "AFHTTPSessionManager.h"
#import "ListTableViewCell.h"
#import "Reachability.h"
#import <CoreData/CoreData.h>
#import "Header.h"
@interface SearchViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
{
    BJRangeSliderWithProgress *slider;
}
@property (weak, nonatomic) IBOutlet UIButton *backButton2;
@property (strong, nonatomic) IBOutlet UILabel *Unitone;
@property (strong, nonatomic) IBOutlet UILabel *Unittwo;
@property (strong, nonatomic) IBOutlet UILabel *ejarehUnitone;
@property (strong, nonatomic) IBOutlet UILabel *ejarehUnittwo;
@property (strong, nonatomic) IBOutlet UILabel *rahnUnitone;
@property (strong, nonatomic) IBOutlet UILabel *rahnUnittwo;
@property (strong, nonatomic) IBOutlet BJRangeSliderWithProgress *forooshpriceslider;
@property (strong, nonatomic) IBOutlet BJRangeViewController *ejarehSlider;
@property (strong, nonatomic) IBOutlet BJRangeSliderWithProgress *rahnSlider;
@property (strong, nonatomic) IBOutlet BJRangeSliderWithProgress *Areaslider;
@property (strong, nonatomic) IBOutlet BJRangeSliderWithProgress *EjarehAreaslider;
@property (strong, nonatomic) IBOutlet UILabel *SearchTypelabel;
@property (strong, nonatomic)  NSString *ParkingStr;
@property (strong, nonatomic)  NSString *anbariStr;
@property (strong, nonatomic)  NSString *asansorStr;
@property (strong, nonatomic)  NSString *Parking2Str;
@property (strong, nonatomic)  NSString *anbari2Str;
@property (strong, nonatomic)  NSString *asansor2Str;
@property (strong, nonatomic) IBOutlet UIButton *PishForoshBtn;
@property (strong, nonatomic) IBOutlet UISlider *forooshareaslider;
@property (strong, nonatomic) IBOutlet UISlider *forooshroomslider;
@property (strong, nonatomic) IBOutlet UISlider *ejarehareaSlider;
@property (strong, nonatomic) IBOutlet UISlider *ejarehroomsSlider;
@property (strong, nonatomic) IBOutlet UIButton *menu;
@property (strong, nonatomic) IBOutlet UIButton *backbtn;
@property (strong, nonatomic) IBOutlet UIButton *EjareBtn;
@property (strong, nonatomic) IBOutlet UIButton *ForoshBtn;
@property (strong, nonatomic) IBOutlet UIImageView *Tab1Img;
@property (strong, nonatomic) IBOutlet UIImageView *Tab2Img;
@property (strong, nonatomic) IBOutlet UIImageView *Tab3Img;
@property (strong, nonatomic) IBOutlet UIScrollView *forooshScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *ejareScrollView;
@property (strong, nonatomic) IBOutlet UILabel *forooshleftValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *forooshrightValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *ejarehleftvalueLabel;
@property (strong, nonatomic) IBOutlet UILabel *ejarehrightvalueLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftValuearea;
@property (strong, nonatomic) IBOutlet UILabel *rightValuearea;
@property (strong, nonatomic) IBOutlet UILabel *EjarehleftValuearea;
@property (strong, nonatomic) IBOutlet UILabel *EjarehrightValuearea;
@property (strong, nonatomic) IBOutlet UILabel *rahnleftvalueLabel;
@property (strong, nonatomic) IBOutlet UILabel *rahnrightvalueLabel;
@property (strong, nonatomic) IBOutlet UILabel *ejareareaLabel;
@property (strong, nonatomic) IBOutlet UILabel *ejareroomLabel;
@property (strong, nonatomic) IBOutlet UILabel *forooshareaLabel;
@property (strong, nonatomic) IBOutlet UILabel *forooshroomLabel;
@property (strong, nonatomic) IBOutlet UITextField *ejareregionTextField;
@property (strong, nonatomic) IBOutlet UITextField *forooshregionTextField;
@property (strong, nonatomic) IBOutlet UILabel *regionidLabel;
@property (strong, nonatomic) IBOutlet UITextField *ejareTypetextField;
@property (strong, nonatomic) IBOutlet UITextField *forooshTypetextField;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *noresultview;
@end
