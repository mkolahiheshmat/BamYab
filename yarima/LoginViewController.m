//
//  LoginViewController.m
//  Yarima App
//
//  Created by sina on 9/28/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import "Header.h"
#import "SVProgressHUD.h"
@interface LoginViewController ()

@end

@implementation LoginViewController{
    NSMutableArray*array;
    NSString * result;
    UIAlertView *Signupalert;
}
- (void)viewDidLoad {
    self.BackBtn.hidden=YES;
    self.BackhomeBtn.hidden=YES;
    self.Signup_Login_Back_Btn.hidden=YES;
    self.emailissuelbl.hidden=YES;
    self.signupcompletelbl.hidden=YES;
    self.phone1Btn.hidden=YES;
    self.phone2Btn.hidden=YES;
    self.phone3Btn.hidden=YES;
    self.registerBtn.layer.cornerRadius=18;
    self.loginBtn.layer.cornerRadius=18;
    self.BackBtn.layer.cornerRadius=18;
    self.BackhomeBtn.layer.cornerRadius=18;
    self.Signup_Login_Back_Btn.layer.cornerRadius=18;
    
    self.nameTextField.layer.cornerRadius=15;
    self.addressTextField.layer.cornerRadius=15;
    self.phoneTextField.layer.cornerRadius=15;
    self.passTextField.layer.cornerRadius=15;
    self.repassTextField.layer.cornerRadius=15;
    self.emailTextField.layer.cornerRadius=15;
    self.scrollView.hidden=YES;
    self.BackBtn.clipsToBounds=YES;
    self.BackhomeBtn.clipsToBounds=YES;
    self.Signup_Login_Back_Btn.clipsToBounds=YES;
    self.loginBtn.clipsToBounds=YES;
    self.registerBtn.clipsToBounds=YES;
    self.nameTextField.clipsToBounds=YES;
    self.addressTextField.clipsToBounds=YES;
    self.phoneTextField.clipsToBounds=YES;
    self.passTextField.clipsToBounds=YES;
    self.repassTextField.clipsToBounds=YES;
    self.emailTextField.clipsToBounds=YES;
    self.nameTextField.delegate=self;
    self.addressTextField.delegate=self;
    self.phoneTextField.delegate=self;
    self.passTextField.delegate=self;
    self.repassTextField.delegate=self;
    self.emailTextField.delegate=self;
    self.scrollView.layer.cornerRadius=15;
    self.scrollView.layer.masksToBounds=YES;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.scrollView.bounds];
    self.scrollView.layer.masksToBounds = NO;
    self.scrollView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.scrollView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.scrollView.layer.shadowOpacity = 0.5f;
    self.scrollView.layer.shadowPath = shadowPath.CGPath;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuBtn addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [super viewDidLoad];
}
#pragma mark - TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.repassTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    return NO;
}
#pragma mark - Custom


-(IBAction)callPhone1:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:02166158735"]];
}
-(IBAction)callPhone2:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:02166158737"]];
}
-(IBAction)callPhone3:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:02166158739"]];
}

-(IBAction)backBtn:(id)sender {
    self.detailView.hidden=NO;
    self.emailissuelbl.hidden=YES;
    self.BackhomeBtn.hidden=YES;
    self.BackBtn.hidden=YES;
    self.phone1Btn.hidden=YES;
    self.phone2Btn.hidden=YES;
    self.phone3Btn.hidden=YES;

  }

- (IBAction)LOGIN:(id)sender {
    if ([self.nameTextField.text isEqualToString:@""]||[self.emailTextField.text isEqualToString:@""])
    {
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"لطفا همه فیلد ها را کامل نمایید" delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
     NSManagedObjectContext *context = [self managedObjectContext];
     NSManagedObject *newDevice = [ NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:context];
      [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
     NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL2, @"estate_members_app"];
     NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
     params[@"email"] = self.emailTextField.text;
     params[@"password"] =self.passTextField.text;
     [newDevice setValue:self.emailTextField.text forKey:@"user"];
     [newDevice setValue:self.passTextField.text  forKey:@"pass"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
     manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
     [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
    if ([[responseObject objectForKey:@"status"] isEqual:@(1)]) {
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"نام یا گذرواژه اشتباه است" delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
    [alert show];
        }
        else
        {
    for (NSDictionary *dic in [responseObject objectForKey:@"result"])
        {
  NSManagedObjectContext *context2 = [self managedObjectContext];
  NSManagedObject *newDevice2 = [ NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context2];
        
        [newDevice2 setValue:[dic valueForKey:@"member_phone"] forKey:@"phone"];
        [newDevice2 setValue:[dic valueForKey:@"member_name"] forKey:@"name"];
            [self saveContext];
        }
 
        NSUserDefaults*defualt=[NSUserDefaults standardUserDefaults];
        [defualt setObject:@"1" forKey:@"login"];
        [defualt synchronize];
            
        [SVProgressHUD dismiss];
        [self performSegueWithIdentifier:@"back" sender:nil];
            }
        } failure:^(NSURLSessionTask *operation, NSError *error)
{
        NSLog(@"Error: %@", error);
}];
}
}
- (IBAction)Call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:02166158735"]];
}
-(IBAction)signup
{
    if ([self.nameTextField.text isEqualToString:@""]||[self.emailTextField.text isEqualToString:@""]||[self.passTextField.text isEqualToString:@""]||[self.repassTextField.text isEqualToString:@""]||[self.phoneTextField.text isEqualToString:@""]||[self.addressTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"لطفا همه فیلد ها را کامل نمایید" delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        if  ([emailTest evaluateWithObject:self.emailTextField.text] != YES && [self.emailTextField.text length]!=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"لطفا ایمیل معتبر وارد کنید" message:nil delegate:self cancelButtonTitle:@"تایید" otherButtonTitles:nil];
            [alert show];
            return;
        }else{
            
        
        if (!([self.repassTextField.text isEqualToString:self.passTextField.text])) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"رمز مجدد اشتباه است" message:nil delegate:self cancelButtonTitle:@"تایید" otherButtonTitles:nil];
            [alert show];
        }
        else{
         [SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL2, @"add_estate_app"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"email"] = self.emailTextField.text;
        params[@"password"] = self.passTextField.text;
        params[@"Address"] = self.addressTextField.text;
        params[@"Name"] = self.nameTextField.text;
        params[@"Tel"] = self.phoneTextField.text;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
        if ([[responseObject objectForKey:@"status"] isEqual:@(1)]) {
                [SVProgressHUD dismiss];
            self.detailView.hidden=YES;
            self.emailissuelbl.hidden=NO;
            self.BackhomeBtn.hidden=NO;
            self.BackBtn.hidden=NO;
            self.phone1Btn.hidden=NO;
            self.phone2Btn.hidden=NO;
            self.phone3Btn.hidden=NO;

            }
            else
            {
            [SVProgressHUD dismiss];
            self.signupcompletelbl.hidden=NO;
            self.Signup_Login_Back_Btn.hidden=NO;
            self.detailView.hidden=YES;
            self.BackBtn.hidden=NO;
            self.BackhomeBtn.hidden=NO;
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:nil delegate:self cancelButtonTitle:@"بازگشت" otherButtonTitles:nil, nil];
            [alert show];
            NSLog(@"Error: %@", error);
        }];}}
}}
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - Coredata
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
@end
