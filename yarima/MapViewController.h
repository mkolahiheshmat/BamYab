//
//  MapViewController.h
//  yarima
//
//  Created by Developer on 6/3/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<UINavigationControllerDelegate,MKMapViewDelegate, NSXMLParserDelegate, CLLocationManagerDelegate>


//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (nonatomic, copy) NSString * latitudeStr;
@property (nonatomic, copy) NSString * longitudeStr;
@property BOOL isComingFromDetailVC;

@end
