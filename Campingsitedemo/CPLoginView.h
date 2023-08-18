//
//  CPLoginView.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/9/9.
//

#import <UIKit/UIKit.h>
#import "SuccessLoginDelegate.h"
#import "addCommentView.h"
#import "SecVerify/SVSDKHyVerify.h"
#import <MOBFoundation/MobSDK+Privacy.h>
#import "WXApi.h"
#import "WXApiObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPLoginView : UIViewController<UIApplicationDelegate, WXApiDelegate>


@property(nonatomic,copy,readwrite) NSString *tokenstring;
@property(nonatomic,copy,readwrite) NSString *username;

// 需要主页传入的标记值
@property (nonatomic,assign) NSInteger index;

// delegate 属性
@property (nonatomic, assign) NSObject<SuccessLoginDelegate> *delegate;


-(void)forgetpasswordclicked:(UIButton*)forgetpassword;
-(BOOL)isBlankString:(NSString *)str;
- (void)showAlert:(NSString *)title message:(NSString *)message;
+ (void)uploadPrivacyPermissionStatus:(BOOL)isAgree onResult:(void (^_Nullable)(BOOL success))handler;
+ (void)preLogin:(nullable SecVerifyResultHander)handler;

@end

NS_ASSUME_NONNULL_END
