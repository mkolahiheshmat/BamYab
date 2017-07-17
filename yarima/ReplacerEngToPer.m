//
//  ReplacerEngToPer.m
//  HafteSobh
//
//  Created by Arash Z. Jahangiri on 18/11/14.
//  Copyright (c) 2014 Arash Z. Jahangiri. All rights reserved.
//

#import "ReplacerEngToPer.h"

@implementation ReplacerEngToPer

+ (NSString *)replacer:(NSString *)tempStr{
    if (![tempStr isEqual:[NSNull null]]){
        NSString *s = tempStr;
        NSCharacterSet *doNotWant1 = [NSCharacterSet characterSetWithCharactersInString:@"1"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant1] componentsJoinedByString: @"۱"];
        NSCharacterSet *doNotWant2 = [NSCharacterSet characterSetWithCharactersInString:@"2"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant2] componentsJoinedByString: @"۲"];
        NSCharacterSet *doNotWant3 = [NSCharacterSet characterSetWithCharactersInString:@"3"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant3] componentsJoinedByString: @"۳"];
        NSCharacterSet *doNotWant4 = [NSCharacterSet characterSetWithCharactersInString:@"4"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant4] componentsJoinedByString: @"۴"];
        NSCharacterSet *doNotWant5 = [NSCharacterSet characterSetWithCharactersInString:@"5"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant5] componentsJoinedByString: @"۵"];
        NSCharacterSet *doNotWant6 = [NSCharacterSet characterSetWithCharactersInString:@"6"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant6] componentsJoinedByString: @"۶"];
        NSCharacterSet *doNotWant7 = [NSCharacterSet characterSetWithCharactersInString:@"7"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant7] componentsJoinedByString: @"۷"];
        NSCharacterSet *doNotWant8 = [NSCharacterSet characterSetWithCharactersInString:@"8"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant8] componentsJoinedByString: @"۸"];
        NSCharacterSet *doNotWant9 = [NSCharacterSet characterSetWithCharactersInString:@"9"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant9] componentsJoinedByString: @"۹"];
        NSCharacterSet *doNotWant0 = [NSCharacterSet characterSetWithCharactersInString:@"0"];
        s = [[s componentsSeparatedByCharactersInSet: doNotWant0] componentsJoinedByString: @"۰"];
        
        tempStr = s;
        return tempStr;
    }
    return tempStr;
}

+ (NSString *)replacer2:(NSString *)tempStr{
    if (![tempStr isEqual:[NSNull null]]) {
        NSString *s = tempStr;
        s = [s stringByReplacingOccurrencesOfString:@"١" withString:@"1"];
        s = [s stringByReplacingOccurrencesOfString:@"٢" withString:@"2"];
        s = [s stringByReplacingOccurrencesOfString:@"٣" withString:@"3"];
        s = [s stringByReplacingOccurrencesOfString:@"٤" withString:@"4"];
        s = [s stringByReplacingOccurrencesOfString:@"٥" withString:@"5"];
        s = [s stringByReplacingOccurrencesOfString:@"٦" withString:@"6"];
        s = [s stringByReplacingOccurrencesOfString:@"٧" withString:@"7"];
        s = [s stringByReplacingOccurrencesOfString:@"٨" withString:@"8"];
        s = [s stringByReplacingOccurrencesOfString:@"٩" withString:@"9"];
        s = [s stringByReplacingOccurrencesOfString:@"٠" withString:@"0"];
        tempStr = s;
        return tempStr;
    }
    return tempStr;
}
@end
