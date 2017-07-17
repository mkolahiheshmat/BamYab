//
//  CustomTextField.m
//  yarima
//
//  Created by Developer on 5/27/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import "CustomTextField.h"
#import "Header.h"

@implementation CustomTextField
+ (UITextField *)placeHolder:(NSString *)placeholder withFrame:(CGRect)frame{
    
//+ (UITextField *)initTextField: placeHolder:(NSString *)placeholder withFrame:(CGRect)frame{
    
    UITextField *customTextField = [[UITextField alloc]initWithFrame:frame];
    customTextField.backgroundColor = [UIColor whiteColor];
    customTextField.text = @"";
    customTextField.placeholder = placeholder;
    customTextField.layer.borderColor = [[UIColor whiteColor] CGColor];
    customTextField.font = FONT_NORMAL(11);
    customTextField.clipsToBounds = YES;
    customTextField.minimumFontSize = 0.5;
    customTextField.adjustsFontSizeToFitWidth = YES;
    customTextField.textAlignment = NSTextAlignmentCenter;
    
    return customTextField;
}
@end
