//
//  MapViewController.m
//  yarima
//
//  Created by Developer on 6/3/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import "MapViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import "ADDViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPSessionManager.h"
#import "ListTableViewCell.h"
#import "Header.h"
#import "ReplacerEngToPer.h"
#import "MapAnnotation.h"

@interface MapViewController ()
{
    CLLocationManager *myLocationManager;
    MKMapView *_mapView;
    UILabel *titleLabel;
    NSString *mapLatStr;
    NSString *mapLongStr;
    UIButton *tikButton;
    NSString *latitude;
    NSString *longitude;
    MapAnnotation *annotation;
    CLLocationCoordinate2D pinCoordinate;
}

@end

#define METERS_PER_MILE 1609.344

@implementation MapViewController

- (void)viewWillAppear:(BOOL)animated {
    if (!self.isComingFromDetailVC) {
        CLLocationCoordinate2D noLocation;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 500, 500);
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
        [_mapView setRegion:adjustedRegion animated:YES];
        _mapView.showsUserLocation = YES;
    }else{
        pinCoordinate.latitude = [self.latitudeStr doubleValue];
        pinCoordinate.longitude = [self.longitudeStr doubleValue];;
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.01;
        span.longitudeDelta = 0.01;
        region.span = span;
        region.center = pinCoordinate;
        
        [_mapView setRegion:region animated:TRUE];
        [_mapView regionThatFits:region];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up zoom level
    MKCoordinateSpan zoom;
    zoom.latitudeDelta = .1f; //the zoom level in degrees
    zoom.longitudeDelta = .1f;//the zoom level in degrees
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, screenHeight - 50)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
    [self.view addSubview:_mapView];
    
    if (!self.isComingFromDetailVC) {
        MKUserLocation *location = _mapView.userLocation;
        [_mapView setCenterCoordinate:location.coordinate animated:YES];
        [self addLongPressGestureToMapView];
    }else{
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
        pinCoordinate.latitude = [self.latitudeStr doubleValue];
        pinCoordinate.longitude = [self.longitudeStr doubleValue];;
        myAnnotation.coordinate = pinCoordinate;
        myAnnotation.title = @"مکان ملک";
        myAnnotation.subtitle = @"";
        [_mapView addAnnotation:myAnnotation];
    }
    myLocationManager = [[CLLocationManager alloc] init];
    myLocationManager.delegate = self;
    myLocationManager.distanceFilter = 1;
    myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [myLocationManager requestWhenInUseAuthorization];
    [myLocationManager requestAlwaysAuthorization];
    [myLocationManager startUpdatingLocation];
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.MenuBtn addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    tikButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-80,screenHeight-120 ,50, 50)];
    [tikButton setImage:[UIImage imageNamed:@"tikImage"] forState:UIControlStateNormal];
    [tikButton addTarget:self action:@selector(tikButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tikButton clipsToBounds];
    [_mapView addSubview:tikButton];
}

#pragma mark -  custom Methods

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addLongPressGestureToMapView{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(addPinToMap:)];
    lpgr.minimumPressDuration = 0.5;
    [_mapView addGestureRecognizer:lpgr];
}

- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    if (annotation == nil) {
        annotation = [[MapAnnotation alloc]init];
        annotation.coordinate = touchMapCoordinate;
        latitude = [[NSString alloc] initWithFormat:@"%f", annotation.coordinate.latitude];
        [[NSUserDefaults standardUserDefaults]setObject:latitude forKey:@"Latitude"];
        longitude = [[NSString alloc] initWithFormat:@"%f", annotation.coordinate.longitude];
        [[NSUserDefaults standardUserDefaults]setObject:longitude forKey:@"Longitude"];
        annotation.subtitle = @"";
        annotation.title = @"مکان ملک شما";
        [_mapView addAnnotation:annotation];
    }else{
        [_mapView removeAnnotation:annotation];
        annotation = nil;
    }
}

-(void) tikButtonAction{
    if (annotation != nil) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setLatLongText" object:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
