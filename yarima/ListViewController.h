//
//  ViewController.h
//  Yarima App
//
//  Created by sina on 9/9/15.
//  Copyright (c) 2015 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import <CoreData/CoreData.h>
#import "Header.h"
@interface ListViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *mainYarima;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UIImageView *cityImg;
@property (strong, nonatomic) IBOutlet UIImageView *addImg;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) IBOutlet UITableView *ListTableView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *yarimalabel;
@property (strong, nonatomic) IBOutlet UILabel *irlabel;
@property (strong, nonatomic) IBOutlet UILabel *titleBtn;
@property (strong, nonatomic) IBOutlet UIButton *addtitleBtn;
@property (strong, nonatomic) IBOutlet UIButton *searchtitleBtn;
@property (strong, nonatomic) IBOutlet UIButton *AddnewBtn;
@property (strong, nonatomic) IBOutlet UIButton *SearchnewBtn;
@property (strong, nonatomic) IBOutlet UIButton *LoginBtn;
@property (strong, nonatomic) IBOutlet UILabel *Loginlbl;
@property (strong, nonatomic) IBOutlet UIButton *Myhomesbtn;
@property (strong, nonatomic) IBOutlet UILabel *Myhomeslbl;

@property (weak, nonatomic) IBOutlet UIButton *inboxButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutUsButton;

@end

