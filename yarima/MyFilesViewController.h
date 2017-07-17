//
//  MyFilesViewController.h
//  yarima
//
//  Created by sina on 12/30/15.
//  Copyright © 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "SWRevealViewController.h"
#import "AFHTTPSessionManager.h"
#import "Header.h"
#import <CoreData/CoreData.h>
#import "Reachability.h"
@interface MyFilesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    Reachability *internetReachableFoo;
}
@property (strong, nonatomic) IBOutlet UIImageView *Tab1Img;
@property (strong, nonatomic) IBOutlet UIImageView *Tab2Img;
@property (strong, nonatomic) IBOutlet UITableView *tableViewaddedfiles;
@property (strong, nonatomic) IBOutlet UITableView *tableViewmyfiles;
@property (strong, nonatomic) IBOutlet UIButton *menubtn;
@end