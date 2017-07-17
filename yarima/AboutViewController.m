//
//  AboutViewController.m
//  yarima
//
//  Created by sina on 12/7/15.
//  Copyright © 2015 sina. All rights reserved.
//

#import "AboutViewController.h"
#import <UIKit/UIKit.h>
#import "Header.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SVProgressHUD.h"
#import "AFHTTPSessionManager.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import "SWRevealViewController.h"
#import "AFHTTPSessionManager.h"
#import "CustomLabel.h"

@interface AboutViewController ()
{
    UIScrollView *scrollView;
    NSString *website;
    NSString *phoneNumber;
    NSString *email;
    NSString *address;
    NSString *telegram;
    NSString *instagram;
    NSString *descriptionText;
    UIScrollView *_scrollView;
    UIView *topView;
    UILabel *titleLabel;
    UIImageView *logoImageView;
    UIButton *websiteButton;
    UIButton *telegramButton;
    UIButton *mailButton;
    UIButton *instagramButton;
    UIButton *callButton;
    UILabel *offlineLabel;
    UILabel *callLabel;
    UILabel *websiteLabel;
    UILabel *mailLabel;
    UILabel *telegramLabel;
    UILabel *instagramLabel;
    UILabel *addressLabel;
    UILabel *addressTextLabel;
}

@end
@implementation AboutViewController

- (void) viewWillAppear:(BOOL)animated{
    
    offlineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, screenWidth-40,  25)];
    offlineLabel.font = FONT_MEDIUM(17);
    offlineLabel.text = @"اتصال به اینترنت برقرار نیست.";
    offlineLabel.minimumScaleFactor = 0.7;
    offlineLabel.textColor = MAIN_COLOR;
    offlineLabel.textAlignment = NSTextAlignmentCenter;
    offlineLabel.adjustsFontSizeToFitWidth = YES;
    offlineLabel.hidden = YES;
    [self.view addSubview:offlineLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuBtn addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    //[scrollView setScrollEnabled:YES];
    //[scrollView setContentSize:CGSizeMake(320, 750)];
    if ([self hasConnectivity]) {
        [self fetchInfo];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"شما در حالت آفلاین هستید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //offlineLabel.hidden = NO;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        NSDictionary *tempDic = [[NSUserDefaults standardUserDefaults]objectForKey:@"InfoDic"];
        if ([tempDic count] > 1) {
            website = [tempDic objectForKey:@"website"];
            email = [tempDic objectForKey:@"email"];
            phoneNumber = [tempDic objectForKey:@"tel"];
            descriptionText = [tempDic objectForKey:@"description"];
            address = [tempDic objectForKey:@"address"];
            //instagram = [tempDic objectForKey:@"instagram"];
            //telegram = [tempDic objectForKey:@"telegram"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self makeScrollView];
            });
        }else{
            NSString *desc1 = @"مطمئن ترین ، سریع ترین و ایمن ترین مسیر دراملاک و مستغلات از بام یاب شروع می شود.\nآرامش خاطر را در مجموعه ما تجربه کنید.\nما مفتخریم با ارائه خدمات خاص و رایگان،آسودگی خاطر شما را به منظور اخذ هرگونه قرارداد برآورده نمائیم";
            NSString *desc2 = @"از جمله خدمات و ویژگی های برجسته میتوان به :\nبانک اطلاعاتی قوی مشاورین حرفه ای کارشناسی و قیمت گذاری بی نظیر\nاپلیکیشن اختصاصی با امکانات بی نظیرجستجوی اتوماتیک ملک برای شما\n از طریق اپلیکیشن اجاره ملک به اشخاص و شرکت های معتبر\nارائه مشاوره صحیح برای مشارکت در ساخت از صفر تا صد \nفراهم آوردن امکان معاوضه ملک شما با ملک دلخواه \nتسهیل فروش انواع املاک کلنگی،ویلایی، مسکونی....\nقرعه کشی هفتگی واهدای جوایز نفیس به اعضای گروه تلگرامی اشاره کرد .";
           NSString *desc3 = @"ضمناً خدمات :\nعکاسی و تصویر برداری از ملک شما\nساخت و تهیه فیلم از تصاویر مربوط به ملک شما\nتبلیغ ملک شما در تلگرام و اپلیکیشن \nتهیه آلبوم های تبلیغاتی حرفه ای برای اعضا\nانجام کلیه کارهای اداری طرفین قرارداد تا روز محضر\nمشاوره حقوقی جهت کارشناسی و نقل و انتقال املاک،به صورت رایگان ارائه میشود";
            descriptionText = [NSString stringWithFormat:@"%@\n%@\n%@" ,desc1,desc2,desc3];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self makeScrollView];
            });
        }
    }
}
#pragma mark- custom

