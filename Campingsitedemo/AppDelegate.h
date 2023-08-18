//
//  AppDelegate.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/5/31.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate>
@property (nonatomic, strong) UIWindow * window;
extern NSString *CampUrl;

@end

