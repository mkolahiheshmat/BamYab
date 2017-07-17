//
//  Header.h
//  yarima
//
//  Created by sina on 12/23/15.
//  Copyright © 2015 sina. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>

#ifndef Header_h
#define Header_h
#define BaseURL @"http://yarima.ir/Domains/"
#define BaseURL2 @"http://yarima.ir/RealEstates/"
#define BaseURL3 @"http://catalogtest.yarima.co/mobiles/"
#define UDID  [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) // iPhone and  iPod touch style UI
#define IS_IPHONE_5_IOS7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6_IOS7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6P_IOS7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE_4_AND_OLDER_IOS7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0f)

#define channel @"baamyab"

#define IS_IPHONE_5_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) == 568.0f)
#define IS_IPHONE_6_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) == 667.0f)
#define IS_IPHONE_6P_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) == 736.0f)
#define IS_IPHONE_4_AND_OLDER_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) < 568.0f)

#define FONT_LIGHT(s) [UIFont fontWithName:@"Swissra-Normal" size:s]
#define FONT_MEDIUM(s) [UIFont fontWithName:@"Swissra-Normal" size:s]
#define FONT_ULTRALIGHT(s) [UIFont fontWithName:@"Swissra-Normal" size:s]
#define FONT_NORMAL(s) [UIFont fontWithName:@"Swissra-Normal" size:s]
//#define FONT_NORMAL(s) [UIFont fontWithName:@"Swissra-Medium" size:s]
#define FONT_BOLD(s) [UIFont fontWithName:@"Swissra-Normal" size:s]

#define screenWidth  [[UIScreen mainScreen]bounds].size.width
#define screenHeight [[UIScreen mainScreen]bounds].size.height

#define MAIN_COLOR [UIColor colorWithRed:0/255.0 green:172/255.0 blue:193/255.0 alpha:1.0]

#endif /* Header_h */
