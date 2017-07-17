//
//  BJRangeViewController.h
//  yarima
//
//  Created by sina on 2/29/16.
//  Copyright © 2016 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    BJRSWPAudioRecordMode2 = 0,
    BJRSWPAudioSetTrimMode2,
    BJRSWPAudioPlayMode2,
    
} BJRangeSliderWithProgressDisplayMode2;

#define BJRANGESLIDER_THUMB_SIZE 32.0
@interface BJRangeViewController : UIControl{
    
    UIImageView *slider;
    UIImageView *progressImage;
    UIImageView *rangeImage;
    
    UIImageView *leftThumb;
    UIImageView *rightThumb;
    
    CGFloat minValue;
    CGFloat maxValue;
    CGFloat currentProgressValue;
    
    CGFloat leftValue;
    CGFloat rightValue;
}

@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat currentProgressValue;

@property (nonatomic, assign) CGFloat leftValue;
@property (nonatomic, assign) CGFloat rightValue;

@property (nonatomic, assign) BOOL showThumbs;
@property (nonatomic, assign) BOOL showProgress;
@property (nonatomic, assign) BOOL showRange;

- (void)setDisplayMode:(BJRangeSliderWithProgressDisplayMode2)mode;


@end