- (void)makeScrollView{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, screenWidth,screenHeight - 50)];
    scrollView.showsVerticalScrollIndicator=YES;
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    [scrollView setScrollEnabled:YES];
    scrollView.delegate = self;
    //scrollView.backgroundColor = [UIColor orangeColor];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:scrollView];
    
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(25,10 , screenWidth-50, [self getHeightOfString:descriptionText])];
    
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
    NSAttributedString* aString = [[NSAttributedString alloc] initWithString:descriptionText attributes: attributes];
    descriptionLabel.attributedText = aString;
    descriptionLabel.numberOfLines = 0;
    [scrollView addSubview:descriptionLabel];
    if (address != nil) {
       addressLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(screenWidth-120, descriptionLabel.frame.origin.y+descriptionLabel.frame.size.height +10, 100,[self getHeightOfString:address])];
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.text = @"آدرس :";
        addressLabel.font = FONT_NORMAL(15);
        addressLabel.numberOfLines = 2;
        //callLabel.backgroundColor = [UIColor yellowColor];
        addressLabel.textAlignment = NSTextAlignmentRight;
        [scrollView addSubview:addressLabel];
        
        addressTextLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(20, descriptionLabel.frame.origin.y+descriptionLabel.frame.size.height +10, screenWidth-120,[self getHeightOfString:address])];
        addressTextLabel.textColor = [UIColor blackColor];
        addressTextLabel.text = address;
        addressTextLabel.font = FONT_NORMAL(15);
        addressTextLabel.numberOfLines = 2;
        //callLabel.backgroundColor = [UIColor yellowColor];
        addressTextLabel.textAlignment = NSTextAlignmentRight;
        [scrollView addSubview:addressTextLabel];
    }
    if (address != nil) {
       logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2-50, addressLabel.frame.origin.y+addressLabel.frame.size.height+50, 100,100)];
    }else{
        logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2-50, descriptionLabel.frame.origin.y+descriptionLabel.frame.size.height+50, 100,100)];
    }
    logoImageView.image = [UIImage imageNamed:@"BamYabLogo"];
    //logoImageView.backgroundColor = MAIN_COLOR;
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    logoImageView.userInteractionEnabled = NO;
    [scrollView addSubview: logoImageView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,logoImageView.frame.origin.y+logoImageView.frame.size.height+40,screenWidth,3)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.userInteractionEnabled = NO;
    [scrollView addSubview:lineView];
    
    callButton = [[UIButton alloc]initWithFrame:CGRectMake(0, logoImageView.frame.origin.y+logoImageView.frame.size.height+45, screenWidth, 60)];
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(callButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //[callButton setTitle:phoneNumber forState:UIControlStateNormal];
    callButton.titleLabel.font = FONT_NORMAL(15);
    callButton.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:callButton];
    
    UIImageView *callImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-60, 7, 45,45)];    callImageView.image = [UIImage imageNamed:@"phone2"];
    callImageView.backgroundColor = [UIColor clearColor];
    callImageView.contentMode = UIViewContentModeScaleAspectFit;
    callImageView.userInteractionEnabled = YES;
    [callButton addSubview: callImageView];
    
    callLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(20, 10, 150, 40)];
    callLabel.textColor = [UIColor blackColor];
    callLabel.text = phoneNumber;
    callLabel.font = FONT_NORMAL(15);
    //callLabel.backgroundColor = [UIColor yellowColor];
    callLabel.textAlignment = NSTextAlignmentCenter;
    [callButton addSubview:callLabel];
    
    if ([phoneNumber length] == 0) {
        CGRect rect = callButton.frame;
        rect.origin.y -= 5;
        rect.size.height = 0;
        [callButton setFrame:rect];
        CGRect rect2 = callImageView.frame;
        rect2.size.height = 0;
        [callImageView setFrame:rect2];
        CGRect rect3 = callLabel.frame;
        rect3.size.height = 0;
        [callLabel setFrame:rect3];
    }
    websiteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, callButton.frame.origin.y+callButton.frame.size.height+10, screenWidth, 60)];
    [websiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [websiteButton addTarget:self action:@selector(websiteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //[websiteButton setTitle:website forState:UIControlStateNormal];
    websiteButton.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:websiteButton];
    
    UIImageView *websiteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-60, 7, 45,45)];
    websiteImageView.image = [UIImage imageNamed:@"web"];
    websiteImageView.backgroundColor = [UIColor clearColor];
    websiteImageView.contentMode = UIViewContentModeScaleAspectFit;
    websiteImageView.userInteractionEnabled = YES;
    [websiteButton addSubview: websiteImageView];
    
    websiteLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(20, 10, 150, 40)];
    websiteLabel.textColor = [UIColor blackColor];
    websiteLabel.font = FONT_NORMAL(15);
    websiteLabel.text = website;
    //websiteLabel.backgroundColor = [UIColor yellowColor];
    websiteLabel.textAlignment = NSTextAlignmentCenter;
    [websiteButton addSubview:websiteLabel];
    
    if ([website length] == 0) {
        CGRect rect = websiteButton.frame;
        rect.origin.y -= 5;
        rect.size.height = 0;
        [websiteButton setFrame:rect];
        CGRect rect2 = websiteImageView.frame;
        rect2.size.height = 0;
        [websiteImageView setFrame:rect2];
        CGRect rect3 = websiteLabel.frame;
        rect3.size.height = 0;
        [websiteLabel setFrame:rect3];
    }
    mailButton = [[UIButton alloc]initWithFrame:CGRectMake(0, websiteButton.frame.origin.y+websiteButton.frame.size.height+10, screenWidth, 60)];
    [mailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [mailButton addTarget:self action:@selector(mailButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //[mailButton setTitle:email forState:UIControlStateNormal];
    mailButton.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:mailButton];
    
    UIImageView *mailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-60, 7, 45,45)]; mailImageView.image = [UIImage imageNamed:@"email_ic"];
    mailImageView.backgroundColor = [UIColor clearColor];
    mailImageView.contentMode = UIViewContentModeScaleAspectFit;
    mailImageView.userInteractionEnabled = YES;
    [mailButton addSubview: mailImageView];
    
    mailLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(20, 10, 150, 40)];
    mailLabel.textColor = [UIColor blackColor];
    mailLabel.font = FONT_NORMAL(15);
    mailLabel.text = email;
    //mailLabel.backgroundColor = [UIColor yellowColor];
    mailLabel.textAlignment = NSTextAlignmentCenter;
    [mailButton addSubview:mailLabel];
    if ([email length] == 0) {
        CGRect rect = mailButton.frame;
        rect.origin.y -= 5;
        rect.size.height = 0;
        [mailButton setFrame:rect];
        CGRect rect2 = mailImageView.frame;
        rect2.size.height = 0;
        [mailImageView setFrame:rect2];
        CGRect rect3 = mailLabel.frame;
        rect3.size.height = 0;
        [mailLabel setFrame:rect3];
    }
    telegramButton= [[UIButton alloc]initWithFrame:CGRectMake(0, mailButton.frame.origin.y+mailButton.frame.size.height+10, screenWidth, 60)];
    [telegramButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [telegramButton addTarget:self action:@selector(telegramButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //[telegramButton setTitle:telegram forState:UIControlStateNormal];
    telegramButton.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:telegramButton];
    
    UIImageView *telegramImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-60, 7, 45,45)];
    telegramImageView.image = [UIImage imageNamed:@"telegram"];
    //telegramImageView.backgroundColor = [UIColor clearColor];
    telegramImageView.backgroundColor = MAIN_COLOR;
    telegramImageView.contentMode = UIViewContentModeScaleAspectFit;
    telegramImageView.userInteractionEnabled = YES;
    telegramImageView.layer.cornerRadius = telegramImageView.frame.size.height/2;
    [telegramButton addSubview: telegramImageView];
    
    telegramLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(20, 10, 150, 40)];
    telegramLabel.textColor = [UIColor blackColor];
    telegramLabel.font = FONT_NORMAL(15);
    //telegramLabel.backgroundColor = [UIColor yellowColor];
    telegramLabel.text = telegram;
    telegramLabel.textAlignment = NSTextAlignmentCenter;
    [telegramButton addSubview:telegramLabel];
    if ([telegram length] == 0) {
        CGRect rect = telegramButton.frame;
        rect.origin.y -= 5;
        rect.size.height = 0;
        [telegramButton setFrame:rect];
        CGRect rect2 = telegramImageView.frame;
        rect2.size.height = 0;
        [telegramImageView setFrame:rect2];
        CGRect rect3 = telegramLabel.frame;
        rect3.size.height = 0;
        [telegramLabel setFrame:rect3];
    }
    instagramButton = [[UIButton alloc]initWithFrame:CGRectMake(0, telegramButton.frame.origin.y+telegramButton.frame.size.height+10, screenWidth, 60)];
    [instagramButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [instagramButton addTarget:self action:@selector(instagramButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [instagramButton setTitle:instagram forState:UIControlStateNormal];
    instagramButton.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:instagramButton];
    
    UIImageView *instagramImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-60, 7, 45,45)];    instagramImageView.image = [UIImage imageNamed:@"instagram"];
    //instagramImageView.backgroundColor = [UIColor clearColor];
    instagramImageView.backgroundColor = MAIN_COLOR;
    instagramImageView.contentMode = UIViewContentModeScaleAspectFit;
    instagramImageView.userInteractionEnabled = YES;
    instagramImageView.layer.cornerRadius = instagramImageView.frame.size.height/2;
    [instagramButton addSubview: instagramImageView];
    
    instagramLabel = [CustomLabel initLabelWithTitle:@"" withTitleColor:[UIColor grayColor] withFrame:CGRectMake(20, 10, 150, 40)];
    instagramLabel.textColor = [UIColor blackColor];
    instagramLabel.font = FONT_NORMAL(15);
    //instagramLabel.backgroundColor = [UIColor yellowColor];
    instagramLabel.text = instagram;
    instagramLabel.textAlignment = NSTextAlignmentCenter;
    [instagramButton addSubview:instagramLabel];
    if ([instagram length] == 0) {
        CGRect rect = instagramButton.frame;
        rect.origin.y -= 5;
        rect.size.height = 0;
        [instagramButton setFrame:rect];
        CGRect rect2 = instagramImageView.frame;
        rect2.size.height = 0;
        [instagramImageView setFrame:rect2];
        CGRect rect3 = instagramLabel.frame;
        rect3.size.height = 0;
        [instagramLabel setFrame:rect3];
    }
    [scrollView setContentSize:CGSizeMake(screenWidth, instagramButton.frame.origin.y+instagramButton.frame.size.height+100)];
}

