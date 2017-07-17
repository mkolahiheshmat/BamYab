//
//  SearchRegionViewController.h
//  Yarima App
//
//  Created by sina on 10/13/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface SearchRegionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *Tableview;
@property (strong, nonatomic) NSString *Pagestr;
@end
