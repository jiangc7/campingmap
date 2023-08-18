//
//  SceneDelegate.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/5/31.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import "TableViewController.h"
#import "detailViewController.h"
#import "setPinController.h"
#import "CPSplashview.h"
#import "CPLoginView.h"
#import "CPlogedViewViewController.h"
#import "CPrentViewController.h"
#import "CPListLoader.h"
#import "CPlistItem.h"

//微信开发者ID
#define WXAPPid @"wx95e3271949cf5f3d"
#define WXAppSecret @"edb1e1e935e5a860ca1425756a80ff96"

@interface SceneDelegate ()<UITabBarControllerDelegate>
@property (nonatomic, readwrite, copy, nullable) UITabBarAppearance *scrollEdgeAppearance UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(15.0));
@property(nonatomic,strong,readwrite) NSString *Token;
@property(nonatomic,strong,readwrite) NSString *imgUrl;
@property(nonatomic,strong,readwrite) UIImage *Image;
@property(nonatomic,strong,readwrite) CPlogedViewViewController *controller4;
@property(nonatomic,strong,readwrite)CPListLoader *listLoader;
@property(nonatomic,strong,readwrite)NSArray *dataArray;
@end

@implementation SceneDelegate



- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    _Pid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Pid"];
    
             UIWindowScene *windowScene = (UIWindowScene *)scene;
             self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
              self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    UITabBarController *tabbarcontroller = [[UITabBarController alloc]init];
    tabbarcontroller.delegate = self;
    
    ViewController *viewcontroller = [[ViewController alloc]init];
    //设置字体大小
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    //Normal
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    //Selected
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateSelected];
    
  //  [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    
    UINavigationController *navigationcontroller = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
    
    
  //  UIViewController *navigationcontroller = [[UIViewController alloc]init];
    navigationcontroller.view.backgroundColor = [UIColor blueColor];
    navigationcontroller.tabBarItem.title = @"地图";
    
    //消除ios15下的首页无tabbar的bug
    if (@available(iOS 15.0, *)) {
               UITabBarAppearance * appearance = [UITabBarAppearance new];
                UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
               // appearance.backgroundImage = [UIImage ];//把毛玻璃View转成Image
                tabbarcontroller.tabBar.scrollEdgeAppearance = appearance;
  

        
    }

    
    TableViewController *controller2 = [[TableViewController alloc]init];
    
    UINavigationController *navigationcontroller2 = [[UINavigationController alloc]initWithRootViewController:controller2];
    navigationcontroller2.tabBarItem.title = @"营地详情";
 
    

    
    
    CPrentViewController *controller3 = [[CPrentViewController alloc]init];
    controller3.view.backgroundColor = [UIColor whiteColor];
    controller3.tabBarItem.title = @"设营地";
    
    _controller4 = [[CPlogedViewViewController alloc]init];
//    CPLoginView *controller4 = [[CPLoginView alloc]init];
    
    _controller4.view.backgroundColor = [UIColor systemBlueColor];
    
    UINavigationController *navigationcontroller4 = [[UINavigationController alloc]initWithRootViewController:_controller4];
    navigationcontroller4.tabBarItem.title = @"我的";
    
    [tabbarcontroller setViewControllers:@[navigationcontroller,navigationcontroller2,controller3,navigationcontroller4]];
    
              [self.window setWindowScene:windowScene];
              [self.window setBackgroundColor:[UIColor redColor]];
              [self.window setRootViewController:tabbarcontroller];
              
              [self.window makeKeyAndVisible];
    
//    [self.window addSubview:({
//        CPSplashview *splashView = [[CPSplashview alloc]initWithFrame:self.window.bounds];
//        splashView;
//    })];
    

}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController

{

    if (tabBarController.selectedIndex==3) {

       // [self requestdata];
        NSLog(@"刷新tab界面");
  //      [tabBarController.viewControllers[3] returnToViewController:1];
        [_controller4 returnToViewController:1];

    }



}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

- (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity {
    [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

//这个是UITabBarController的代理方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    // 判断哪个界面要需要再次点击刷新，这里以第一个VC为例

    return YES;
}


#pragma mark - Private

- (void)showAlert:(NSString *)title message:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];

      
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                                                                      }];
                [alert addAction:defaultAction];
                [currentVC presentViewController:alert animated:YES completion:nil];
    

        
    });
}

-(void) onResp:(BaseResp*)resp{
    NSLog(@"resp %d",resp.errCode);
    
    /*
    enum  WXErrCode {
        WXSuccess           = 0,    成功
        WXErrCodeCommon     = -1,  普通错误类型
        WXErrCodeUserCancel = -2,    用户点击取消并返回
        WXErrCodeSentFail   = -3,   发送失败
        WXErrCodeAuthDeny   = -4,    授权失败
        WXErrCodeUnsupport  = -5,   微信不支持
    };
    */
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
            NSLog(@"******************获得的微信登录授权******************");
                    
                    SendAuthResp *aresp = (SendAuthResp *)resp;
//                    if (aresp.errCode != 0 ) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self showAlert:@"用户状态" message:@"微信授权失败"];
//                        });
//                        return;
//                    }
                    //授权成功获取 OpenId
                    NSString *code = aresp.code;
                     [self getWeiXinOpenId:code];
        }else{ //失败
            NSLog(@"error %@",resp.errStr);
            [self showAlert:@"用户状态" message:@"登录失败"];
 
        }
    }
}

