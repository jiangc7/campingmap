//
//  CPlogedViewViewController.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/9/16.
//

#import <UIKit/UIKit.h>
#import "CPLoginView.h"
#import "CPRegisterViewController.h"
#import "SuccessLoginDelegate.h"
#import "personInfoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPlogedViewViewController : UIViewController<SuccessLoginDelegate>
@property(nonatomic,copy,readwrite) NSString *tokenstring;
@property(nonatomic,copy,readwrite) NSString *username;


-(void)forgetpasswordclicked:(UIButton*)forgetpassword;


@end

NS_ASSUME_NONNULL_END
