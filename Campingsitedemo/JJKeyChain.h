//
//  JJKeyChain.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/9/15.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#define KEY_TOKEN  @"campingsite.app.token"
#define KEY_USERNAME_PASSWORD  @"campingsite.app.usernamepassword"
 
NS_ASSUME_NONNULL_BEGIN

@interface JJKeyChain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
 
@end


NS_ASSUME_NONNULL_END
