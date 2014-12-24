//
//  NSData+Encryption.m
//  EncryptionExample
//
//  Created by Michael Yau on 12/23/14.
//  Copyright (c) 2014 michaelyau. All rights reserved.
//

#import "NSData+Encryption.h"


@implementation NSData (Encryption)

- (NSData*)AES256EncryptWithKeyString:(NSString*)keyString ivString:(NSString*)ivString {
    char key[kCCKeySizeAES256 + 1];
    bzero(key, sizeof(key));
    
    [keyString getCString:key maxLength:sizeof(key) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];

    size_t bufferSize           = dataLength + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);
    
    
    size_t numBytesEncrypted    = 0;
    const char *iv = [ivString UTF8String];
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          key, kCCKeySizeAES256,iv,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

- (NSData*)AES256DecryptWithKeyString:(NSString*)keyString ivString:(NSString*)ivString{
    char key[kCCKeySizeAES256 + 1];
    bzero(key, sizeof(key));
    
    [keyString getCString:key maxLength:sizeof(key) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize           = dataLength + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);
    
    size_t numBytesDecrypted    = 0;
    
    const char *iv = [ivString UTF8String];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          key, kCCKeySizeAES256,iv,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}


@end
