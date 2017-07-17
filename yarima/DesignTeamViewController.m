//
//  DesignTeamViewController.m
//  yarima
//
//  Created by Developer on 6/20/17.
//  Copyright © 2017 sina. All rights reserved.
//

#import "DesignTeamViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SWRevealViewController.h"
#import "Header.h"

@interface DesignTeamViewController ()<UIGestureRecognizerDelegate,MFMailComposeViewControllerDelegate>
{
    UILabel *titleLabel;
    BOOL isMenuShown;
    UIView *mainView;
    UIView *tranparentView;
    UIScrollView *scrollView;
    UIButton *websiteButton;
    UIButton *mailButton;
    UIButton *instagramButton;
    UIButton *callButton;
}
@end

@implementation DesignTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.MenuButton addTarget:self.revealViewController action:@selector( rightRevealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self makeScrollView];
}

#pragma mark - custom methods

-(void)makeScrollView{
    NSString *answerStr = @"شرکت فناوری اطلاعات و ارتباطات هوشمند یاریما، مفتخر است به یاری حق تعالی و بهره گیری از نیروهای مجرب و با استعداد در سطوح مختلف و همچنین بکارگیری استانداردهای روز جهانی، به این مهم نائل آید که ظرف مدتی کوتاه، میان برترین شرکت های ارائه دهنده خدمات فن آوری اطلاعات و ارتباطات قرار گیرد.این مجموعه می کوشد، با استفاده از تخصص های درونی خود، کسب کار مشتریانش را به عنوان شرکای تجاری خود توسعه دهد و از هیچ کوششی برای اعتلای کسب و کار و موقعیت شرکای تجاری خود دریغ نخواهد نمود.اعتقاد ما بر آن است که آنچه در توان داریم را در جهت اعتلای اهداف مشتریان خود بگماریم تا بواسطه پیشرفت آنها و نزدیکی هرچه بیشتر آنها به اهدافشان ما نیز بتوانیم به اهداف خود نائل آییم. کوشش ما آن است تا به مسائل از نگاه مشتری بنگریم.";
    
    //CGFloat *labelHeight = [self getHeightOfString:answerStr];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, screenWidth,screenHeight-50)];
    scrollView.showsVerticalScrollIndicator=YES;
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(0, 700)];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:scrollView];
    
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(40,30 , screenWidth-80, [self getHeightOfString:answerStr])];
    descLabel.font = FONT_NORMAL(15);
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
    NSString* txt = answerStr;
    NSAttributedString* aString = [[NSAttributedString alloc] initWithString: txt attributes: attributes];
    descLabel.attributedText = aString;
    descLabel.numberOfLines = 0;
    [scrollView addSubview:descLabel];
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2,descLabel.frame.origin.y+descLabel.frame.size.height+20 , screenWidth/2, 25)];
    emailLabel.text = @"ایمیل:";
    emailLabel.font = FONT_NORMAL(12);
    emailLabel.numberOfLines = 2;
    emailLabel.baselineAdjustment = YES;
    emailLabel.adjustsFontSizeToFitWidth = YES;
    emailLabel.minimumScaleFactor = 0.5;
    emailLabel.clipsToBounds = YES;
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.textColor = [UIColor blackColor];
    emailLabel.textAlignment = NSTextAlignmentCenter;
    emailLabel.userInteractionEnabled = YES;
    [scrollView addSubview:emailLabel];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emailTapAction)];
    [emailLabel addGestureRecognizer:tap2];
    
    UILabel *emailDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,descLabel.frame.origin.y+descLabel.frame.size.height+20 , screenWidth/2, 25)];
    emailDescLabel.text = @"info@yarima.co";
    emailDescLabel.font = FONT_NORMAL(12);
    emailDescLabel.numberOfLines = 2;
    emailDescLabel.baselineAdjustment = YES;
    emailDescLabel.adjustsFontSizeToFitWidth = YES;
    emailDescLabel.minimumScaleFactor = 0.5;
    emailDescLabel.clipsToBounds = YES;
    emailDescLabel.backgroundColor = [UIColor clearColor];
    emailDescLabel.textColor = [UIColor blueColor];
    emailDescLabel.textAlignment = NSTextAlignmentCenter;
    emailDescLabel.userInteractionEnabled = YES;
    [scrollView addSubview:emailDescLabel];
    [emailDescLabel addGestureRecognizer:tap2];
    
    UILabel *websiteLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2,emailLabel.frame.origin.y+emailLabel.frame.size.height+5 , screenWidth/2, 25)];
    websiteLabel.text = @"وب سایت:";
    websiteLabel.font = FONT_NORMAL(12);
    websiteLabel.numberOfLines = 2;
    websiteLabel.baselineAdjustment = YES;
    websiteLabel.adjustsFontSizeToFitWidth = YES;
    websiteLabel.minimumScaleFactor = 0.5;
    websiteLabel.clipsToBounds = YES;
    websiteLabel.backgroundColor = [UIColor clearColor];
    websiteLabel.textColor = [UIColor blackColor];
    websiteLabel.textAlignment = NSTextAlignmentCenter;
    websiteLabel.userInteractionEnabled = YES;
    [scrollView addSubview:websiteLabel];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(websiteTapAction)];
    [websiteLabel addGestureRecognizer:tap3];
    
    UILabel *websiteDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,emailLabel.frame.origin.y+emailLabel.frame.size.height+5 , screenWidth/2, 25)];
    websiteDescLabel.text = @"www.yarima.co";
    websiteDescLabel.font = FONT_NORMAL(12);
    websiteDescLabel.numberOfLines = 2;
    websiteDescLabel.baselineAdjustment = YES;
    websiteDescLabel.adjustsFontSizeToFitWidth = YES;
    websiteDescLabel.minimumScaleFactor = 0.5;
    websiteDescLabel.clipsToBounds = YES;
    websiteDescLabel.backgroundColor = [UIColor clearColor];
    websiteDescLabel.textColor = [UIColor blueColor];
    websiteDescLabel.textAlignment = NSTextAlignmentCenter;
    websiteDescLabel.userInteractionEnabled = YES;
    [scrollView addSubview:websiteDescLabel];
    
    [websiteDescLabel addGestureRecognizer:tap3];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2,websiteLabel.frame.origin.y+websiteLabel.frame.size.height+5 , screenWidth/2, 25)];
    phoneLabel.text = @"شماره تماس :";
    phoneLabel.font = FONT_NORMAL(12);
    phoneLabel.numberOfLines = 2;
    phoneLabel.baselineAdjustment = YES;
    phoneLabel.adjustsFontSizeToFitWidth = YES;
    phoneLabel.minimumScaleFactor = 0.5;
    phoneLabel.clipsToBounds = YES;
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.userInteractionEnabled = YES;
    [scrollView addSubview:phoneLabel];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneTapAction)];
    [phoneLabel addGestureRecognizer:tap4];
    
    UILabel *phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,websiteLabel.frame.origin.y+websiteLabel.frame.size.height+5 , screenWidth/2, 25)];
    phoneNumberLabel.text = @"۰۲۱۶۶۱۵۸۷۳۹";
    phoneNumberLabel.font = FONT_NORMAL(12);
    phoneNumberLabel.numberOfLines = 2;
    phoneNumberLabel.baselineAdjustment = YES;
    phoneNumberLabel.adjustsFontSizeToFitWidth = YES;
    phoneNumberLabel.minimumScaleFactor = 0.5;
    phoneNumberLabel.clipsToBounds = YES;
    phoneNumberLabel.backgroundColor = [UIColor clearColor];
    phoneNumberLabel.textColor = [UIColor blueColor];
    phoneNumberLabel.textAlignment = NSTextAlignmentCenter;
    phoneNumberLabel.userInteractionEnabled = YES;
    [scrollView addSubview:phoneNumberLabel];
    [phoneNumberLabel addGestureRecognizer:tap4];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2-100, phoneLabel.frame.origin.y+phoneLabel.frame.size.height+30,200,40)];
    logoImageView.image = [UIImage imageNamed:@"yarimaLogo"];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    logoImageView.userInteractionEnabled = YES;
    logoImageView.layer.cornerRadius = 40 / 2;
    logoImageView.clipsToBounds = YES;
    [scrollView addSubview: logoImageView];
    
    UIView *horizontalLine2 = [[UIView alloc] initWithFrame:CGRectMake(30,logoImageView.frame.origin.y+logoImageView.frame.size.height+25,screenWidth-60,0.8)];
        horizontalLine2.backgroundColor = MAIN_COLOR;
    horizontalLine2.userInteractionEnabled = NO;
    [scrollView addSubview:horizontalLine2];
    
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-30,logoImageView.frame.origin.y+logoImageView.frame.size.height+30 , 60, 30)];
    versionLabel.text = @"نسخه ۱.۰.۰";
    versionLabel.font = FONT_NORMAL(12);
    versionLabel.numberOfLines = 2;
    versionLabel.baselineAdjustment = YES;
    versionLabel.adjustsFontSizeToFitWidth = YES;
    versionLabel.minimumScaleFactor = 0.5;
    versionLabel.clipsToBounds = YES;
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.textColor = [UIColor blackColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:versionLabel];
    
    scrollView.contentSize = CGSizeMake(screenWidth, descLabel.frame.origin.y+descLabel.frame.size.height+300);
}

-(void)websiteTapAction{
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    webViewViewController *view = (webViewViewController *)[story instantiateViewControllerWithIdentifier:@"webViewViewController"];
//    view.strURL = @"www.yarima.co";
//    view.topViewTitleText = @"وب سایت";
//    [self.navigationController pushViewController:view animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.yarima.co"]];
}

-(void)emailTapAction{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"عنوان ایمیل"];
        [mailViewController setMessageBody:@"متن پیام" isHTML:NO];
        [mailViewController setToRecipients:@[@"info@yarima.co"]];
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

-(void)phoneTapAction{
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",@"02166158739"]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"خطا" message:@"امکان برقراری تماس وجود ندارد." preferredStyle:UIAlertControllerStyleAlert];
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
    CGSize sizeOfText = [aString boundingRectWithSize:CGSizeMake( screenWidth - 80,CGFLOAT_MAX)
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              context:nil].size;
    
    CGFloat height = sizeOfText.height;
    if (IS_IPHONE_4_AND_OLDER_IOS8)
        height = sizeOfText.height + 10;
    return height;
}

- (IBAction)backButtonAction:(id)sender {
     //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
