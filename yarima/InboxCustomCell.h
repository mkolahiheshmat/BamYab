//
//  InboxCustomCell.h
//  yarima
//
//  Created by Developer on 5/22/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

//#define TABLEVIEW_CELL_HEIGHT   90
//#define TABLEVIEW_CELL_HEIGHT_Iphone6   140

@interface InboxCustomCell : UITableViewCell
//@property(nonatomic, retain)UILabel *titleLabel;
@property(nonatomic, retain)UITextView *descriptionText;
@property(nonatomic, retain)UILabel *contentLabel;
@property(nonatomic, retain)UILabel *dateLabel;
@property CGFloat height;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier titleString:(NSString *)titleString;
- (CGFloat)getHeightOfString:(NSString *)labelText;

@end
