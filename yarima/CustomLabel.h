//
//  CustomLabel.h
//  yarima
//
//  Created by Developer on 5/27/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel
+ (UILabel *)initLabelWithTitle:(NSString *)title withTitleColor:(UIColor *)titleColor
                     withFrame:(CGRect)frame;
@end