-(void)backAction{
    //[self.navigationController popViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"backToLanding" sender:self];
}

-(void)websiteButtonAction{
    //    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    webViewViewController *view = (webViewViewController *)[story instantiateViewControllerWithIdentifier:@"webViewViewController"];
    //    view.strURL = website;
    //    view.topViewTitleText = @"وب سایت";
    //    [self.navigationController pushViewController:view animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}

-(void)telegramButtonAction{
    NSString *telegramURL = [NSString stringWithFormat:@"tg://resolve?domain=%@",telegram];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telegramURL]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telegramURL]];
    }else{
        //App not installed.
    }
}

-(void)instagramButtonAction{
    NSString *InstaURL = instagramButton.titleLabel.text;
    InstaURL = [InstaURL stringByReplacingOccurrencesOfString:@"@" withString:@""];
    NSString *completeInstaURL = [NSString stringWithFormat:@"instagram://user?username=%@",InstaURL ];
    NSURL *instagramURL = [NSURL URLWithString:completeInstaURL];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }else{
        // [[UIApplication sharedApplication]openURL:@"http://instagram.com"];
    }
}

-(void)mailButtonAction{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"عنوان ایمیل"];
        [mailViewController setMessageBody:@"متن پیام" isHTML:NO];
        [mailViewController setToRecipients:@[email]];
        [self presentViewController:mailViewController animated:true completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"لطفا ایمیل خود را در تنظیمات گوشی فعال کنید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)callButtonAction{
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"متاسفانه امکان برقراری تماس وجود ندارد." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
    [paragraph setLineSpacing:11];
    paragraph.alignment = NSTextAlignmentJustified;
    paragraph.baseWritingDirection = NSWritingDirectionRightToLeft;
    paragraph.firstLineHeadIndent = 1.0;
    NSDictionary* attributes = @{
                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                 NSParagraphStyleAttributeName: paragraph,
                                 NSFontAttributeName:FONT_NORMAL(15)
                                 };
    NSString* txt = labelText;
    NSAttributedString* aString = [[NSAttributedString alloc] initWithString: txt attributes: attributes];
    CGSize sizeOfText = [aString boundingRectWithSize:CGSizeMake( screenWidth - 50,CGFLOAT_MAX)
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              context:nil].size;
    CGFloat height = sizeOfText.height;
    if (IS_IPHONE_4_AND_OLDER_IOS8)
        height = sizeOfText.height + 10;
    return height;
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Connection
- (BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    return NO;
}

- (void)fetchInfo{
    //[SVProgressHUD showWithStatus:@"در حال دریافت اطلاعات"];
    
    NSDictionary *params = @{
                             @"channel":channel
                             };
    //NSLog(@"params = %@",params);
    /*http://yarima.ir/Domains/about_realestate*/
    NSString *url = [NSString stringWithFormat:@"%@about_realestate", BaseURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
     //   [SVProgressHUD dismiss];
        NSInteger success = [[responseObject objectForKey:@"success"]integerValue];
        if (success == 1) {
            NSDictionary *tempDic = [(NSDictionary *)responseObject objectForKey:@"data"];
            
            [[NSUserDefaults standardUserDefaults]setObject:tempDic forKey:@"InfoDic"];
            email = [tempDic objectForKey:@"email"];
            phoneNumber = [tempDic objectForKey:@"tel"];
            descriptionText = [tempDic objectForKey:@"about"];
            website = [tempDic objectForKey:@"website"];
            address = [tempDic objectForKey:@"address"];
            //instagram = [tempDic objectForKey:@"instagram"];
            //telegram = [tempDic objectForKey:@"telegram"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self makeScrollView];
            });
        }
    }failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"خطای سرور.لطفا دوباره تلاش کنید." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"تایید" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

@end
