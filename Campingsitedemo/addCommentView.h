//
//  addCommentView.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/10/20.
//

#import <UIKit/UIKit.h>
#import "UIKit+AFNetworking.h"
#import "HCSStarRatingView.h"
#import "UIKit+AFNetworking.h"
#import "SuccessLoginDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface addCommentView : UIViewController
@property (nonatomic,strong,readwrite) NSString *campTitle;
@property (nonatomic, strong,readwrite)  UILabel *titlelabel;
@property (nonatomic,strong,readwrite) NSString *campsiteid;
@property (nonatomic,strong,readwrite) NSString *loginid;
@property (nonatomic,strong,readwrite) NSString *token;

// 需要主页传入的标记值
@property (nonatomic,assign) NSInteger index;

// delegate 属性
@property (nonatomic, assign) NSObject<SuccessLoginDelegate> *delegate;

-(BOOL)isRightString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
