//
//  SceneDelegate.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/5/31.
//

#import <UIKit/UIKit.h>


@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (nonatomic,strong,readwrite) NSString *token;
// 需要主页传入的标记值
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) NSInteger Pid;
@property(nonatomic,copy,readwrite) NSString *tokenstring;
@property(nonatomic,copy,readwrite) NSString *username;


@property (strong, nonatomic) UIWindow * window;

@end

