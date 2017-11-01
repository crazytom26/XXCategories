//
//  NSString+Validator.h
//  XXCategories
//
//  Created by xby on 2017/11/1.
//

#import <Foundation/Foundation.h>

@interface NSString (Validator)

///是否是手机号
- (BOOL)isPhoneNumber;
///是否是邮箱
- (BOOL)isEmailAddress;
///是否是大陆身份证号
- (BOOL)isMLCard;
///是否是香港身份证号
- (BOOL)isHKCard;
///是否是澳门身份证号
- (BOOL)isMOCard;
///是否是台湾身份证号
- (BOOL)isTWCard;
///是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字 正则验证成功返回YES, 否则返回NO
- (BOOL)isValidWithMinLength:(NSInteger)minLength
                      maxLength:(NSInteger)maxLength
                containsChinese:(BOOL)containsChinese
                 containsDigtal:(BOOL)containsDigtal
                 containsLetter:(BOOL)containsLetter
         containsOtherCharacter:(NSString *)containsOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;





@end
