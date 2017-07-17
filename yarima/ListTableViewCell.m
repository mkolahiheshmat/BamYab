//
//  ListTableViewCell.m
//  Yarima App
//
//  Created by sina on 9/9/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import "ListTableViewCell.h"
#import "Header.h"
@implementation ListTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    a=true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    a=true;
}
- (IBAction)Favorite:(id)sender {
    NSString*savestring1=self.IDlabel.text;
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:savestring1 forKey:@"ID"];
    [defualt1 setObject:self.rahnLabel.text forKey:@"Tablerahn"];
    [defualt1 setObject:self.ejareLabel.text forKey:@"Tableejareh"];
    [defualt1 synchronize];
}
- (IBAction)saveid:(id)sender {
    NSString*savestring1=self.IDlabel.text;
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:savestring1 forKey:@"id"];
    [defualt1 synchronize];
    NSString*savestring2=self.nameLabel.text;
    NSUserDefaults*defualt2=[NSUserDefaults standardUserDefaults];
    [defualt2 setObject:savestring2 forKey:@"AName"];
    [defualt2 synchronize];
}
- (IBAction)saveid3:(id)sender {
    NSString*savestring1=self.IDlabel.text;
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:savestring1 forKey:@"id"];
    [defualt1 synchronize];
    NSString*savestring2=self.nameLabel.text;
    NSUserDefaults*defualt2=[NSUserDefaults standardUserDefaults];
    [defualt2 setObject:savestring2 forKey:@"AName"];
    [defualt2 synchronize];
}
- (IBAction)saveid2:(id)sender {
    NSString*savestring1=self.IDlabel.text;
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:savestring1 forKey:@"ID"];
    [defualt1 synchronize];
}
- (IBAction)edit:(id)sender {
    NSUserDefaults*defualt1=[NSUserDefaults standardUserDefaults];
    [defualt1 setObject:@"1" forKey:@"edit"];
    [defualt1 synchronize];
}
@end
