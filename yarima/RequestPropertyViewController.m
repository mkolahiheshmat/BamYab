//
//  RequestPropertyViewController.m
//  yarima
//
//  Created by Developer on 5/24/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import "RequestPropertyViewController.h"
#import "Header.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "CustomImageView.h"
#import "SVProgressHUD.h"
#import "AFHTTPSessionManager.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import "SWRevealViewController.h"
#import "AFHTTPSessionManager.h"
#import "RequestSearchRegionViewController.h"
#import "ReplacerEngToPer.h"

@interface RequestPropertyViewController ()
{
    UIScrollView *scrollView;
    NSMutableDictionary *paramsDictionary;
    UIButton *sendButton;
    UITextField *nameTextField;
    UITextField *emailTextField;
    UITextField *mobileTextField;
    UITextField *regionTextField;
    UITextField *typeTextField;
    UITextField *transactionTypeTextField;
    UITextField *minPriceTextField;
    UITextField *maxPriceTextField;
    UITextField *minAreaTextField;
    UITextField *maxAreaTextField;
    UITextField *descriptionTextField;
    UITextField *minRahnTextField;
    UITextField *minEjareTextField;
    UITextField *maxRahnTextField;
    UITextField *maxEjareTextField;
    UIPickerView *transactionTypePickerView;
    UIPickerView *typePickerView;
    NSArray *transactionTypeArray;
    NSMutableArray *typeArray;
    UIToolbar *transactionTypeToolbar;
    NSMutableArray *property; //نوع ملک
    UIView *lineView7;//minPrice LineView
    UIView *lineView8;//maxPriceLineView
    UIView *lineView12;//minRahnLineView
    UIView *lineView13;//minEjareLineView
    UIView *lineView14;//maxRahnLineView
    UIView *lineView15;//maxEjareLineView
    
    UILabel *minPriceConvertorLabel;
    UILabel *minRahnConvertorLabel;
    UILabel *minEjareConvertorLabel;
    UILabel *maxPriceConvertorLabel;
    UILabel *maxRahnConvertorLabel;
    UILabel *maxEjareConvertorLabel;
    UIButton *tikButton;
    NSString *regionID;
    UIView *transparentView;
    //NSInteger transatctionTypeID;
    //NSInteger propertyTypeID;
}
@end

@implementation RequestPropertyViewController

- (void)viewWillAppear:(BOOL)animated {
    NSString *regionText = [[NSUserDefaults standardUserDefaults]objectForKey:@"RegionText"];
    regionID = [[NSUserDefaults standardUserDefaults]objectForKey:@"RegionID"];
    if (regionText!=nil) {
        regionTextField.text = regionText;
    }
}
-(void) viewWillDisappear:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [self.view endEditing:true];
        //        [scrollView endEditing:true];
       [self tapAction];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    transactionTypeArray = [[NSArray alloc]initWithObjects:@"رهن",@"فروش",
                            @"اجاره موقت",@"معاوضه",@"پیش فروش",@"رهن و اجاره",@"مشارکت در ساخت", nil];
    
    NSManagedObjectContext *managedObjectContext7 = [self managedObjectContext];
    NSFetchRequest *fetchRequest5 = [[NSFetchRequest alloc]initWithEntityName:@"Property"];
    property = [[managedObjectContext7 executeFetchRequest:fetchRequest5 error:nil] mutableCopy];
    typeArray=[[NSMutableArray alloc]init];
    
    for (NSDictionary * dic in [property valueForKey:@"property"]){
        [typeArray addObject:dic];
    }
    
    [self typePickerMaker];
    
    [self transactionTypePickerMaker];
    
    [self scrollViewMaker];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [tapGesture setNumberOfTouchesRequired:1];
    [scrollView addGestureRecognizer:tapGesture];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.menuButton addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    tikButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-70,screenHeight-70 ,50, 50)];
    [tikButton setImage:[UIImage imageNamed:@"tikImage"] forState:UIControlStateNormal];
    [tikButton addTarget:self action:@selector(tikButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tikButton clipsToBounds];
    tikButton.hidden = NO;
    [self.view addSubview:tikButton];
}

#pragma mark - text field delegate

//- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
//////    //transactionTypePickerView.hidden = YES;
//////    //typePickerView.hidden = YES;
////    if (textField ==typeTextField) {
////        //[self tapAction];
////        //[self.view endEditing:YES];
////        //[textField resignFirstResponder];
////        [self showTypePickerView];
////    }else{
////        [textField resignFirstResponder];
////    }
////    if (textField == transactionTypeTextField) {
////        //[self tapAction];
////        //[self.view endEditing:YES];
////        //[textField resignFirstResponder];
////        [self showTransactionTypePickerView];
////    }else{
////        [textField resignFirstResponder];
////    }
////    if (textField == regionTextField) {
////        [textField resignFirstResponder];
////        [self performSegueWithIdentifier: @"showRequestSearchVCSegue" sender: self];
////    }
////    else{
////        [textField becomeFirstResponder];
////    }
////    CGRect rect = textField.frame;
////    if (rect.origin.y >= screenHeight/2) {
////        if (textField == transactionTypeTextField || textField == typeTextField) {
////            rect.origin.y += 170;
////            [scrollView scrollRectToVisible:rect animated:YES];
////        }else{
////            rect.origin.y += 240;
////            [scrollView scrollRectToVisible:rect animated:YES];
////        }
////    }
//    return YES;
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//   // transactionTypePickerView.hidden = YES;
//   // typePickerView.hidden = YES;
////    [self tapAction];
    if (textField ==typeTextField) {
        //[self tapAction];
        //[self.view endEditing:YES];
        //[textField resignFirstResponder];
        [self showTypePickerView];
    }
    if (textField == transactionTypeTextField) {
        //[self tapAction];
        //[self.view endEditing:YES];
        //[textField resignFirstResponder];
        [self showTransactionTypePickerView];
    }
    if (textField == regionTextField) {
        //[textField resignFirstResponder];
        //[self tapAction];
        [self performSegueWithIdentifier: @"showRequestSearchVCSegue" sender: self];
    }
//    else{
//        [textField becomeFirstResponder];
//    }
//    CGRect rect2 = textField.frame;
//    if (rect2.origin.y >= screenHeight/2) {
//        if (textField == transactionTypeTextField || textField == typeTextField) {
//            rect2.origin.y += 170;
//            [scrollView scrollRectToVisible:rect2 animated:YES];
//        }else{
//            rect2.origin.y += 240;
//            [scrollView scrollRectToVisible:rect2 animated:YES];
//        }
//    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
        [textField resignFirstResponder];
    if (([transactionTypeTextField.text isEqualToString:@"رهن"]) || ([transactionTypeTextField.text isEqualToString:@"رهن و اجاره"]) || ([transactionTypeTextField.text isEqualToString:@"اجاره موقت"])) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"showRahnEjareTextFields" object:nil];
    }
    return YES;
}

