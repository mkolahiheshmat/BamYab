//
//  InboxViewController.h
//  yarima
//
//  Created by Developer on 5/22/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Header.h"

@interface InboxViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (strong, nonatomic)NSMutableArray *tableData;
@property (strong, nonatomic)NSArray *messageDataInfosArray;
@property (strong, nonatomic)NSArray *fetchedDataArray;
@property (strong, nonatomic)NSMutableArray *allMessagesArray;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end
