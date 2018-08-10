//
//  NSString+Validator.m
//  XXCategories
//
//  Created by xby on 2017/11/1.
//

#import "NSString+Validator.h"

@implementation NSString (Validator)

#pragma mark - private
- (BOOL)isValidWithRegex:(NSString *)regex{
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}
#pragma mark - public
///是否是手机号
- (BOOL)isPhoneNumber {
    
//    NSString *mobileRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
    NSString *mobileRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|16[6]|19[89]|17[01345678]|18[0-9]|14[579])[0-9]{8}$";
    BOOL ret1 = [self isValidWithRegex:mobileRegex];
    return ret1;
}
///是否是邮箱
- (BOOL)isEmailAddress {
    
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidWithRegex:emailRegex];
}
///是否是大陆身份证号
- (BOOL)isMLCard {
    
    NSArray *weightArray = @[@7,@9,@10,@5,@8,@4,@2,@1,@6,@3,@7,@9,@10,@5,@8,@4,@2];
    NSString *reg = @"((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|81|82|91)\\d{4})((((19|20)(([02468][048])|([13579][26]))0229))|((20[0-9][0-9])|(19[0-9][0-9]))((((0[1-9])|(1[0-2]))((0[1-9])|(1\\d)|(2[0-8])))|((((0[1,3-9])|(1[0-2]))(29|30))|(((0[13578])|(1[02]))31))))((\\d{3}(x|X))|(\\d{4}))";
    
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:reg
                                                                     options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *result = [regx firstMatchInString:self options:kNilOptions range:NSMakeRange(0, self.length)];
    if (result) {
        NSInteger sum = 0;
        for (int i = 0; i < 17; i++) {
            
            NSInteger b = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger a = [weightArray[i] integerValue];
            
            sum = a * b + sum;
        }
        NSArray *checkArray = @[@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2"];
        NSInteger mod = sum % 11;
        NSString *idCard = self;
        if ([self containsString:@"x"] || [self containsString:@"X"]) {
            
            idCard = [self stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
        }
        NSString *lastString = [self substringFromIndex:idCard.length - 1];
        NSString *checkString = checkArray[mod];
        if ([lastString isEqualToString:checkString]) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else {
        
        return NO;
    }
}
///是否是香港身份证号
- (BOOL)isHKCard {
    
    NSString *reg = @"^[A-Z]{1,2}[0-9]{6}\\(?[0-9A]\\)?$";
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:reg
                                                                     options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *card = [self stringByReplacingOccurrencesOfString:@"[(|)]" withString:@""];
    NSTextCheckingResult *result = [regx firstMatchInString:self options:kNilOptions range:NSMakeRange(0, card.length)];
    
    if (!result) {
        
        return NO;
    }
    NSInteger sum = 0;
    if (card.length == 9) {
        
        sum = ((int)[[card substringToIndex:1].uppercaseString characterAtIndex:0] - 55) * 9 + ((int)[[card substringWithRange:NSMakeRange(1, 1)].uppercaseString characterAtIndex:0] - 55) * 8;
        card = [card substringWithRange:NSMakeRange(1, 8)];
        
    } else {
        
        sum = 522 + ((int)[[card substringToIndex:1].uppercaseString characterAtIndex:0] - 55) * 8;
    }
    
    NSString *mid = [card substringWithRange:NSMakeRange(1, 6)];
    NSString *end = [card substringWithRange:NSMakeRange(7, 1)];
    NSInteger iflag = 7;
    for (int i = 0; i < mid.length; i++) {
        
        NSInteger c = [[mid substringWithRange:NSMakeRange(i, 1)] integerValue];
        sum = sum + c * iflag;
        iflag--;
    }
    if ([end.uppercaseString isEqualToString:@"A"]) {
        
        sum = sum + 10;
        
    } else {
        
        sum = sum + [end integerValue];
    }
    return sum % 11 == 0;
}
///是否是澳门身份证号
- (BOOL)isMOCard {
    
    NSString *reg = @"^[1|5|7][0-9]{6}\\(?[0-9A-Z]\\)?$";
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:reg
                                                                     options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *card = [self stringByReplacingOccurrencesOfString:@"[(|)]" withString:@""];
    NSTextCheckingResult *result = [regx firstMatchInString:self options:kNilOptions range:NSMakeRange(0, card.length)];
    if (card.length == 8 && result) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}
///是否是台湾身份证号
- (BOOL)isTWCard {
    
    NSString *reg = @"^[a-zA-Z][0-9]{9}$";
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:reg
                                                                     options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *card = [self stringByReplacingOccurrencesOfString:@"[(|)]" withString:@""];
    NSTextCheckingResult *result = [regx firstMatchInString:self options:kNilOptions range:NSMakeRange(0, card.length)];
    if (card.length == 10 && result) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}
///是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字 正则验证成功返回YES, 否则返回NO
- (BOOL)isValidWithMinLength:(NSInteger)minLength
                    maxLength:(NSInteger)maxLength
             containsChinese:(BOOL)containsChinese
              containsDigtal:(BOOL)containsDigtal
              containsLetter:(BOOL)containsLetter
      containsOtherCharacter:(NSString *)containsOtherCharacter
         firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    
    NSString *chinessRegex = containsChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *firstRegex = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLength), @(maxLength)];
    NSString *digtalRegex = containsDigtal ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containsLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", firstRegex, chinessRegex, containsOtherCharacter ? containsOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    return [self isValidWithRegex:regex];
}

@end
