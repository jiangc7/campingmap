//
//  CPRegisterViewController.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/10/29.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "SuccessLoginDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPRegisterViewController : UIViewController
@property(nonatomic,copy,readwrite) NSString *tokenstring;
@property(nonatomic,copy,readwrite) NSString *username;

// 需要主页传入的标记值
@property (nonatomic,assign) NSInteger index;

// delegate 属性
@property (nonatomic, assign) NSObject<SuccessLoginDelegate> *delegate;
@end

NS_ASSUME_NONNULL_END
