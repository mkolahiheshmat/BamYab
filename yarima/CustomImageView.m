//
//  CustomImageView.m
//  yarima
//
//  Created by Developer on 5/27/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView
+ (UIImageView *)initImageViewWithImage:(NSString *)imageName withFrame:(CGRect)frame{
    
    UIImageView * customeImageView = [[UIImageView alloc] initWithFrame:frame];
    customeImageView.image = [UIImage imageNamed:imageName];
    customeImageView.backgroundColor = [UIColor whiteColor];
    customeImageView.contentMode = UIViewContentModeScaleAspectFit;
    customeImageView.userInteractionEnabled = YES;
    
    return customeImageView;
}

@end
