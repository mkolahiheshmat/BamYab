//
//  RequestPropertyViewController.h
//  yarima
//
//  Created by Developer on 5/24/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <CoreData/CoreData.h>

@interface RequestPropertyViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end