-(void)textFieldDidChange :(UITextField *)textField{
#pragma mark MIN Price,Rahn,Ejare convertor
    if ([transactionTypeTextField.text isEqualToString:@"رهن"]) {
        
        if ([minPriceTextField.text length] == 0){
            minPriceConvertorLabel.text=@"";
        }
        if ([minEjareTextField.text length] == 0){
            minEjareConvertorLabel.text=@"";
        }
        if ([minRahnTextField.text length] == 0){
            minRahnConvertorLabel.text=@"";
        }
        if ([minPriceTextField.text length] == 1){
            minPriceConvertorLabel.text = [NSString stringWithFormat:@"%@%@",minPriceTextField.text,@" میلیون تومان"];
        }
        if ([minPriceTextField.text length] == 2){
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minPriceTextField.text,@" میلیون تومان"];
        }
        if ([minPriceTextField.text length] == 3){
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minPriceTextField.text,@" میلیون تومان"];
        }
        if ([minPriceTextField.text length] == 4){
            NSString*text2=[minPriceTextField.text substringToIndex:1];
            NSString*text3=[minPriceTextField.text substringWithRange:(NSMakeRange(1, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]){
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]){
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@" میلیون تومان "];
            if ([minPriceTextField.text isEqualToString:@"1000"]) {
                minPriceConvertorLabel.text=@"۱ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"2000"]) {
                minPriceConvertorLabel.text=@"۲ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"3000"]) {
                minPriceConvertorLabel.text=@"۳ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"4000"]) {
                minPriceConvertorLabel.text=@"۴ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"5000"]) {
                minPriceConvertorLabel.text=@"۵ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"6000"]) {
                minPriceConvertorLabel.text=@"۶ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"7000"]) {
                minPriceConvertorLabel.text=@"۷ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"8000"]) {
                minPriceConvertorLabel.text=@"۸ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"9000"]) {
                minPriceConvertorLabel.text=@"۹ میلیارد تومان";
            }
        }
        if ([minPriceTextField.text length] == 5){
            NSString*text2=[minPriceTextField.text substringToIndex:2];
            NSString*text3=[minPriceTextField.text substringWithRange:(NSMakeRange(2,3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]){
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]){
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@" میلیون تومان "];
            if ([minPriceTextField.text isEqualToString:@"10000"]) {
                minPriceConvertorLabel.text=@"۱۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"20000"]) {
                minPriceConvertorLabel.text=@"۲۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"30000"]) {
                minPriceConvertorLabel.text=@"۳۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"40000"]) {
                minPriceConvertorLabel.text=@"۴۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"50000"]) {
                minPriceConvertorLabel.text=@"۵۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"60000"]) {
                minPriceConvertorLabel.text=@"۶۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"70000"]) {
                minPriceConvertorLabel.text=@"۷۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"80000"]) {
                minPriceConvertorLabel.text=@"۸۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"90000"]) {
                minPriceConvertorLabel.text=@"۹۰ میلیارد تومان";
            }
        }
        if ([minPriceTextField.text length] == 6){
            NSString*text2=[minPriceTextField.text substringToIndex:3];
            NSString*text3=[minPriceTextField.text substringWithRange:(NSMakeRange(3, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@" میلیون تومان"];
            if ([minPriceTextField.text isEqualToString:@"100000"]) {
                minPriceConvertorLabel.text=@"۱۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"200000"]) {
                minPriceConvertorLabel.text=@"۲۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"300000"]) {
                minPriceConvertorLabel.text=@"۳۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"400000"]) {
                minPriceConvertorLabel.text=@"۴۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"500000"]) {
                minPriceConvertorLabel.text=@"۵۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"600000"]) {
                minPriceConvertorLabel.text=@"۶۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"700000"]) {
                minPriceConvertorLabel.text=@"۷۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"800000"]) {
                minPriceConvertorLabel.text=@"۸۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"900000"]) {
                minPriceConvertorLabel.text=@"۹۰۰ میلیارد تومان";
            }
        }
    }else{
        if ([minPriceTextField.text length] == 0){
            minPriceConvertorLabel.text=@"";
        }
        if ([minEjareTextField.text length] == 0){
            minEjareConvertorLabel.text=@"";
        }
        if ([minRahnTextField.text length] == 0){
            minRahnConvertorLabel.text=@"";
        }
        if ([minPriceTextField.text length] == 1){
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minPriceTextField.text,@"میلیون تومان"];
        }
        if ([minPriceTextField.text length] == 2){
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minPriceTextField.text,@"میلیون تومان"];
        }
        if ([minPriceTextField.text length] == 3){
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minPriceTextField.text,@"میلیون تومان"];
        }
        if ([minPriceTextField.text length] == 4){
            NSString*text2=[minPriceTextField.text substringToIndex:1];
            NSString*text3=[minPriceTextField.text substringWithRange:(NSMakeRange(1, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            if ([minPriceTextField.text isEqualToString:@"1000"]) {
                minPriceConvertorLabel.text=@"۱ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"2000"]) {
                minPriceConvertorLabel.text=@"۲ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"3000"]) {
                minPriceConvertorLabel.text=@"۳ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"4000"]) {
                minPriceConvertorLabel.text=@"۴ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"5000"]) {
                minPriceConvertorLabel.text=@"۵ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"6000"]) {
                minPriceConvertorLabel.text=@"۶ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"7000"]) {
                minPriceConvertorLabel.text=@"۷ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"8000"]) {
                minPriceConvertorLabel.text=@"۸ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"9000"]) {
                minPriceConvertorLabel.text=@"۹ میلیارد تومان";
            }
        }
        if ([minPriceTextField.text length] == 5){
            NSString*text2=[minPriceTextField.text substringToIndex:2];
            NSString*text3=[minPriceTextField.text substringWithRange:(NSMakeRange(2,3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            if ([minPriceTextField.text isEqualToString:@"10000"]) {
                minPriceConvertorLabel.text=@"۱۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"20000"]) {
                minPriceConvertorLabel.text=@"۲۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"30000"]) {
                minPriceConvertorLabel.text=@"۳۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"40000"]) {
                minPriceConvertorLabel.text=@"۴۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"50000"]) {
                minPriceConvertorLabel.text=@"۵۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"60000"]) {
                minPriceConvertorLabel.text=@"۶۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"70000"]) {
                minPriceConvertorLabel.text=@"۷۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"80000"]) {
                minPriceConvertorLabel.text=@"۸۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"90000"]) {
                minPriceConvertorLabel.text=@"۹۰ میلیارد تومان";
            }
        }
        if ([minPriceTextField.text length] == 6){
            NSString*text2=[minPriceTextField.text substringToIndex:3];
            NSString*text3=[minPriceTextField.text substringWithRange:(NSMakeRange(3, 3))];
            
            if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
                text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            minPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
            if ([minPriceTextField.text isEqualToString:@"100000"]) {
                minPriceConvertorLabel.text=@"۱۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"200000"]) {
                minPriceConvertorLabel.text=@"۲۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"300000"]) {
                minPriceConvertorLabel.text=@"۳۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"400000"]) {
                minPriceConvertorLabel.text=@"۴۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"500000"]) {
                minPriceConvertorLabel.text=@"۵۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"600000"]) {
                minPriceConvertorLabel.text=@"۶۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"700000"]) {
                minPriceConvertorLabel.text=@"۷۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"800000"]) {
                minPriceConvertorLabel.text=@"۸۰۰ میلیارد تومان";
            }
            if ([minPriceTextField.text isEqualToString:@"900000"]) {
                minPriceConvertorLabel.text=@"۹۰۰ میلیارد تومان";
            }
        }
    }
    if ([minRahnTextField.text length] == 5){
        NSString*text2=[minRahnTextField.text substringToIndex:2];
        NSString*text3=[minRahnTextField.text substringWithRange:(NSMakeRange(2,3))];
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        minRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
        if ([minRahnTextField.text isEqualToString:@"10000"]) {
            minRahnConvertorLabel.text=@"۱۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"20000"]) {
            minRahnConvertorLabel.text=@"۲۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"30000"]) {
            minRahnConvertorLabel.text=@"۳۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"40000"]) {
            minRahnConvertorLabel.text=@"۴۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"50000"]) {
            minRahnConvertorLabel.text=@"۵۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"60000"]) {
            minRahnConvertorLabel.text=@"۶۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"70000"]) {
            minRahnConvertorLabel.text=@"۷۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"80000"]) {
            minRahnConvertorLabel.text=@"۸۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"90000"]) {
            minRahnConvertorLabel.text=@"۹۰ میلیارد تومان";
        }
    }
    if ([minRahnTextField.text length] == 6){
        NSString*text2=[minRahnTextField.text substringToIndex:3];
        NSString*text3=[minRahnTextField.text substringWithRange:(NSMakeRange(3, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        minRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@" و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
        if ([minRahnTextField.text isEqualToString:@"100000"]) {
            minRahnConvertorLabel.text=@"۱۰۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"200000"]) {
            minRahnConvertorLabel.text=@"۲۰۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"300000"]) {
            minRahnConvertorLabel.text=@"۳۰۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"400000"]) {
            minRahnConvertorLabel.text=@"۴۰۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"500000"]) {
            minRahnConvertorLabel.text=@"۵۰۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"600000"]) {
            minRahnConvertorLabel.text=@"۶۰۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"700000"]) {
            minRahnConvertorLabel.text=@"۷۰۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"800000"]) {
            minRahnConvertorLabel.text=@"۸۰۰ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"900000"]) {
            minRahnConvertorLabel.text=@"۹۰۰ میلیارد تومان";
        }
    }
    if ([minRahnTextField.text length] == 4){
        NSString*text2=[minRahnTextField.text substringToIndex:1];
        NSString*text3=[minRahnTextField.text substringWithRange:(NSMakeRange(1, 3))];
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        minRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیارد",@"  و",[text3 substringToIndex:[text3 length]],@"میلیون تومان"];
        
        if ([minRahnTextField.text isEqualToString:@"1000"]) {
            minRahnConvertorLabel.text=@"۱ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"2000"]) {
            minRahnConvertorLabel.text=@"۲ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"3000"]) {
            minRahnConvertorLabel.text=@"۳ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"4000"]) {
            minRahnConvertorLabel.text=@"۴ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"5000"]) {
            minRahnConvertorLabel.text=@"۵ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"6000"]) {
            minRahnConvertorLabel.text=@"۶ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"7000"]) {
            minRahnConvertorLabel.text=@"۷ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"8000"]) {
            minRahnConvertorLabel.text=@"۸ میلیارد تومان";
        }
        if ([minRahnTextField.text isEqualToString:@"9000"]) {
            minRahnConvertorLabel.text=@"۹ میلیارد تومان";
        }
    }
    if ([minRahnTextField.text length] == 1){
        minRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minRahnTextField.text,@" میلیون تومان"];
    }
    if ([minRahnTextField.text length] == 2){
        minRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minRahnTextField.text,@" میلیون تومان"];
    }
    if ([minRahnTextField.text length] == 3){
        minRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minRahnTextField.text,@" میلیون تومان"];
    }
    if ([minEjareTextField.text length] == 9){
        NSString*text2=[minEjareTextField.text substringToIndex:3];
        NSString*text3=[minEjareTextField.text substringWithRange:(NSMakeRange(3, 3))];
        NSString*text4=[minEjareTextField.text substringWithRange:(NSMakeRange(6, 3))];
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار ",@"و",[text4 substringToIndex:[text4 length]],@"تومان"];
        if ([minEjareTextField.text isEqualToString:@"100000000"]) {
            minEjareConvertorLabel.text=@"۱۰۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"200000000"]) {
            minEjareConvertorLabel.text=@"۲۰۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"300000000"]) {
            minEjareConvertorLabel.text=@"۳۰۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"400000000"]) {
            minEjareConvertorLabel.text=@"۴۰۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"500000000"]) {
            minEjareConvertorLabel.text=@"۵۰۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"600000000"]) {
            minEjareConvertorLabel.text=@"۶۰۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"700000000"]) {
            minEjareConvertorLabel.text=@"۷۰۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"800000000"]) {
            minEjareConvertorLabel.text=@"۸۰۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"900000000"]) {
            minEjareConvertorLabel.text=@"۹۰۰ میلیون تومان";
        }
    }
    if ([minEjareTextField.text length] == 8){
        NSString*text2=[minEjareTextField.text substringToIndex:2];
        NSString*text3=[minEjareTextField.text substringWithRange:(NSMakeRange(2,3))];
        NSString*text4=[minEjareTextField.text substringWithRange:(NSMakeRange(5, 3))];
        
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار ",@"و",[text4 substringToIndex:[text4 length]],@"تومان"];
        if ([minEjareTextField.text isEqualToString:@"10000000"]) {
            minEjareConvertorLabel.text=@"۱۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"20000000"]) {
            minEjareConvertorLabel.text=@"۲۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"30000000"]) {
            minEjareConvertorLabel.text=@"۳۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"40000000"]) {
            minEjareConvertorLabel.text=@"۴۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"50000000"]) {
            minEjareConvertorLabel.text=@"۵۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"60000000"]) {
            minEjareConvertorLabel.text=@"۶۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"70000000"]) {
            minEjareConvertorLabel.text=@"۷۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"80000000"]) {
            minEjareConvertorLabel.text=@"۸۰ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"90000000"]) {
            minEjareConvertorLabel.text=@"۹۰ میلیون تومان";
        }
    }
    if ([minEjareTextField.text length] == 7){
        NSString*text2=[minEjareTextField.text substringToIndex:1];
        NSString*text3=[minEjareTextField.text substringWithRange:(NSMakeRange(1, 3))];
        NSString*text4=[minEjareTextField.text substringWithRange:(NSMakeRange(4, 3))];
        
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"میلیون",@" و",[text3 substringToIndex:[text3 length]],@"هزار ",@"و",[text4 substringToIndex:[text4 length]],@"تومان"];
        if ([minEjareTextField.text isEqualToString:@"1000000"]) {
            minEjareConvertorLabel.text=@"۱ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"2000000"]) {
            minEjareConvertorLabel.text=@"۲ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"3000000"]) {
            minEjareConvertorLabel.text=@"۳ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"4000000"]) {
            minEjareConvertorLabel.text=@"۴ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"5000000"]) {
            minEjareConvertorLabel.text=@"۵ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"6000000"]) {
            minEjareConvertorLabel.text=@"۶ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"7000000"]) {
            minEjareConvertorLabel.text=@"۷ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"8000000"]) {
            minEjareConvertorLabel.text=@"۸ میلیون تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"9000000"]) {
            minEjareConvertorLabel.text=@"۹ میلیون تومان";
        }
    }
    if ([minEjareTextField.text length] == 6){
        NSString*text2=[minEjareTextField.text substringToIndex:3];
        NSString*text3=[minEjareTextField.text substringWithRange:(NSMakeRange(3, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
            
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]&&![[text3 substringToIndex:3] isEqualToString:@"000"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
        if ([minEjareTextField.text isEqualToString:@"100000"]) {
            minEjareConvertorLabel.text=@"۱۰۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"200000"]) {
            minEjareConvertorLabel.text=@"۲۰۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"300000"]) {
            minEjareConvertorLabel.text=@"۳۰۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"400000"]) {
            minEjareConvertorLabel.text=@"۴۰۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"500000"]) {
            minEjareConvertorLabel.text=@"۵۰۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"600000"]) {
            minEjareConvertorLabel.text=@"۶۰۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"700000"]) {
            minEjareConvertorLabel.text=@"۷۰۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"800000"]) {
            minEjareConvertorLabel.text=@"۸۰۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"900000"]) {
            minEjareConvertorLabel.text=@"۹۰۰ هزار تومان";
        }
    }
    if ([minEjareTextField.text length] == 5){
        NSString*text2=[minEjareTextField.text substringToIndex:2];
        NSString*text3=[minEjareTextField.text substringWithRange:(NSMakeRange(2, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
        if ([minEjareTextField.text isEqualToString:@"10000"]) {
            minEjareConvertorLabel.text=@"۱۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"20000"]) {
            minEjareConvertorLabel.text=@"۲۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"30000"]) {
            minEjareConvertorLabel.text=@"۳۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"40000"]) {
            minEjareConvertorLabel.text=@"۴۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"50000"]) {
            minEjareConvertorLabel.text=@"۵۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"60000"]) {
            minEjareConvertorLabel.text=@"۶۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"70000"]) {
            minEjareConvertorLabel.text=@"۷۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"80000"]) {
            minEjareConvertorLabel.text=@"۸۰ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"90000"]) {
            minEjareConvertorLabel.text=@"۹۰ هزار تومان";
        }
    }
    if ([minEjareTextField.text length] == 4){
        NSString*text2=[minEjareTextField.text substringToIndex:1];
        NSString*text3=[minEjareTextField.text substringWithRange:(NSMakeRange(1, 3))];
        
        if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&![[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text3 substringToIndex:1] isEqualToString:@"0"]&&[[text3 substringToIndex:2] isEqualToString:@"00"]) {
            text3 = [text3 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text2 substringToIndex:[text2 length]],@"هزار",@" و",[text3 substringToIndex:[text3 length]],@"تومان"];
        if ([minEjareTextField.text isEqualToString:@"1000"]) {
            minEjareConvertorLabel.text=@"۱ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"2000"]) {
            minEjareConvertorLabel.text=@"۲ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"3000"]) {
            minEjareConvertorLabel.text=@"۳ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"4000"]) {
            minEjareConvertorLabel.text=@"۴ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"5000"]) {
            minEjareConvertorLabel.text=@"۵ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"6000"]) {
            minEjareConvertorLabel.text=@"۶ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"7000"]) {
            minEjareConvertorLabel.text=@"۷ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"8000"]) {
            minEjareConvertorLabel.text=@"۸ هزار تومان";
        }
        if ([minEjareTextField.text isEqualToString:@"9000"]) {
            minEjareConvertorLabel.text=@"۹ هزار تومان";
        }
    }
    if ([minEjareTextField.text length] == 3){
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minEjareTextField.text,@"تومان"];
    }
    if ([minEjareTextField.text length] == 2){
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minEjareTextField.text,@"تومان"];
    }
    if ([minEjareTextField.text length] == 1){
        minEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@",minEjareTextField.text,@"تومان"];
    }
#pragma mark MAX Price,Rahn,Ejare convertor
    if ([transactionTypeTextField.text isEqualToString:@"رهن"]) {
        
        if ([maxPriceTextField.text length] == 0){
            maxPriceConvertorLabel.text=@"";
        }
        if ([maxEjareTextField.text length] == 0){
            maxEjareConvertorLabel.text=@"";
        }
        if ([maxRahnTextField.text length] == 0){
            maxRahnConvertorLabel.text=@"";
        }
        if ([maxPriceTextField.text length] == 1){
            maxPriceConvertorLabel.text = [NSString stringWithFormat:@"%@%@",maxPriceTextField.text,@" میلیون تومان"];
        }
        if ([maxPriceTextField.text length] == 2){
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxPriceTextField.text,@" میلیون تومان"];
        }
        if ([maxPriceTextField.text length] == 3){
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxPriceTextField.text,@" میلیون تومان"];
        }
        if ([maxPriceTextField.text length] == 4){
            NSString*text6=[maxPriceTextField.text substringToIndex:1];
            NSString*text7=[maxPriceTextField.text substringWithRange:(NSMakeRange(1, 3))];
            
            if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]){
                text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]){
                text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@" و",[text7 substringToIndex:[text7 length]],@" میلیون تومان "];
            if ([maxPriceTextField.text isEqualToString:@"1000"]) {
                maxPriceConvertorLabel.text=@"۱ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"2000"]) {
                maxPriceConvertorLabel.text=@"۲ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"3000"]) {
                maxPriceConvertorLabel.text=@"۳ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"4000"]) {
                maxPriceConvertorLabel.text=@"۴ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"5000"]) {
                maxPriceConvertorLabel.text=@"۵ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"6000"]) {
                maxPriceConvertorLabel.text=@"۶ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"7000"]) {
                maxPriceConvertorLabel.text=@"۷ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"8000"]) {
                maxPriceConvertorLabel.text=@"۸ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"9000"]) {
                maxPriceConvertorLabel.text=@"۹ میلیارد تومان";
            }
        }
        if ([maxPriceTextField.text length] == 5){
            NSString*text6=[maxPriceTextField.text substringToIndex:2];
            NSString*text7=[maxPriceTextField.text substringWithRange:(NSMakeRange(2,3))];
            
            if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]){
                text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]){
                text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@" و",[text7 substringToIndex:[text7 length]],@" میلیون تومان "];
            if ([maxPriceTextField.text isEqualToString:@"10000"]) {
                maxPriceConvertorLabel.text=@"۱۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"20000"]) {
                maxPriceConvertorLabel.text=@"۲۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"30000"]) {
                maxPriceConvertorLabel.text=@"۳۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"40000"]) {
                maxPriceConvertorLabel.text=@"۴۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"50000"]) {
                maxPriceConvertorLabel.text=@"۵۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"60000"]) {
                maxPriceConvertorLabel.text=@"۶۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"70000"]) {
                maxPriceConvertorLabel.text=@"۷۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"80000"]) {
                maxPriceConvertorLabel.text=@"۸۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"90000"]) {
                maxPriceConvertorLabel.text=@"۹۰ میلیارد تومان";
            }
        }
        if ([maxPriceTextField.text length] == 6){
            NSString*text6=[maxPriceTextField.text substringToIndex:3];
            NSString*text7=[maxPriceTextField.text substringWithRange:(NSMakeRange(3, 3))];
            
            if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]&&![[text7 substringToIndex:3] isEqualToString:@"000"]) {
                
                text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]&&![[text7 substringToIndex:3] isEqualToString:@"000"]) {
                text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@" و",[text7 substringToIndex:[text7 length]],@" میلیون تومان"];
            if ([maxPriceTextField.text isEqualToString:@"100000"]) {
                maxPriceConvertorLabel.text=@"۱۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"200000"]) {
                maxPriceConvertorLabel.text=@"۲۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"300000"]) {
                maxPriceConvertorLabel.text=@"۳۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"400000"]) {
                maxPriceConvertorLabel.text=@"۴۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"500000"]) {
                maxPriceConvertorLabel.text=@"۵۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"600000"]) {
                maxPriceConvertorLabel.text=@"۶۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"700000"]) {
                maxPriceConvertorLabel.text=@"۷۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"800000"]) {
                maxPriceConvertorLabel.text=@"۸۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"900000"]) {
                maxPriceConvertorLabel.text=@"۹۰۰ میلیارد تومان";
            }
        }
    }else{
        if ([maxPriceTextField.text length] == 0){
            maxPriceConvertorLabel.text=@"";
        }
        if ([maxEjareTextField.text length] == 0){
            maxEjareConvertorLabel.text=@"";
        }
        if ([maxRahnTextField.text length] == 0){
            maxRahnConvertorLabel.text=@"";
        }
        if ([maxPriceTextField.text length] == 1){
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxPriceTextField.text,@"میلیون تومان"];
        }
        if ([maxPriceTextField.text length] == 2){
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxPriceTextField.text,@"میلیون تومان"];
        }
        if ([maxPriceTextField.text length] == 3){
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxPriceTextField.text,@"میلیون تومان"];
        }
        if ([maxPriceTextField.text length] == 4){
            NSString*text6=[maxPriceTextField.text substringToIndex:1];
            NSString*text7=[maxPriceTextField.text substringWithRange:(NSMakeRange(1, 3))];
            
            if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]) {
                
                text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]) {
                text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@" و",[text7 substringToIndex:[text7 length]],@"میلیون تومان"];
            if ([maxPriceTextField.text isEqualToString:@"1000"]) {
                maxPriceConvertorLabel.text=@"۱ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"2000"]) {
                maxPriceConvertorLabel.text=@"۲ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"3000"]) {
                maxPriceConvertorLabel.text=@"۳ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"4000"]) {
                maxPriceConvertorLabel.text=@"۴ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"5000"]) {
                maxPriceConvertorLabel.text=@"۵ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"6000"]) {
                maxPriceConvertorLabel.text=@"۶ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"7000"]) {
                maxPriceConvertorLabel.text=@"۷ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"8000"]) {
                maxPriceConvertorLabel.text=@"۸ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"9000"]) {
                maxPriceConvertorLabel.text=@"۹ میلیارد تومان";
            }
        }
        if ([maxPriceTextField.text length] == 5){
            NSString*text6=[maxPriceTextField.text substringToIndex:2];
            NSString*text7=[maxPriceTextField.text substringWithRange:(NSMakeRange(2,3))];
            
            if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]) {
                text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]) {
                text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@" و",[text7 substringToIndex:[text7 length]],@"میلیون تومان"];
            if ([maxPriceTextField.text isEqualToString:@"10000"]) {
                maxPriceConvertorLabel.text=@"۱۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"20000"]) {
                maxPriceConvertorLabel.text=@"۲۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"30000"]) {
                maxPriceConvertorLabel.text=@"۳۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"40000"]) {
                maxPriceConvertorLabel.text=@"۴۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"50000"]) {
                maxPriceConvertorLabel.text=@"۵۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"60000"]) {
                maxPriceConvertorLabel.text=@"۶۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"70000"]) {
                maxPriceConvertorLabel.text=@"۷۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"80000"]) {
                maxPriceConvertorLabel.text=@"۸۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"90000"]) {
                maxPriceConvertorLabel.text=@"۹۰ میلیارد تومان";
            }
        }
        if ([maxPriceTextField.text length] == 6){
            NSString*text6=[maxPriceTextField.text substringToIndex:3];
            NSString*text7=[maxPriceTextField.text substringWithRange:(NSMakeRange(3, 3))];
            
            if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]&&![[text7 substringToIndex:3] isEqualToString:@"000"]) {
                text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
            }
            else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]&&![[text7 substringToIndex:3] isEqualToString:@"000"]) {
                text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
            }
            maxPriceConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@" و",[text7 substringToIndex:[text7 length]],@"میلیون تومان"];
            if ([maxPriceTextField.text isEqualToString:@"100000"]) {
                maxPriceConvertorLabel.text=@"۱۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"200000"]) {
                maxPriceConvertorLabel.text=@"۲۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"300000"]) {
                maxPriceConvertorLabel.text=@"۳۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"400000"]) {
                maxPriceConvertorLabel.text=@"۴۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"500000"]) {
                maxPriceConvertorLabel.text=@"۵۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"600000"]) {
                maxPriceConvertorLabel.text=@"۶۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"700000"]) {
                maxPriceConvertorLabel.text=@"۷۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"800000"]) {
                maxPriceConvertorLabel.text=@"۸۰۰ میلیارد تومان";
            }
            if ([maxPriceTextField.text isEqualToString:@"900000"]) {
                maxPriceConvertorLabel.text=@"۹۰۰ میلیارد تومان";
            }
        }
    }
    if ([maxRahnTextField.text length] == 5){
        NSString*text6=[maxRahnTextField.text substringToIndex:2];
        NSString*text7=[maxRahnTextField.text substringWithRange:(NSMakeRange(2,3))];
        if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]) {
            text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]) {
            text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        maxRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@" و",[text7 substringToIndex:[text7 length]],@"میلیون تومان"];
        if ([maxRahnTextField.text isEqualToString:@"10000"]) {
            maxRahnConvertorLabel.text=@"۱۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"20000"]) {
            maxRahnConvertorLabel.text=@"۲۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"30000"]) {
            maxRahnConvertorLabel.text=@"۳۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"40000"]) {
            maxRahnConvertorLabel.text=@"۴۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"50000"]) {
            maxRahnConvertorLabel.text=@"۵۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"60000"]) {
            maxRahnConvertorLabel.text=@"۶۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"70000"]) {
            maxRahnConvertorLabel.text=@"۷۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"80000"]) {
            maxRahnConvertorLabel.text=@"۸۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"90000"]) {
            maxRahnConvertorLabel.text=@"۹۰ میلیارد تومان";
        }
    }
    if ([maxRahnTextField.text length] == 6){
        NSString*text6=[maxRahnTextField.text substringToIndex:3];
        NSString*text7=[maxRahnTextField.text substringWithRange:(NSMakeRange(3, 3))];
        
        if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]&&![[text7 substringToIndex:3] isEqualToString:@"000"]) {
            text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]&&![[text7 substringToIndex:3] isEqualToString:@"000"]) {
            text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        maxRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@" و",[text7 substringToIndex:[text7 length]],@"میلیون تومان"];
        if ([maxRahnTextField.text isEqualToString:@"100000"]) {
            maxRahnConvertorLabel.text=@"۱۰۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"200000"]) {
            maxRahnConvertorLabel.text=@"۲۰۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"300000"]) {
            maxRahnConvertorLabel.text=@"۳۰۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"400000"]) {
            maxRahnConvertorLabel.text=@"۴۰۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"500000"]) {
            maxRahnConvertorLabel.text=@"۵۰۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"600000"]) {
            maxRahnConvertorLabel.text=@"۶۰۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"700000"]) {
            maxRahnConvertorLabel.text=@"۷۰۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"800000"]) {
            maxRahnConvertorLabel.text=@"۸۰۰ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"900000"]) {
            maxRahnConvertorLabel.text=@"۹۰۰ میلیارد تومان";
        }
    }
    if ([maxRahnTextField.text length] == 4){
        NSString*text6=[maxRahnTextField.text substringToIndex:1];
        NSString*text7=[maxRahnTextField.text substringWithRange:(NSMakeRange(1, 3))];
        if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]) {
            text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]) {
            text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        maxRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیارد",@"  و",[text7 substringToIndex:[text7 length]],@"میلیون تومان"];
        
        if ([maxRahnTextField.text isEqualToString:@"1000"]) {
            maxRahnConvertorLabel.text=@"۱ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"2000"]) {
            maxRahnConvertorLabel.text=@"۲ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"3000"]) {
            maxRahnConvertorLabel.text=@"۳ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"4000"]) {
            maxRahnConvertorLabel.text=@"۴ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"5000"]) {
            maxRahnConvertorLabel.text=@"۵ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"6000"]) {
            maxRahnConvertorLabel.text=@"۶ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"7000"]) {
            maxRahnConvertorLabel.text=@"۷ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"8000"]) {
            maxRahnConvertorLabel.text=@"۸ میلیارد تومان";
        }
        if ([maxRahnTextField.text isEqualToString:@"9000"]) {
            maxRahnConvertorLabel.text=@"۹ میلیارد تومان";
        }
    }
    if ([maxRahnTextField.text length] == 1){
        maxRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxRahnTextField.text,@" میلیون تومان"];
    }
    if ([maxRahnTextField.text length] == 2){
        maxRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxRahnTextField.text,@" میلیون تومان"];
    }
    if ([maxRahnTextField.text length] == 3){
        maxRahnConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxRahnTextField.text,@" میلیون تومان"];
    }
    if ([maxEjareTextField.text length] == 9){
        NSString*text6=[maxEjareTextField.text substringToIndex:3];
        NSString*text7=[maxEjareTextField.text substringWithRange:(NSMakeRange(3, 3))];
        NSString*text8=[maxEjareTextField.text substringWithRange:(NSMakeRange(6, 3))];
        
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیون",@" و",[text7 substringToIndex:[text7 length]],@"هزار ",@"و",[text8 substringToIndex:[text8 length]],@"تومان"];
        if ([maxEjareTextField.text isEqualToString:@"100000000"]) {
            maxEjareConvertorLabel.text=@"۱۰۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"200000000"]) {
            maxEjareConvertorLabel.text=@"۲۰۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"300000000"]) {
            maxEjareConvertorLabel.text=@"۳۰۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"400000000"]) {
            maxEjareConvertorLabel.text=@"۴۰۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"500000000"]) {
            maxEjareConvertorLabel.text=@"۵۰۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"600000000"]) {
            maxEjareConvertorLabel.text=@"۶۰۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"700000000"]) {
            maxEjareConvertorLabel.text=@"۷۰۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"800000000"]) {
            maxEjareConvertorLabel.text=@"۸۰۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"900000000"]) {
            maxEjareConvertorLabel.text=@"۹۰۰ میلیون تومان";
        }
    }
    if ([maxEjareTextField.text length] == 8){
        NSString*text6=[maxEjareTextField.text substringToIndex:2];
        NSString*text7=[maxEjareTextField.text substringWithRange:(NSMakeRange(2,3))];
        NSString*text8=[maxEjareTextField.text substringWithRange:(NSMakeRange(5, 3))];
        
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیون",@" و",[text7 substringToIndex:[text7 length]],@"هزار ",@"و",[text8 substringToIndex:[text8 length]],@"تومان"];
        if ([maxEjareTextField.text isEqualToString:@"10000000"]) {
            maxEjareConvertorLabel.text=@"۱۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"20000000"]) {
            maxEjareConvertorLabel.text=@"۲۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"30000000"]) {
            maxEjareConvertorLabel.text=@"۳۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"40000000"]) {
            maxEjareConvertorLabel.text=@"۴۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"50000000"]) {
            maxEjareConvertorLabel.text=@"۵۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"60000000"]) {
            maxEjareConvertorLabel.text=@"۶۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"70000000"]) {
            maxEjareConvertorLabel.text=@"۷۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"80000000"]) {
            maxEjareConvertorLabel.text=@"۸۰ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"90000000"]) {
            maxEjareConvertorLabel.text=@"۹۰ میلیون تومان";
        }
    }
    
    if ([maxEjareTextField.text length] == 7){
        NSString*text6=[maxEjareTextField.text substringToIndex:1];
        NSString*text7=[maxEjareTextField.text substringWithRange:(NSMakeRange(1, 3))];
        NSString*text8=[maxEjareTextField.text substringWithRange:(NSMakeRange(4, 3))];
        
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"میلیون",@" و",[text7 substringToIndex:[text7 length]],@"هزار ",@"و",[text8 substringToIndex:[text8 length]],@"تومان"];
        if ([maxEjareTextField.text isEqualToString:@"1000000"]) {
            maxEjareConvertorLabel.text=@"۱ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"2000000"]) {
            maxEjareConvertorLabel.text=@"۲ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"3000000"]) {
            maxEjareConvertorLabel.text=@"۳ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"4000000"]) {
            maxEjareConvertorLabel.text=@"۴ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"5000000"]) {
            maxEjareConvertorLabel.text=@"۵ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"6000000"]) {
            maxEjareConvertorLabel.text=@"۶ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"7000000"]) {
            maxEjareConvertorLabel.text=@"۷ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"8000000"]) {
            maxEjareConvertorLabel.text=@"۸ میلیون تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"9000000"]) {
            maxEjareConvertorLabel.text=@"۹ میلیون تومان";
        }
    }
    if ([maxEjareTextField.text length] == 6){
        NSString*text6=[maxEjareTextField.text substringToIndex:3];
        NSString*text7=[maxEjareTextField.text substringWithRange:(NSMakeRange(3, 3))];
        
        if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]&&![[text7 substringToIndex:3] isEqualToString:@"000"]) {
            
            text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]&&![[text7 substringToIndex:3] isEqualToString:@"000"]) {
            text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"هزار",@" و",[text7 substringToIndex:[text7 length]],@"تومان"];
        if ([maxEjareTextField.text isEqualToString:@"100000"]) {
            maxEjareConvertorLabel.text=@"۱۰۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"200000"]) {
            maxEjareConvertorLabel.text=@"۲۰۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"300000"]) {
            maxEjareConvertorLabel.text=@"۳۰۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"400000"]) {
            maxEjareConvertorLabel.text=@"۴۰۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"500000"]) {
            maxEjareConvertorLabel.text=@"۵۰۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"600000"]) {
            maxEjareConvertorLabel.text=@"۶۰۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"700000"]) {
            maxEjareConvertorLabel.text=@"۷۰۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"800000"]) {
            maxEjareConvertorLabel.text=@"۸۰۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"900000"]) {
            maxEjareConvertorLabel.text=@"۹۰۰ هزار تومان";
        }
    }
    if ([maxEjareTextField.text length] == 5){
        NSString*text6=[maxEjareTextField.text substringToIndex:2];
        NSString*text7=[maxEjareTextField.text substringWithRange:(NSMakeRange(2, 3))];
        
        if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]) {
            text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]) {
            text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"هزار",@" و",[text7 substringToIndex:[text7 length]],@"تومان"];
        if ([maxEjareTextField.text isEqualToString:@"10000"]) {
            maxEjareConvertorLabel.text=@"۱۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"20000"]) {
            maxEjareConvertorLabel.text=@"۲۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"30000"]) {
            maxEjareConvertorLabel.text=@"۳۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"40000"]) {
            maxEjareConvertorLabel.text=@"۴۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"50000"]) {
            maxEjareConvertorLabel.text=@"۵۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"60000"]) {
            maxEjareConvertorLabel.text=@"۶۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"70000"]) {
            maxEjareConvertorLabel.text=@"۷۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"80000"]) {
            maxEjareConvertorLabel.text=@"۸۰ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"90000"]) {
            maxEjareConvertorLabel.text=@"۹۰ هزار تومان";
        }
    }
    if ([maxEjareTextField.text length] == 4){
        NSString*text6=[maxEjareTextField.text substringToIndex:1];
        NSString*text7=[maxEjareTextField.text substringWithRange:(NSMakeRange(1, 3))];
        
        if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&![[text7 substringToIndex:2] isEqualToString:@"00"]) {
            text7 = [text7 stringByReplacingCharactersInRange:(NSMakeRange(0,1)) withString:@""];
        }
        else if ([[text7 substringToIndex:1] isEqualToString:@"0"]&&[[text7 substringToIndex:2] isEqualToString:@"00"]) {
            text7 = [text7 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[text6 substringToIndex:[text6 length]],@"هزار",@" و",[text7 substringToIndex:[text7 length]],@"تومان"];
        if ([maxEjareTextField.text isEqualToString:@"1000"]) {
            maxEjareConvertorLabel.text=@"۱ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"2000"]) {
            maxEjareConvertorLabel.text=@"۲ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"3000"]) {
            maxEjareConvertorLabel.text=@"۳ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"4000"]) {
            maxEjareConvertorLabel.text=@"۴ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"5000"]) {
            maxEjareConvertorLabel.text=@"۵ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"6000"]) {
            maxEjareConvertorLabel.text=@"۶ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"7000"]) {
            maxEjareConvertorLabel.text=@"۷ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"8000"]) {
            maxEjareConvertorLabel.text=@"۸ هزار تومان";
        }
        if ([maxEjareTextField.text isEqualToString:@"9000"]) {
            maxEjareConvertorLabel.text=@"۹ هزار تومان";
        }
    }
    if ([maxEjareTextField.text length] == 3){
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxEjareTextField.text,@"تومان"];
    }
    if ([maxEjareTextField.text length] == 2){
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxEjareTextField.text,@"تومان"];
    }
    if ([maxEjareTextField.text length] == 1){
        maxEjareConvertorLabel.text=[NSString stringWithFormat:@"%@%@",maxEjareTextField.text,@"تومان"];
    }
}

