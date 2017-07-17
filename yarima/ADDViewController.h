//
//  ADDViewController.h
//  Yarima App
//
//  Created by sina on 9/16/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
@interface ADDViewController : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MKMapViewDelegate, NSXMLParserDelegate, CLLocationManagerDelegate>{
    
    BOOL a,b,c, ismogeiat,isbalkon,isparking,isanbari,isasansor,isestakhr,issona,isjakozi,isab,isbargh,isgaz;
     BOOL flagmap;
   
    NSArray * transactionarray;
    NSArray * Roomarray;
     NSArray*Tabaghearray;
}
@property BOOL isFiltered;

@property (weak, nonatomic) IBOutlet UIButton *backButton2;
@property(nonatomic)CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITableView *Tableview;
@property (strong, nonatomic) NSString *Pagestr;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollview;
@property (strong, nonatomic) IBOutlet UIScrollView *imagesScrollview;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;
@property (strong, nonatomic) IBOutlet UIButton *addPICBtn;
@property (strong, nonatomic) IBOutlet UITextField *roomnumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *areaTextField;
@property (strong, nonatomic) IBOutlet UITextField *rahnTextField;
@property (strong, nonatomic) IBOutlet UITextField *ejareTextField;
@property (strong, nonatomic) IBOutlet UIButton *mapenableBtn;
@property (strong, nonatomic) IBOutlet UITextField *typeTextField;
@property (strong, nonatomic) IBOutlet UITextField *transectionTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *regionTextField;
@property (strong, nonatomic) IBOutlet UILabel *regionFieldid;
@property (strong, nonatomic) IBOutlet UILabel *mapenableLabel;
@property (strong, nonatomic) IBOutlet UILabel *mapdisableLabel;
@property (strong, nonatomic) IBOutlet UITextField *floorTextField;
@property (strong, nonatomic) IBOutlet UITextField *nofloorTextField;
@property (strong, nonatomic) IBOutlet UITextField *noroomTextField;
@property (strong, nonatomic) IBOutlet UITextField *yearTextField;
@property (strong, nonatomic) IBOutlet UITextField *kitchenTextField;
@property (strong, nonatomic) IBOutlet UITextField *groundTextField;
@property (strong, nonatomic) IBOutlet UITextField *positionTextField;
@property (strong, nonatomic) IBOutlet UITextField *mapTextField;
@property (strong, nonatomic) IBOutlet UITextField *infoTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *pic1Imageview;
@property (strong, nonatomic) IBOutlet UIImageView *pic2Imageview;
@property (strong, nonatomic) IBOutlet UIImageView *pic3Imageview;
@property (strong, nonatomic) IBOutlet UIImageView *pic4Imageview;
@property (strong, nonatomic) IBOutlet UIImageView *pic5Imageview;
@property (strong, nonatomic) IBOutlet UIImageView *pic6Imageview;
@property (strong, nonatomic) IBOutlet UIImageView *pic7Imageview;
@property (strong, nonatomic) IBOutlet UIImageView *pic8Imageview;

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
@property (strong, nonatomic) IBOutlet UIButton *Cancel1Btn;
@property (strong, nonatomic) IBOutlet UIButton *Cancel2Btn;
@property (strong, nonatomic) IBOutlet UIButton *Cancel3Btn;
@property (strong, nonatomic) IBOutlet UIButton *Cancel4Btn;
@property (strong, nonatomic) IBOutlet UIButton *Cancel5Btn;
@property (strong, nonatomic) IBOutlet UIButton *Cancel6Btn;
@property (strong, nonatomic) IBOutlet UIButton *Cancel7Btn;
@property (strong, nonatomic) IBOutlet UIButton *Cancel8Btn;
@property (strong, nonatomic) IBOutlet UIButton *DetailsBtn;
@property (strong, nonatomic) IBOutlet UILabel *Convertorlabel;
@property (strong, nonatomic) IBOutlet UIButton *AddNew;
@property (strong, nonatomic) IBOutlet UIButton *EditBtn;
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
@property (strong, nonatomic)  NSString *TranrowStr;
@property (strong, nonatomic)  NSString *TyperowStr;
@property (strong, nonatomic)  NSString *MapLatStr;
@property (strong, nonatomic)  NSString *MapLongStr;
@property (strong, nonatomic)  NSString *viewMapLatStr;
@property (strong, nonatomic)  NSString *viewMapLongStr;
@property (strong, nonatomic)  NSString *IDAStr;

@property (strong, nonatomic) IBOutlet UILabel *ejareConvertorlabel;
@property (strong, nonatomic) IBOutlet UILabel *rahnConvertorlabel;

@property (strong, nonatomic) IBOutlet UIButton *Action2;
@property (weak, nonatomic) IBOutlet UILabel *transactionTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *nFloorLabel;

@property (weak, nonatomic) IBOutlet UILabel *nRoomLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *kitchenLabel;
@property (weak, nonatomic) IBOutlet UILabel *groundLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *mapLabel;

@property(nonatomic, retain)NSDictionary *dictionary;

@property (weak, nonatomic) IBOutlet UIButton *AddImageButton;

@end
