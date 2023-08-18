//
//  personInfoViewController.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/11/30.
//


#import <UIKit/UIKit.h>
#import "UIKit+AFNetworking.h"
#import "MapKit/MapKit.h"
#import <UIKit/UIViewController.h>
#import "CPlistItem.h"
#import "SuccessLoginDelegate.h"
#import "addCommentView.h"
#import "SDCycleScrollView.h"
#import "CPRegisterViewController.h"
#import "RadioButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface personInfoViewController : UIViewController

@property (nonatomic,strong,readwrite) NSString *token;
// 需要主页传入的标记值
@property (nonatomic,assign) NSInteger index;

// delegate 属性
@property (nonatomic, assign) NSObject<SuccessLoginDelegate> *delegate;

@end

NS_ASSUME_NONNULL_END