#pragma mark - PickerView delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if (pickerView==transactionTypePickerView)
    {
        return [transactionTypeArray count];
    }
    if (pickerView==typePickerView) {
        return [typeArray count];
    }
    return NO;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView==transactionTypePickerView) {
        [transactionTypeTextField setText:[transactionTypeArray objectAtIndex:row]];
        NSLog(@"%ld",(long)row);
        //transatctionTypeID = row;
        if ([transactionTypeTextField.text isEqualToString:@"رهن و اجاره"]||[transactionTypeTextField.text isEqualToString:@"اجاره موقت"]) {
            [self showRahnEjareTextFields];
        }else{
            [self HideRahnEjareTextFields];
        }
        //NSLog(@"%@",self.transactionRowStr);
    }
    if (pickerView==typePickerView) {
        [typeTextField setText:[typeArray objectAtIndex:row]];
        NSLog(@"%ld",(long)row);
        //propertyTypeID = row;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView==transactionTypePickerView) {
        return [transactionTypeArray objectAtIndex:row];
    }
    if (pickerView==typePickerView) {
        return [typeArray objectAtIndex:row];
    }
    return 0;
}
#pragma mark - scrollView delegate
//- (void) scrollViewDidScroll:(UIScrollView *)scrollView2{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //[self.view endEditing:true];
//       // [scrollView2 endEditing:true];
//        [self tapAction];
//    });;
//}

