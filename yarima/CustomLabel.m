//
//  CustomLabel.m
//  yarima
//
//  Created by Developer on 5/27/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import "CustomLabel.h"
#import "Header.h"

@implementation CustomLabel
+ (UILabel *)initLabelWithTitle:(NSString *)title withTitleColor:(UIColor *)titleColor
                        withFrame:(CGRect)frame{
    UILabel *customLabel = [[UILabel alloc]initWithFrame:frame];
    customLabel.numberOfLines = 1;
    customLabel.font = FONT_NORMAL(13);
    customLabel.minimumScaleFactor = 0.5;
    customLabel.adjustsFontSizeToFitWidth = YES;
    customLabel.text = title;
    customLabel.textColor = titleColor;
    customLabel.textAlignment = NSTextAlignmentRight;
    return customLabel;
}
@end
