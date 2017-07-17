//
//  CustomTextField.h
//  yarima
//
//  Created by Developer on 5/27/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField <UITextFieldDelegate>
+ (UITextField *)placeHolder:(NSString *)placeholder withFrame:(CGRect)frame;
@end
