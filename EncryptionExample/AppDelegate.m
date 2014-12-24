//
//  AppDelegate.m
//  EncryptionExample
//
//  Created by Michael Yau on 12/23/14.
//  Copyright (c) 2014 michaelyau. All rights reserved.
//

#import "AppDelegate.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Encryption.h"

NSString * const KEYSTRING = @"12345678912345678912345678912345";
NSString * const IVSTRING = @"1234567891234567";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    
    NSDictionary *dictionary = [[NSDictionary alloc]initWithObjects:@[@"Joe Bloggs", @"JoeBloggs@fakemail.com", @"103", @"1"] forKeys:@[@"userName", @"email", @"customerID", @"businessID"]];
    
    NSString *dictionaryString = [self createStringFromDictionary:dictionary];
    
    NSData *data = [dictionaryString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encryptedData = [self encryptData:data];
    NSData *decryptedData = [self decryptData:encryptedData];
    
    
    NSString *encryptedDataString = [encryptedData base64EncodedStringWithOptions:0];
    NSString *decryptedDataString = [[NSString alloc]initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"%@",encryptedDataString);
    NSLog(@"%@",decryptedDataString);
    
    
    return YES;
}

- (NSString*)createStringFromDictionary:(NSDictionary*)dictionary{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
        return 0;
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
}


- (NSData*)encryptData:(NSData*)data{
    
    NSData *encryptedData = [data AES256EncryptWithKeyString:KEYSTRING ivString:IVSTRING];
    
    NSString *encryptedDataString = [encryptedData base64EncodedStringWithOptions:0];
    NSLog(@"%@", encryptedDataString);
    
    return encryptedData;

}


- (NSData*)decryptData:(NSData*)data{
    
    NSData *decryptedData = [data AES256DecryptWithKeyString:KEYSTRING ivString:IVSTRING];
    return decryptedData;
}


@end
