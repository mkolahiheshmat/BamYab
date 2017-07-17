//
//  MenuViewController.h
//  yarima
//
//  Created by sina on 12/28/15.
//  Copyright © 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface MenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *exitBtn;
@property (strong, nonatomic) IBOutlet UIButton *myHomesBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *exiticonBtn;
@property (strong, nonatomic) IBOutlet UIButton *myHomesiconBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginiconBtn;
@property (strong, nonatomic) IBOutlet UILabel *exitlabel;
@property (strong, nonatomic) IBOutlet UILabel *myHomeslabel;
@property (strong, nonatomic) IBOutlet UILabel *loginlabel;

@end
