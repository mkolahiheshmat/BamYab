//
//  AboutViewController.h
//  yarima
//
//  Created by sina on 12/7/15.
//  Copyright © 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Header.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutViewController : UIViewController<UIGestureRecognizerDelegate,MFMailComposeViewControllerDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@end