#pragma mark - Custom Methods
- (void)scrollViewMaker{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeight - 50)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setScrollsToTop:NO];
    [scrollView setScrollEnabled:YES];
    //scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    //scrollView.contentSize = CGSizeMake(screenWidth, screenHeight +5000);
    
    //    transparentView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeight+1500)];
    //    transparentView.backgroundColor = [UIColor clearColor];
    //    [scrollView addSubview:transparentView];
    
    UILabel *personalInfoLabel = [CustomLabel initLabelWithTitle:@"اطلاعات شخصی" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(20, 15, screenWidth-40, 25)];
    personalInfoLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:personalInfoLabel];
    
    UIImageView *redCircleImage1 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, personalInfoLabel.frame.origin.y+personalInfoLabel.frame.size.height+40, 10,10)];
    [scrollView addSubview: redCircleImage1];
    
    UILabel *nameLabel = [CustomLabel initLabelWithTitle:@"نام مشتری" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, personalInfoLabel.frame.origin.y+personalInfoLabel.frame.size.height+30, 250, 25)];
    [scrollView addSubview:nameLabel];
    
    UIImageView *iconImage1 = [CustomImageView initImageViewWithImage:@"name" withFrame:CGRectMake(30, personalInfoLabel.frame.origin.y+personalInfoLabel.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage1];
    
    nameTextField = [CustomTextField placeHolder:@"نام مشتری" withFrame:CGRectMake(40, nameLabel.frame.origin.y+nameLabel.frame.size.height+10, screenWidth-80, 40)];
    nameTextField.delegate = self;
    //nameTextField.userInteractionEnabled = YES;
    [scrollView addSubview:nameTextField];
    
    UIView *lineView1 =[[UIView alloc]initWithFrame:CGRectMake(50, nameTextField.frame.origin.y+nameTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView1];
    
    UIImageView *redCircleImage2 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, nameTextField.frame.origin.y+nameTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage2];
    
    UILabel *emailLabel = [CustomLabel initLabelWithTitle:@"ایمیل مشتری" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, nameTextField.frame.origin.y+nameTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:emailLabel];
    
    UIImageView *iconImage2 = [CustomImageView initImageViewWithImage:@"name" withFrame:CGRectMake(30, nameTextField.frame.origin.y+nameTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage2];
    
    emailTextField = [CustomTextField placeHolder:@"ایمیل مشتری" withFrame:CGRectMake(40, emailLabel.frame.origin.y+emailLabel.frame.size.height+10, screenWidth-80, 40)];
    emailTextField.delegate = self;
    //emailTextField.userInteractionEnabled = YES;
    emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [scrollView addSubview:emailTextField];
    
    UIView *lineView2 =[[UIView alloc]initWithFrame:CGRectMake(50, emailTextField.frame.origin.y+emailTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView2];
    
    UIImageView *redCircleImage3 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, emailTextField.frame.origin.y+emailTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage3];
    
    UILabel *mobileLabel = [CustomLabel initLabelWithTitle:@"موبایل مشتری" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, emailTextField.frame.origin.y+emailTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:mobileLabel];
    
    UIImageView *iconImage3 = [CustomImageView initImageViewWithImage:@"phone" withFrame:CGRectMake(30, emailTextField.frame.origin.y+emailTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage3];
    
    mobileTextField = [CustomTextField placeHolder:@"موبایل مشتری" withFrame:CGRectMake(40, mobileLabel.frame.origin.y+mobileLabel.frame.size.height+10, screenWidth-80, 40)];
    mobileTextField.delegate = self;
    //mobileTextField.userInteractionEnabled = YES;
    mobileTextField.keyboardType = UIKeyboardTypePhonePad;
    [scrollView addSubview:mobileTextField];
    
    UIView *lineView3 =[[UIView alloc]initWithFrame:CGRectMake(50, mobileTextField.frame.origin.y+mobileTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView3];
    
    UILabel *propertyInfoLabel = [CustomLabel initLabelWithTitle:@"اطلاعات ملک مورد نظر" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(20, mobileTextField.frame.origin.y+mobileTextField.frame.size.height+20, screenWidth-40, 25)];
    propertyInfoLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:propertyInfoLabel];
    
    UIImageView *redCircleImage4 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, propertyInfoLabel.frame.origin.y+propertyInfoLabel.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage4];
    
    UILabel *regionLabel = [CustomLabel initLabelWithTitle:@"منطقه" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, propertyInfoLabel.frame.origin.y+propertyInfoLabel.frame.size.height+30, 250, 25)];
    [scrollView addSubview:regionLabel];
    
    UIImageView *iconImage4 = [CustomImageView initImageViewWithImage:@"location2" withFrame:CGRectMake(30, propertyInfoLabel.frame.origin.y+propertyInfoLabel.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage4];
    
    regionTextField = [CustomTextField placeHolder:@"منطقه" withFrame:CGRectMake(40, regionLabel.frame.origin.y+regionLabel.frame.size.height+10, screenWidth-80, 40)];
    regionTextField.delegate = self;
    //regionTextField.userInteractionEnabled = YES;
    //    if (self.regionStr != nil) {
    //        regionTextField.text = self.regionStr;
    //    }
    [scrollView addSubview:regionTextField];
    
    UIView *lineView4 =[[UIView alloc]initWithFrame:CGRectMake(50, regionTextField.frame.origin.y+regionTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView4];
    
    UIImageView *redCircleImage5 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, regionTextField.frame.origin.y+regionTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage5];
    
    UILabel *typeLabel = [CustomLabel initLabelWithTitle:@"نوع ملک" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, regionTextField.frame.origin.y+regionTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:typeLabel];
    
    UIImageView *iconImage5 = [CustomImageView initImageViewWithImage:@"type2" withFrame:CGRectMake(30, regionTextField.frame.origin.y+regionTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage5];
    
    typeTextField  = [CustomTextField placeHolder:@"نوع ملک" withFrame:CGRectMake(40, typeLabel.frame.origin.y+typeLabel.frame.size.height+10, screenWidth-80, 40)];
    typeTextField.delegate = self;
    typeTextField.inputView = typePickerView;
    //typeTextField.userInteractionEnabled = YES;
    [scrollView addSubview:typeTextField];
    
    UIView *lineView5 =[[UIView alloc]initWithFrame:CGRectMake(50, typeTextField.frame.origin.y+typeTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView5.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView5];
    
    UIImageView *redCircleImage6 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, typeTextField.frame.origin.y+typeTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage6];
    
    UILabel *transactionTypeLabel = [CustomLabel initLabelWithTitle:@"نوع معامله" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, typeTextField.frame.origin.y+typeTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:transactionTypeLabel];
    
    UIImageView *iconImage6 = [CustomImageView initImageViewWithImage:@"realestateinfo" withFrame:CGRectMake(30, typeTextField.frame.origin.y+typeTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage6];
    
    transactionTypeTextField = [CustomTextField placeHolder:@"نوع معامله" withFrame:CGRectMake(40, transactionTypeLabel.frame.origin.y+transactionTypeLabel.frame.size.height+10, screenWidth-80, 40)];
    transactionTypeTextField.delegate = self;
    //transactionTypeTextField.userInteractionEnabled = YES;
    transactionTypeTextField.inputView = transactionTypePickerView;
    [scrollView addSubview:transactionTypeTextField];
    
    UIView *lineView6 =[[UIView alloc]initWithFrame:CGRectMake(50, transactionTypeTextField.frame.origin.y+transactionTypeTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView6.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView6];
    
    UIImageView *redCircleImage7 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, transactionTypeTextField.frame.origin.y+transactionTypeTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage7];
    
    UILabel *minPriceLabel = [CustomLabel initLabelWithTitle:@"کمترین قیمت" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, transactionTypeTextField.frame.origin.y+transactionTypeTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:minPriceLabel];
    
    UILabel *milionMinPriceLabel = [CustomLabel initLabelWithTitle:@"(قیمت برحسب میلیون وارد شود)" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth/2-100, transactionTypeTextField.frame.origin.y+transactionTypeTextField.frame.size.height+30, 100, 25)];
    milionMinPriceLabel.textColor = [UIColor lightGrayColor];
    milionMinPriceLabel.font = FONT_NORMAL(10);
    //milionMinPriceLabel.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:milionMinPriceLabel];
    
    UIImageView *iconImage7 = [CustomImageView initImageViewWithImage:@"price2" withFrame:CGRectMake(30, transactionTypeTextField.frame.origin.y+transactionTypeTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage7];
    
    minPriceTextField = [CustomTextField placeHolder:@"کمترین قیمت" withFrame:CGRectMake(40, minPriceLabel.frame.origin.y+minPriceLabel.frame.size.height+10, screenWidth-80, 40)];
    minPriceTextField.delegate = self;
    [minPriceTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //minPriceTextField.userInteractionEnabled = YES;
    minPriceTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:minPriceTextField];
    
    minPriceConvertorLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(40, minPriceTextField.frame.origin.y+minPriceTextField.frame.size.height+10, screenWidth-80, 20)];
    minPriceConvertorLabel.textColor = [UIColor lightGrayColor];
    minPriceConvertorLabel.font = FONT_NORMAL(10);
    //minPriceConvertorLabel.backgroundColor = [UIColor yellowColor];
    minPriceConvertorLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:minPriceConvertorLabel];
    
    minRahnTextField = [CustomTextField placeHolder:@"رهن" withFrame:CGRectMake(40, minPriceLabel.frame.origin.y+minPriceLabel.frame.size.height+10, screenWidth/2-80, 40)];
    minRahnTextField.delegate = self;
    [minRahnTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //minRahnTextField.userInteractionEnabled = YES;
    minRahnTextField.keyboardType = UIKeyboardTypeNumberPad;
    minRahnTextField.hidden = YES;
    [scrollView addSubview:minRahnTextField];
    
    minRahnConvertorLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(40, minRahnTextField.frame.origin.y+minRahnTextField.frame.size.height+5, screenWidth/2-80, 20)];
    minRahnConvertorLabel.textColor = [UIColor lightGrayColor];
    minRahnConvertorLabel.font = FONT_NORMAL(10);
    //minRahnConvertorLabel.backgroundColor = [UIColor yellowColor];
    minRahnConvertorLabel.textAlignment = NSTextAlignmentCenter;
    minRahnConvertorLabel.hidden = YES;
    [scrollView addSubview:minRahnConvertorLabel];
    
    minEjareTextField = [CustomTextField placeHolder:@"اجاره" withFrame:CGRectMake(screenWidth/2+40, minPriceLabel.frame.origin.y+minPriceLabel.frame.size.height+10, screenWidth/2-80, 40)];
    minEjareTextField.delegate = self;
    [minEjareTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //minEjareTextField.userInteractionEnabled = YES;
    minEjareTextField.keyboardType = UIKeyboardTypeNumberPad;
    minEjareTextField.hidden = YES;
    [scrollView addSubview:minEjareTextField];
    
    minEjareConvertorLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(screenWidth/2+50, minEjareTextField.frame.origin.y+minEjareTextField.frame.size.height+5, screenWidth/2-100, 20)];
    minEjareConvertorLabel.textColor = [UIColor lightGrayColor];
    minEjareConvertorLabel.font = FONT_NORMAL(10);
    //minEjareConvertorLabel.backgroundColor = [UIColor yellowColor];
    minEjareConvertorLabel.textAlignment = NSTextAlignmentCenter;
    minEjareConvertorLabel.hidden = YES;
    [scrollView addSubview:minEjareConvertorLabel];
    
    lineView7 =[[UIView alloc]initWithFrame:CGRectMake(50, minPriceTextField.frame.origin.y+minPriceTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView7.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView7];
    
    lineView12 =[[UIView alloc]initWithFrame:CGRectMake(50, minRahnTextField.frame.origin.y+minRahnTextField.frame.size.height+5, screenWidth/2-100, 1)];
    lineView12.backgroundColor = [UIColor lightGrayColor];
    lineView12.hidden = YES;
    [scrollView addSubview:lineView12];
    
    lineView13 =[[UIView alloc]initWithFrame:CGRectMake(screenWidth/2+50, minEjareTextField.frame.origin.y+minEjareTextField.frame.size.height+5, screenWidth/2-100, 1)];
    lineView13.backgroundColor = [UIColor lightGrayColor];
    lineView13.hidden = YES;
    [scrollView addSubview:lineView13];
    
    UIImageView *redCircleImage8 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, minPriceTextField.frame.origin.y+minPriceTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage8];
    
    UILabel *maxPriceLabel = [CustomLabel initLabelWithTitle:@"بیشترین قیمت" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, minPriceTextField.frame.origin.y+minPriceTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:maxPriceLabel];
    
    UILabel *milionMaxPriceLabel = [CustomLabel initLabelWithTitle:@"(قیمت برحسب میلیون وارد شود)" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth/2-100, minPriceTextField.frame.origin.y+minPriceTextField.frame.size.height+30, 100, 25)];
    milionMaxPriceLabel.textColor = [UIColor lightGrayColor];
    milionMaxPriceLabel.font = FONT_NORMAL(10);
    //milionMaxPriceLabel.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:milionMaxPriceLabel];
    
    UIImageView *iconImage8 = [CustomImageView initImageViewWithImage:@"price2" withFrame:CGRectMake(30, minPriceTextField.frame.origin.y+minPriceTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage8];
    
    maxPriceTextField  = [CustomTextField placeHolder:@"بیشترین قیمت" withFrame:CGRectMake(40, maxPriceLabel.frame.origin.y+maxPriceLabel.frame.size.height+10, screenWidth-80, 40)];
    maxPriceTextField.delegate = self;
    [maxPriceTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //maxPriceTextField.userInteractionEnabled = YES;
    maxPriceTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:maxPriceTextField];
    
    maxPriceConvertorLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(40, maxPriceTextField.frame.origin.y+maxPriceTextField.frame.size.height+10, screenWidth-80, 20)];
    maxPriceConvertorLabel.textColor = [UIColor lightGrayColor];
    maxPriceConvertorLabel.font = FONT_NORMAL(10);
    //maxPriceConvertorLabel.backgroundColor = [UIColor yellowColor];
    maxPriceConvertorLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxPriceConvertorLabel];
    
    maxRahnTextField = [CustomTextField placeHolder:@"رهن" withFrame:CGRectMake(40, maxPriceLabel.frame.origin.y+maxPriceLabel.frame.size.height+10, screenWidth/2-80, 40)];
    maxRahnTextField.delegate = self;
    [maxRahnTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //maxRahnTextField.userInteractionEnabled = YES;
    maxRahnTextField.keyboardType = UIKeyboardTypeNumberPad;
    maxRahnTextField.hidden = YES;
    [scrollView addSubview:maxRahnTextField];
    
    maxRahnConvertorLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(50, maxRahnTextField.frame.origin.y+maxRahnTextField.frame.size.height+5, screenWidth/2-100, 20)];
    maxRahnConvertorLabel.textColor = [UIColor lightGrayColor];
    maxRahnConvertorLabel.font = FONT_NORMAL(10);
    //maxRahnConvertorLabel.backgroundColor = [UIColor yellowColor];
    maxRahnConvertorLabel.textAlignment = NSTextAlignmentCenter;
    maxRahnConvertorLabel.hidden = YES;
    [scrollView addSubview:maxRahnConvertorLabel];
    
    maxEjareTextField = [CustomTextField placeHolder:@"اجاره" withFrame:CGRectMake(screenWidth/2+40, maxPriceLabel.frame.origin.y+maxPriceLabel.frame.size.height+10, screenWidth/2-80, 40)];
    maxEjareTextField.delegate = self;
    [maxEjareTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //maxEjareTextField.userInteractionEnabled = YES;
    maxEjareTextField.keyboardType = UIKeyboardTypeNumberPad;
    maxEjareTextField.hidden = YES;
    [scrollView addSubview:maxEjareTextField];
    
    maxEjareConvertorLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(screenWidth/2+50, maxEjareTextField.frame.origin.y+maxEjareTextField.frame.size.height+5, screenWidth/2-100, 20)];
    maxEjareConvertorLabel.textColor = [UIColor lightGrayColor];
    maxEjareConvertorLabel.font = FONT_NORMAL(10);
    //maxEjareConvertorLabel.backgroundColor = [UIColor yellowColor];
    maxEjareConvertorLabel.textAlignment = NSTextAlignmentCenter;
    maxEjareConvertorLabel.hidden = YES;
    [scrollView addSubview:maxEjareConvertorLabel];
    
    lineView8 =[[UIView alloc]initWithFrame:CGRectMake(50, maxPriceTextField.frame.origin.y+maxPriceTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView8.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView8];
    
    lineView14 =[[UIView alloc]initWithFrame:CGRectMake(50, maxRahnTextField.frame.origin.y+maxRahnTextField.frame.size.height+5, screenWidth/2-100, 1)];
    lineView14.backgroundColor = [UIColor lightGrayColor];
    lineView14.hidden = YES;
    [scrollView addSubview:lineView14];
    
    lineView15 =[[UIView alloc]initWithFrame:CGRectMake(screenWidth/2+50, maxEjareTextField.frame.origin.y+maxEjareTextField.frame.size.height+5, screenWidth/2-100, 1)];
    lineView15.backgroundColor = [UIColor lightGrayColor];
    lineView15.hidden = YES;
    [scrollView addSubview:lineView15];
    
    UIImageView *redCircleImage9 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, maxPriceTextField.frame.origin.y+maxPriceTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage9];
    
    UILabel *minAreaLabel = [CustomLabel initLabelWithTitle:@"متراژ از" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, maxPriceTextField.frame.origin.y+maxPriceTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:minAreaLabel];
    
    UIImageView *iconImage9 = [CustomImageView initImageViewWithImage:@"metrage2" withFrame:CGRectMake(30, maxPriceTextField.frame.origin.y+maxPriceTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage9];
    
    minAreaTextField = [CustomTextField placeHolder:@"متراژ از" withFrame:CGRectMake(40, minAreaLabel.frame.origin.y+minAreaLabel.frame.size.height+10, screenWidth-80, 40)];
    minAreaTextField.delegate = self;
    //minAreaTextField.userInteractionEnabled = YES;
    minAreaTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:minAreaTextField];
    
    UIView *lineView9 =[[UIView alloc]initWithFrame:CGRectMake(50, minAreaTextField.frame.origin.y+minAreaTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView9.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView9];
    
    UIImageView *redCircleImage10 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, minAreaTextField.frame.origin.y+minAreaTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage10];
    
    UILabel *maxAreaLabel = [CustomLabel initLabelWithTitle:@"متراژ تا" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, minAreaTextField.frame.origin.y+minAreaTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:maxAreaLabel];
    
    UIImageView *iconImage10 = [CustomImageView initImageViewWithImage:@"metrage2" withFrame:CGRectMake(30, minAreaTextField.frame.origin.y+minAreaTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage10];
    
    maxAreaTextField = [CustomTextField placeHolder:@"متراژ تا" withFrame:CGRectMake(40, maxAreaLabel.frame.origin.y+maxAreaLabel.frame.size.height+10, screenWidth-80, 40)];
    maxAreaTextField.delegate = self;
    //maxAreaTextField.userInteractionEnabled = YES;
    maxAreaTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:maxAreaTextField];
    
    UIView *lineView10 =[[UIView alloc]initWithFrame:CGRectMake(50, maxAreaTextField.frame.origin.y+maxAreaTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView10.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView10];
    
    UIImageView *redCircleImage11 = [CustomImageView initImageViewWithImage:@"redCircle" withFrame:CGRectMake(screenWidth-30, maxAreaTextField.frame.origin.y+maxAreaTextField.frame.size.height +40, 10,10)];
    [scrollView addSubview: redCircleImage11];
    
    UILabel *descriptionLabel = [CustomLabel initLabelWithTitle:@"توضیحات" withTitleColor:[UIColor blackColor] withFrame:CGRectMake(screenWidth-300, maxAreaTextField.frame.origin.y+maxAreaTextField.frame.size.height+30, 250, 25)];
    [scrollView addSubview:descriptionLabel];
    
    UIImageView *iconImage11 = [CustomImageView initImageViewWithImage:@"location2" withFrame:CGRectMake(30, maxAreaTextField.frame.origin.y+maxAreaTextField.frame.size.height+30, 25,25)];
    [scrollView addSubview: iconImage11];
    
    descriptionTextField = [CustomTextField placeHolder:@"توضیحات" withFrame:CGRectMake(40, descriptionLabel.frame.origin.y+descriptionLabel.frame.size.height+10, screenWidth-80, 40)];
    descriptionTextField.delegate = self;
    //descriptionTextField.backgroundColor = [UIColor redColor];
    //descriptionTextField.userInteractionEnabled = YES;
    [scrollView addSubview:descriptionTextField];
    
    UIView *lineView11 =[[UIView alloc]initWithFrame:CGRectMake(50, descriptionTextField.frame.origin.y+descriptionTextField.frame.size.height+5, screenWidth-100, 1)];
    lineView11.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView11];
    
    sendButton = [[UIButton alloc]initWithFrame:CGRectMake((screenWidth/2)-75,descriptionTextField.frame.origin.y+descriptionTextField.frame.size.height+50 ,150, 40)];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitle:@"ارسال اطلاعات" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    sendButton.titleLabel.font = FONT_NORMAL(17);
    sendButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:150/255.0 alpha:1.0];
    [[sendButton layer] setCornerRadius:10.0f];
    [[sendButton layer] setMasksToBounds:YES];
    [[sendButton layer] setBorderWidth:1.0f];
    [[sendButton layer] setBorderColor:[[UIColor colorWithRed:0/255.0 green:0/255.0 blue:150/255.0 alpha:1.0] CGColor]];
    [scrollView addSubview:sendButton];
    
    scrollView.contentSize = CGSizeMake(screenWidth, screenHeight+1000);
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

