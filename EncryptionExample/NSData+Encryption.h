//
//  NSData+Encryption.h
//  EncryptionExample
//
//  Created by Michael Yau on 12/23/14.
//  Copyright (c) 2014 michaelyau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (Encryption)


- (NSData*)AES256EncryptWithKeyString:(NSString*)keyString ivString:(NSString*)ivString;
- (NSData*)AES256DecryptWithKeyString:(NSString*)keyString ivString:(NSString*)ivString;

@end
