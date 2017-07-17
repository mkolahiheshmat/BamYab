//
//  DetailViewController.h
//  Yarima App
//
//  Created by sina on 9/9/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "Header.h"
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"

@interface DetailViewController : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MKMapViewDelegate, NSXMLParserDelegate, CLLocationManagerDelegate,UIAlertViewDelegate,UIScrollViewDelegate>{
    Reachability *internetReachableFoo;
     BOOL flagmap;
}
@property(nonatomic)CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *mapshow;
@property (strong, nonatomic) IBOutlet UIScrollView *Scroll;
@property (strong, nonatomic) IBOutlet UIButton *menu;
@property (strong, nonatomic) IBOutlet UIScrollView *DetailsScroll;
@property (strong, nonatomic) IBOutlet UILabel *roomnumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *areafieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *typefieldLabel;
@property (strong, nonatomic) NSString *transectionfieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *pricefieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressfieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *regionfieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *floorLabel;
@property (strong, nonatomic) IBOutlet UILabel *nofloorLabel;
@property (strong, nonatomic) IBOutlet UILabel *noroomLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *kitchenLabel;
@property (strong, nonatomic) IBOutlet UILabel *groundLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UILabel *mapLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *confirmId;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UIButton *Action2;
@property (strong, nonatomic) IBOutlet UILabel *ejarehlabel;
@property (strong, nonatomic) IBOutlet UILabel *rahnlabel;

@property (strong, nonatomic) IBOutlet UIButton *checkboxVazeatsokoonatBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxbalkonBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxparkingBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxanbariBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxasansorBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxestakhrBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxsonaBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxjakoziBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxabBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxbarghBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkboxgazBtn;
@property (strong, nonatomic) IBOutlet UIButton *addbtn;
@property (strong, nonatomic) IBOutlet UIButton *newbtn;
@property (strong, nonatomic) IBOutlet UIButton *finalladdBtn;
@property (strong, nonatomic) IBOutlet UIButton *finallhomeBtn;

@property (strong, nonatomic) IBOutlet UIView *rahnView;

@property (strong, nonatomic)  NSString *balkonStr;
@property (strong, nonatomic)  NSString *parkingStr;
@property (strong, nonatomic)  NSString *asansorStr;
@property (strong, nonatomic)  NSString *sonaStr;
@property (strong, nonatomic)  NSString *abStr;
@property (strong, nonatomic)  NSString *gazStr;
@property (strong, nonatomic)  NSString *barghStr;
@property (strong, nonatomic)  NSString *anbariStr;
@property (strong, nonatomic)  NSString *estahkrStr;
@property (strong, nonatomic)  NSString *jakoziStr;
@property (strong, nonatomic)  NSString *mogeiatStr;
@property (strong, nonatomic)  NSString *VSStr;

@property (strong, nonatomic)  NSString *TranrowStr;
@property (strong, nonatomic)  NSString *TyperowStr;

@property (strong, nonatomic)  NSString *MapLatStr;
@property (strong, nonatomic)  NSString *MapLongStr;

@property (strong, nonatomic)  IBOutlet UILabel*IDAlabel;
//@property (strong, nonatomic)  NSMutableArray *imagesArray;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundColor;
@property BOOL isDetailOfAdd;

@end