//action of back button on view
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//method for dissmiss view after success
-(void) back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) tapAction{
    //    [self.view endEditing:true];
    //    [scrollView endEditing:true];
    transactionTypePickerView.hidden = YES;
    typePickerView.hidden = YES;
    [nameTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    [mobileTextField resignFirstResponder];
    [regionTextField resignFirstResponder];
    [typeTextField resignFirstResponder];
    [transactionTypeTextField resignFirstResponder];
    [minPriceTextField resignFirstResponder];
    [minRahnTextField resignFirstResponder];
    [minEjareTextField resignFirstResponder];
    [maxPriceTextField resignFirstResponder];
    [maxRahnTextField resignFirstResponder];
    [maxEjareTextField resignFirstResponder];
    [minAreaTextField resignFirstResponder];
    [maxAreaTextField resignFirstResponder];
    [descriptionTextField resignFirstResponder];
    tikButton.hidden = NO;
}

-(void)sendButtonAction{
    //    [self.view endEditing:true];
    //    [scrollView endEditing:true];
    //[self tapAction];
    paramsDictionary = [[NSMutableDictionary alloc]init];
    if ([self hasConnectivity]){
        if ([nameTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد نام را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if ([emailTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد ایمیل را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if(![self NSStringIsValidEmail:emailTextField.text]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا ایمیل را صحیح وارد کنید." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        if ([mobileTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد شماره موبایل را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        if ([regionTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد منطقه را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        if ([typeTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد نوع ملک را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        if ([transactionTypeTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد نوع معامله را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        if (minPriceTextField.hidden == NO) {
            if ([minPriceTextField.text length] == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد کمترین قیمت را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
        }else{
            if ([minRahnTextField.text length] == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد کمترین مبلغ رهن را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            if ([minEjareTextField.text length] == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد کمترین مبلغ اجاره را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
        }
        if (maxPriceTextField.hidden == NO) {
            if ([maxPriceTextField.text length] == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد بیشترین قیمت را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
        }else{
            if ([maxRahnTextField.text length] == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد بیشترین مبلغ رهن را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            if ([maxEjareTextField.text length] == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد بیشترین مبلغ اجاره را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
        }
        
        if ([minAreaTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد متراژ را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        if ([maxAreaTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد متراژ را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        if ([descriptionTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد توضیحات را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        [paramsDictionary setObject:nameTextField.text forKey:@"name"];
        [paramsDictionary setObject:emailTextField.text forKey:@"email"];
        [paramsDictionary setObject:mobileTextField.text forKey:@"tel"];
        NSInteger regionid = [regionID integerValue];
        [paramsDictionary setObject:[NSNumber numberWithInteger:regionid] forKey:@"Region"];
        [paramsDictionary setObject:typeTextField.text forKey:@"PropertyType"];
        [paramsDictionary setObject:transactionTypeTextField.text forKey:@"TypeOfTransaction"];
        //[paramsDictionary setObject:[NSNumber numberWithInteger:propertyTypeID] forKey:@"PropertyType"];
        //[paramsDictionary setObject:[NSNumber numberWithInteger:transatctionTypeID] forKey:@"TypeOfTransaction"];
        
        if ([transactionTypeTextField.text isEqualToString:@"رهن و اجاره"]||[transactionTypeTextField.text isEqualToString:@"اجاره موقت"]||[transactionTypeTextField.text isEqualToString:@"رهن"]){
            if ([transactionTypeTextField.text isEqualToString:@"رهن"]) {
                
                NSString *minPriceString = minPriceTextField.text;
                minPriceString = [ReplacerEngToPer replacer2:minPriceString];
                
                NSString*price=[NSString stringWithFormat:@"%@%@",minPriceString,@"000000"];
                if ([minPriceTextField.text isEqualToString:@"0"]) {
                    [paramsDictionary setObject:@"0" forKey:@"minMortgage"];
                }
                [paramsDictionary setObject:price forKey:@"minMortgage"];
            }else{
                NSString *minRahnString = minRahnTextField.text;
                minRahnString = [ReplacerEngToPer replacer2:minRahnString];
                
                NSString*price=[NSString stringWithFormat:@"%@%@",minRahnString,@"000000"];
                if ([minRahnTextField.text isEqualToString:@"0"]) {
                    [paramsDictionary setObject:@"0" forKey:@"minMortgage"];
                }
                [paramsDictionary setObject:price forKey:@"minMortgage"];
                
                NSString *minEjareSting = minEjareTextField.text;
                minEjareSting = [ReplacerEngToPer replacer2:minEjareSting];
                [paramsDictionary setObject:minEjareSting forKey:@"minRent"];
            }
        }else{
            NSString *minPriceString = minPriceTextField.text;
            minPriceString = [ReplacerEngToPer replacer2:minPriceString];
            [paramsDictionary setObject:minPriceString forKey:@"minPrice"];
        }
        
        if ([transactionTypeTextField.text isEqualToString:@"رهن و اجاره"]||[transactionTypeTextField.text isEqualToString:@"اجاره موقت"]||[transactionTypeTextField.text isEqualToString:@"رهن"]){
            if ([transactionTypeTextField.text isEqualToString:@"رهن"]) {
                
                NSString *maxPriceString = maxPriceTextField.text;
                maxPriceString = [ReplacerEngToPer replacer2:maxPriceString];
                
                NSString*price=[NSString stringWithFormat:@"%@%@",maxPriceString,@"000000"];
                if ([maxPriceTextField.text isEqualToString:@"0"]) {
                    [paramsDictionary setObject:@"0" forKey:@"maxMortgage"];
                }
                [paramsDictionary setObject:price forKey:@"maxMortgage"];
            }else{
                NSString *maxRahnString = maxRahnTextField.text;
                maxRahnString = [ReplacerEngToPer replacer2:maxRahnString];
                
                NSString*price=[NSString stringWithFormat:@"%@%@",maxRahnString,@"000000"];
                if ([maxRahnTextField.text isEqualToString:@"0"]) {
                    [paramsDictionary setObject:@"0" forKey:@"maxMortgage"];
                }
                [paramsDictionary setObject:price forKey:@"maxMortgage"];
                
                NSString *maxEjareString = maxEjareTextField.text;
                maxEjareString = [ReplacerEngToPer replacer2:maxEjareString];
                [paramsDictionary setObject:maxEjareString forKey:@"maxRent"];
            }
        }else{
            NSString *maxPriceString = maxPriceTextField.text;
            maxPriceString = [ReplacerEngToPer replacer2:maxPriceString];
            [paramsDictionary setObject:maxPriceString forKey:@"maxPrice"];
        }
        NSString *minAreaString = minAreaTextField.text;
        minAreaString = [ReplacerEngToPer replacer2:minAreaString];
        [paramsDictionary setObject:minAreaString forKey:@"minArea"];
        
        NSString *maxAreaString = maxAreaTextField.text;
        maxAreaString = [ReplacerEngToPer replacer2:maxAreaString];
        [paramsDictionary setObject:maxAreaString forKey:@"maxArea"];
        
        [paramsDictionary setObject:descriptionTextField.text forKey:@"tozihat"];
        //[paramsDictionary setObject:@"" forKey:@"city"];
        //[paramsDictionary setObject:@"" forKey:@"state"];
        [self sendFormInfoToServer];
    }
}

- (void)transactionTypePickerMaker{
    transactionTypePickerView = [[UIPickerView alloc]init];
    transactionTypePickerView.frame = CGRectMake(0, screenHeight - 162, screenWidth, 162);
    transactionTypePickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    transactionTypePickerView.delegate = self;
    //[self.view addSubview:transactionTypePickerView];
    transactionTypePickerView.hidden = YES;
}

- (void)showTransactionTypePickerView{
//        //[self.view endEditing:true];
//        //[scrollView endEditing:true];
//        for (UIView *view in scrollView.subviews) {
//            if ([view isKindOfClass:[UITextField class]]) {
//                UITextField *textfield = (UITextField *)view;
//                if (textfield != transactionTypeTextField) {
//                    [textfield resignFirstResponder];
//                }
//            }
//        }
    //[self tapAction];
    tikButton.hidden = YES;
    transactionTypePickerView.hidden = NO;
//    [UIView animateWithDuration:0.2 animations:^{
//        transactionTypePickerView.alpha = 100.0;
//    }];
}

- (void)typePickerMaker{
    typePickerView = [[UIPickerView alloc]init];
    typePickerView.frame = CGRectMake(0, screenHeight - 162, screenWidth, 162);
    typePickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    typePickerView.delegate = self;
    //[self.view addSubview:typePickerView];
    typePickerView.hidden = YES;
}

- (void)showTypePickerView{
//        //[self.view endEditing:true];
//        //[scrollView endEditing:true];
//        for (UIView *view in scrollView.subviews) {
//            if ([view isKindOfClass:[UITextField class]]) {
//                UITextField *textfield = (UITextField *)view;
//                if (textfield != typeTextField) {
//                    [textfield resignFirstResponder];
//                }
//            }
//        }
    //[self tapAction];
    tikButton.hidden = YES;
    typePickerView.hidden = NO;
//    [UIView animateWithDuration:0.2 animations:^{
//        typePickerView.alpha = 100.0;
//    }];
}

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)showRahnEjareTextFields{
    minPriceTextField.hidden = YES;
    maxPriceTextField.hidden = YES;
    minPriceConvertorLabel.hidden = YES;
    maxPriceConvertorLabel.hidden = YES;
    lineView7.hidden = YES;
    lineView8.hidden = YES;
    minRahnTextField.hidden = NO;
    minRahnConvertorLabel.hidden = NO;
    lineView12.hidden = NO;
    minEjareTextField.hidden = NO;
    minEjareConvertorLabel.hidden = NO;
    lineView13.hidden = NO;
    maxRahnTextField.hidden = NO;
    maxRahnConvertorLabel.hidden = NO;
    lineView14.hidden = NO;
    maxEjareTextField.hidden = NO;
    maxEjareConvertorLabel.hidden = NO;
    lineView15.hidden = NO;
}

- (void)HideRahnEjareTextFields{
    minPriceTextField.hidden = NO;
    maxPriceTextField.hidden = NO;
    minPriceConvertorLabel.hidden = NO;
    maxPriceConvertorLabel.hidden = NO;
    lineView7.hidden = NO;
    lineView8.hidden = NO;
    minRahnTextField.hidden = YES;
    minRahnConvertorLabel.hidden = YES;
    lineView12.hidden = YES;
    minEjareTextField.hidden = YES;
    minEjareConvertorLabel.hidden = YES;
    lineView13.hidden = YES;
    maxRahnTextField.hidden = YES;
    maxRahnConvertorLabel.hidden = YES;
    lineView14.hidden = YES;
    maxEjareTextField.hidden = YES;
    maxEjareConvertorLabel.hidden = YES;
    lineView15.hidden = YES;
}
-(void)tikButtonAction{
    if ([nameTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد نام را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([emailTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد ایمیل را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if(![self NSStringIsValidEmail:emailTextField.text]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا ایمیل را صحیح وارد کنید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if ([mobileTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد شماره موبایل را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if ([regionTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد منطقه را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if ([typeTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد نوع ملک را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if ([transactionTypeTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد نوع معامله را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (minPriceTextField.hidden == NO) {
        if ([minPriceTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد کمترین قیمت را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }else{
        if ([minRahnTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد کمترین مبلغ رهن را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if ([minEjareTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد کمترین مبلغ اجاره را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    if (maxPriceTextField.hidden == NO) {
        if ([maxPriceTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد بیشترین قیمت را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }else{
        if ([maxRahnTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد بیشترین مبلغ رهن را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if ([maxEjareTextField.text length] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد بیشترین مبلغ اجاره را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    
    if ([minAreaTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد متراژ را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if ([maxAreaTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد متراژ را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if ([descriptionTextField.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا فیلد توضیحات را تکمیل نمایید" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
}

#pragma mark  - connection
- (BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0){
                // if target host is not reachable
                return NO;
            }
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0){
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)){
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0){
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN){
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    return NO;
}

- (void)sendFormInfoToServer{
    [SVProgressHUD showWithStatus:@"در حال ارسال اطلاعات"];
    
    [paramsDictionary setObject:channel forKey:@"channel"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL, @"add_request_property"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:paramsDictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        long tempDic = [[(NSDictionary *)responseObject objectForKey:@"status"]longValue];
        
        if (tempDic == 0){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"اطلاعات با موفقیت ذخیره شد." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //[self.navigationController popViewControllerAnimated:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self back];
                });
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else if (tempDic != 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"خطای سرور.لطفا دوباره تلاش کنید." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"خطای سرور.لطفا دوباره تلاش کنید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        //isBusyNow = NO;
    }];
}

@end
