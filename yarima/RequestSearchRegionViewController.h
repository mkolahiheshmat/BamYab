//
//  RequestSearchRegionViewController.h
//  yarima
//
//  Created by Developer on 5/29/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RequestSearchRegionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSString *Pagestr;
@property (weak, nonatomic) IBOutlet UITableView *Tableview;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@end