- (void)getWeiXinOpenId:(NSString *)code{
    /*
     appid    是    应用唯一标识，在微信开放平台提交应用审核通过后获得
     secret    是    应用密钥AppSecret，在微信开放平台提交应用审核通过后获得
     code    是    填写第一步获取的code参数
     grant_type    是    填authorization_code
     */
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXAPPid,WXAppSecret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data1 = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (!data1) {
            [self showAlert:@"用户状态" message:@"微信授权失败"];
            return ;
        }
        
        // 授权成功，获取token、openID字典
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"token、openID字典===%@",dic);
        NSString *access_token = dic[@"access_token"];
        NSString *openid= dic[@"openid"];
        
        //         获取微信用户信息
  //      [self getUserInfoWithAccessToken:access_token WithOpenid:openid];
         [self WXLogin:access_token WithOpenid:openid];
        
    });
}


-(void)WXLogin:(NSString *)access_token WithOpenid:(NSString *)openid
{
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/login/v1/wxlogin",CampUrl];
 
 


    NSDictionary *parameters = @{@"pwd":access_token,
                                     @"username":openid};
    NSLog(@"parameters是%@",parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        manager.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
      //  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
  
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];

    [manager POST:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
            NSDictionary *dataArray = [responseObject objectForKey:@"content"];
            
            if(dataArray == nil || [dataArray isKindOfClass:[NSNull class]] || dataArray.count == 0){
                [self showAlert:@"错误" message:@"服务器连接失败"];
                return;
            }
            self->_Token = [dataArray objectForKey:@"token"];
        //    NSString *loginID = [NSString stringWithFormat:@"%@",[dataArray objectForKey:@"id"]];
            NSString *loginID = [dataArray objectForKey:@"id"];
            NSLog(@" Token是 %@",self->_Token);
            
            
            if ([self isBlankString:_Token]){
                    NSLog(@"弹出登陆成功");
                [self showAlert:@"登录情况" message:@"登录成功"];

                       NSLog(@"_index是。。。。。",_index);
             

                       _imgUrl = [dataArray objectForKey:@"avatar"];
                     
                if (_imgUrl) {
                    NSURL *url = [NSURL URLWithString: _imgUrl];// 获取的图片地址
                           NSLog(@"%@", _imgUrl);                  
                    _Image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
                }
                       

           //            _username = [NSString stringWithFormat:@"Camper**%@",[[dataArray objectForKey:@"username"] substringFromIndex:7]];
                       _username = [dataArray objectForKey:@"username"];
                           NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                           [defaults setObject:self->_Token forKey:@"token"];
                           [defaults setObject:_username forKey:@"username"];
                           [defaults setObject:loginID forKey:@"Pid"];
                           [defaults setObject:[dataArray objectForKey:@"userInfoId"] forKey:@"userInfoId"];
                           if(_Image){
                               NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:_Image];
                               [defaults setObject:imageData forKey:@"image"];
                           }
                        
                           [defaults synchronize];
 
                
//找到最顶层的view，然后后退一步
                UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                CPLoginView *currentVC = [self getCurrentVCFrom:rootViewController];
                [currentVC.navigationController popViewControllerAnimated:NO];
                [currentVC.delegate returnToViewController:1];

                
            }else{
                NSLog(@"弹出登陆失败");
                [self showAlert:@"登录情况" message:@"登录失败，注册账号"];
//                self->_alert = [UIAlertController alertControllerWithTitle:@"登录情况"
//                                               message:@"登录失败，注册账号"
//                                               preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                   handler:^(UIAlertAction * action) {
                    
           //         [self.navigationController popViewControllerAnimated:NO];
           //         [self.delegate returnToViewController:2];
                    
//                }];
//
//
//                [self->_alert addAction:defaultAction];
//                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回"
//                style:UIAlertActionStyleCancel handler:nil];
//                [self->_alert addAction:cancelAction];
//                [self presentViewController:self->_alert animated:YES completion:nil];
                
            }
            

          
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败 %@",error);
            [self showAlert:@"登录情况" message:@"连接失败"];
//            self->_alert = [UIAlertController alertControllerWithTitle:@"登录情况"
//                                           message:@"连接失败"
//                                           preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//               handler:^(UIAlertAction * action) {}];
//
//            [self->_alert addAction:defaultAction];
//            [self presentViewController:self->_alert animated:YES completion:nil];
        }];
   
    

}





-(void)getUserInfoWithAccessToken:(NSString *)access_token WithOpenid:(NSString *)openid
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 获取用户信息失败
            if (!data) {
                [self showAlert:@"用户状态" message:@"微信授权失败"];
                return ;
            }
            
            // 获取用户信息字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //用户信息中没有access_token 我将其添加在字典中
            [dic setValue:access_token forKey:@"token"];
            NSLog(@"用户信息字典:===%@",dic);
            //保存改用户信息(我用单例保存)
     //       [GLUserManager shareManager].weiXinIfon = dic;
          //微信返回信息后,会跳到登录页面,添加通知进行其他逻辑操作
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weiChatOK" object:nil];
      //      [self saveUserinfo:dic];
            
        });
        
    });
    
}


- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}

- (BOOL)isBlankString:(NSString *)str {
    NSString *string = str;
    if (string == nil || string == NULL) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    
    return YES;
}



@end
