//
//  LoginViewController.h
//  Yarima App
//
//  Created by sina on 9/28/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "AFHTTPSessionManager.h"
#import <CoreData/CoreData.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIButton *phone1Btn;
@property (strong, nonatomic) IBOutlet UIButton *phone2Btn;
@property (strong, nonatomic) IBOutlet UIButton *phone3Btn;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passTextField;
@property (strong, nonatomic) IBOutlet UITextField *repassTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UIButton *Signup_Login_Back_Btn;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *BackhomeBtn;
@property (strong, nonatomic) IBOutlet UILabel *emailissuelbl;
@property (strong, nonatomic) IBOutlet UILabel *signupcompletelbl;
@property (strong, nonatomic) IBOutlet UIButton *BackBtn;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@end
