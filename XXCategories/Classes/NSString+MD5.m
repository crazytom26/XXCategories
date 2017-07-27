//
//  NSString+MD5.m
//  Pods
//
//  Created by xby on 2017/7/27.
//
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

///返回该对象的 md5 字符串
- (NSString *)md5String {

    const char *utfString = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(utfString, (unsigned int)strlen(utfString),result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

@end
