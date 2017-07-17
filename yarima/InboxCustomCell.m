//
//  InboxCustomCell.m
//  yarima
//
//  Created by Developer on 5/22/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import "InboxCustomCell.h"
#import "Header.h"

@implementation InboxCustomCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier titleString:(NSString *)titleString{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,5,screenWidth-40,[self getHeightOfString:titleString])];
//        self.titleLabel.font = FONT_NORMAL(15);
//        self.titleLabel.numberOfLines = 0;
//        //self.titleLabel.minimumScaleFactor = 0.7;
//        self.titleLabel.textColor = [UIColor blackColor];
//        //self.titleLabel.backgroundColor = [UIColor yellowColor];
//        self.titleLabel.textAlignment = NSTextAlignmentRight;
//        //self.titleLabel.adjustsFontSizeToFitWidth = YES;
//        //[self.titleLabel sizeToFit];
//        [self addSubview:self.titleLabel];
       self.descriptionText = [[UITextView alloc]initWithFrame:CGRectMake(20,0, screenWidth - 40, [self getHeightOfString:titleString]+50)];
        NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setLineSpacing:10];
        paragraph.alignment = NSTextAlignmentJustified;
        paragraph.baseWritingDirection = NSWritingDirectionRightToLeft;
        paragraph.firstLineHeadIndent = 1.0;
        NSDictionary* attributes = @{
                                     NSForegroundColorAttributeName: [UIColor blackColor],
                                     NSParagraphStyleAttributeName: paragraph,
                                     NSFontAttributeName:FONT_NORMAL(15)
                                     };
        NSAttributedString* aString = [[NSAttributedString alloc] initWithString:titleString attributes: attributes];
        self.descriptionText.attributedText = aString;
        self.descriptionText.editable = NO;
        self.userInteractionEnabled = NO;
        //self.descriptionText.dataDetectorTypes = UIDataDetectorTypeAll;
        [self addSubview:self.descriptionText];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.descriptionText.frame.origin.y+self.descriptionText.frame.size.height+10, screenWidth-40 , 25)];
        self.dateLabel.font = FONT_NORMAL(13);
        self.dateLabel.minimumScaleFactor = 0.7;
        self.dateLabel.textColor = [UIColor blackColor];
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        //self.dateLabel.backgroundColor = [UIColor orangeColor];
        self.dateLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.dateLabel];
    }
    return self;
}
- (CGFloat)getHeightOfString:(NSString *)labelText{
    UIFont *myFont = FONT_MEDIUM(15);
    if (IS_IPHONE_5_IOS7 || IS_IPHONE_5_IOS8 || IS_IPHONE_4_AND_OLDER_IOS7 || IS_IPHONE_4_AND_OLDER_IOS8) {
        myFont = FONT_NORMAL(15);
    }
    if (IS_IPAD) {
        myFont = FONT_NORMAL(22);
    }
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineSpacing:10];
    paragraph.alignment = NSTextAlignmentJustified;
    paragraph.lineHeightMultiple = 1.0;
    paragraph.baseWritingDirection = NSWritingDirectionRightToLeft;
    NSDictionary* attributes = @{
                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                 NSParagraphStyleAttributeName: paragraph,
                                 NSFontAttributeName:FONT_NORMAL(15)
                                 };
    NSString* txt = labelText;
    NSAttributedString* aString = [[NSAttributedString alloc] initWithString: txt attributes: attributes];
    CGSize sizeOfText = [aString boundingRectWithSize:CGSizeMake( screenWidth -40,CGFLOAT_MAX)
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              context:nil].size;
    CGFloat height = sizeOfText.height;
    if (IS_IPHONE_4_AND_OLDER_IOS8)
        height = sizeOfText.height + 10;
    return height;
}

@end
