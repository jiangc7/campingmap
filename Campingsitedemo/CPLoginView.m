//
//  CPLoginView.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/9/9.
//

#import "CPLoginView.h"
#import  <AFNetworking.h>
#import "AFNetworking.h"
#import "JJKeyChain.h"
#import "CPlogedViewViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>


//#import "SVDSuccessViewController.h"
//#import "SVDSerive.h"
//#import "FLAnimatedImage.h"

//#import "Masonry.h"
//#import "SVDDemoHelper.h"
//#import "SVProgressHUD.h"
//#import "SVDPolicyManager.h"
//#import "SVDLoginViewController.h"
//#import "SVDMobileAuthCommitCodeVC.h"

#import <SecVerify/SVSDKHyVerify.h>
#import <MOBFoundation/MobSDK+Privacy.h>

static NSString * const setCurrentIdentifier = @"setCurrentIdentifier";

@interface CPLoginView ()<WXApiDelegate,ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
@property(nonatomic,strong,readwrite) UIImageView *imageView;
@property(nonatomic,strong,readwrite) NSString *Token;
@property(nonatomic,strong,readwrite) UIAlertController* alert;
@property(nonatomic,strong,readwrite) UITextField *usertextfield;
@property(nonatomic,strong,readwrite) UITextField *passwordtextfield;
@property(nonatomic,strong,readwrite) UILabel *userLabel1;
@property(nonatomic,strong,readwrite) UILabel *userLabel;
@property(nonatomic,strong,readwrite) UIButton *logintouch;
@property(nonatomic,strong,readwrite) UIButton *forgetpassword;
@property(nonatomic,strong,readwrite) UIButton *registertouch;
@property(nonatomic,strong,readwrite) UIButton *wxButton;
@property(nonatomic,strong,readwrite) UIButton *maButton;
@property(nonatomic,strong,readwrite) ASAuthorizationAppleIDButton *appleIDButton;
@property(nonatomic,strong,readwrite) RadioButton *ruleButton;
@property(nonatomic,strong,readwrite) UITextView *textView;
@property(nonatomic,readwrite) int agree;
@end

@implementation CPLoginView

- (void)viewDidLoad {
    /*
         UIImage *firstimage=[UIImage imageNamed:@"camping.jpg"];
        UIImageView *firstiamgeview=[[UIImageView alloc]initWithImage:firstimage];
        [firstiamgeview setFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        [self.view addSubview:firstiamgeview];
    */
//    self.tokenstring = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    NSLog(@"取出的token是%@",self.tokenstring);
//
//  if(self.tokenstring){
//      UINavigationController *nc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//      //变成全屏
//     CPlogedViewViewController *controller1 = [[CPlogedViewViewController alloc]init];
//      [nc pushViewController:controller1 animated:YES];
//
// //     [self dismissViewControllerAnimated:YES completion:nil];
//
//  }
    
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, (self.view.frame.size.width*2/3))];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.image = [UIImage imageNamed:@"camping.JPG"];
    [self.view addSubview:_imageView];
    
           self.view.backgroundColor=[UIColor whiteColor];

        //用户名标签
        int yy = (self.view.frame.size.width*2/3)+10;
        _agree = 0;

     
//     NSMutableDictionary *usernamepasswordKVPairs1 = (NSMutableDictionary *)[JJKeyChain load:KEY_USERNAME_PASSWORD];
    // self.tokenstring = [usernamepasswordKVPairs1 objectForKey:KEY_TOKEN];
  //mob预验证
    [MobSDK uploadPrivacyPermissionStatus:YES onResult:^(BOOL success) { }];
    //mob预登录
    [self startPreLogin];
    
    /*
        //用户名输入框
        self.usertextfield=[[UITextField alloc]initWithFrame:CGRectMake(0, yy,self.view.frame.size.width, 40)];
        self.usertextfield.secureTextEntry=YES;
        self.usertextfield.autocorrectionType=UITextAutocorrectionTypeNo;
        self.usertextfield.clearsOnBeginEditing=YES;
        self.usertextfield.backgroundColor=[UIColor lightGrayColor];
        self.usertextfield.placeholder=@"用户名/手机号";
        self.usertextfield.font=[UIFont fontWithName:@"Arial" size:15];
        self.usertextfield.secureTextEntry = NO;
        //usertextfield.delegate=self;
        [self.view addSubview:self.usertextfield];
        //密码标签

        //密码输入框
        self.passwordtextfield=[[UITextField alloc]initWithFrame:CGRectMake(0, yy+50 , (self.view.frame.size.width), 40)];
    self.passwordtextfield.secureTextEntry=YES;
    self.passwordtextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    self.passwordtextfield.clearsOnBeginEditing=YES;
    self.passwordtextfield.backgroundColor=[UIColor lightGrayColor];
    self.passwordtextfield.placeholder=@"输入密码";
    self.passwordtextfield.secureTextEntry = YES;
    self.passwordtextfield.font=[UIFont fontWithName:@"arial" size:15];
   // self.passwordtextfield addGestureRecognizer:<#(nonnull UIGestureRecognizer *)#>
       // passwordtextfield.delegate=self;
        [self.view addSubview:self.passwordtextfield];
    
    
    //登陆界面的点击登陆按钮
    self.logintouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.logintouch setTitle:@"点击登陆" forState:UIControlStateNormal];
    [self.logintouch setFrame:CGRectMake(100, yy+100, (self.view.frame.size.width-200), 30)];
    [self.logintouch addTarget:self action:@selector(logintouchclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.logintouch.backgroundColor=[UIColor blueColor];
        self.logintouch.enabled = YES;
        self.logintouch.userInteractionEnabled = YES;
    [self.view addSubview:self.logintouch];
    
    //登陆界面的忘记密码按钮
    self.forgetpassword=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.forgetpassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetpassword setFrame:CGRectMake(100, yy+140, (self.view.frame.size.width-200), 30)];
    [self.forgetpassword addTarget:self action:@selector(forgetpasswordclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.forgetpassword.backgroundColor=[UIColor blueColor];
        self.forgetpassword.enabled = YES;
    [self.view addSubview:self.forgetpassword];
    
    
    self.registertouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.registertouch setTitle:@"注册新用户" forState:UIControlStateNormal];
    [self.registertouch setFrame:CGRectMake(100, yy+180, (self.view.frame.size.width-200), 30)];
    [self.registertouch addTarget:self action:@selector(registerclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.registertouch.backgroundColor=[UIColor blueColor];
        self.registertouch.enabled = YES;
    [self.view addSubview:self.registertouch];
     
     */
    //点击屏幕，让键盘退下
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
//     self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        NSLog(@"宽@%",self.view.frame.size.width);
//        NSLog(@"长@%",self.view.frame.size.height);
 //    self.view.userInteractionEnabled = YES;
        
    //微信认证
    if([WXApi isWXAppInstalled]){
        
    _wxButton = [[UIButton alloc] initWithFrame:CGRectMake(80, yy+30, (self.view.frame.size.width-160), 40)];
    _wxButton.tag = 10011;
    [_wxButton setTitle:@"微信登录" forState:UIControlStateNormal];
    
   // _wxButton.enabled = NO;
    _wxButton.backgroundColor=[UIColor systemBlueColor];
    [_wxButton addTarget:self action:@selector(sendAuthRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wxButton];
        
    }
    //mob相关代码

    
    _maButton = [[UIButton alloc] initWithFrame:CGRectMake(80, yy+80, (self.view.frame.size.width-160), 40)];
    _maButton.tag = 10012;
    [_maButton setTitle:@"本机号码登录" forState:UIControlStateNormal];
//    [maButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:0/255.0 green:182/255.0 blue:181/255.0 alpha:1/1.0] withSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.7, 48)withRadius:7]forState:UIControlStateNormal];
//    [maButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:182/255.0 green:182/255.0 blue:181/255.0 alpha:1/1.0] withSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.7, 48) withRadius:7] forState:UIControlStateDisabled];
   // _maButton.enabled = NO;
    _maButton.backgroundColor=[UIColor systemBlueColor];
    [_maButton addTarget:self action:@selector(openAuthPageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_maButton];
    
    //apple登录
    if (@available(iOS 13.0, *)) {
            _appleIDButton = [[ASAuthorizationAppleIDButton alloc] init];
        _appleIDButton.frame = CGRectMake(80, yy+130, (self.view.frame.size.width-160), 40);
       // _appleIDButton.enabled = NO;
            [_appleIDButton addTarget:self action:@selector(appleIDButtonClicked) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:_appleIDButton];
        }
    
//    if (@available(iOS 13.0, *)) {
//            _appleIDButton = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeSignIn style:ASAuthorizationAppleIDButtonStyleWhiteOutline];
//            // 注：根据 Apple 要求,「通过 Apple 登录」按钮的尺寸不得小于 140*30
//        _appleIDButton.frame = CGRectMake(80, yy+130, (self.view.frame.size.width-160), 40);
//            // 该按钮默认有圆角，当然，你也可以自定义圆角尺寸
//            // appleIDButton.cornerRadius = 5;
//        _appleIDButton.backgroundColor = [UIColor systemBlueColor];
//            [_appleIDButton addTarget:self action:@selector(sendAuthRequest) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:_appleIDButton];
//        }
    
    //隐私协议跳转
    
    NSString *str = @"《露营地图用户协议》《隐私协议》";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.campingmap.site/privacy.html"] range:[str rangeOfString:@"《露营地图用户协议》《隐私协议》"]];
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(80, yy+200, (self.view.frame.size.width-100), 30)];
    _textView.attributedText = attrStr;
    _textView.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_textView];
    
    _ruleButton = [[RadioButton alloc]initWithFrame:CGRectMake(80, yy+180, (self.view.frame.size.width-230), 30)];
    [_ruleButton setTitle:@"点击即表示同意" forState:UIControlStateNormal];
   // [_ruleButton setTitle:_textView forState:UIControlStateNormal];
    [_ruleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _ruleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_ruleButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [_ruleButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [_ruleButton setSelected:NO];
    [_ruleButton addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    _ruleButton.lineBreakMode = UILineBreakModeWordWrap;
  //  _ruleButton.numberOfLines = 0;
    [self.view addSubview:_ruleButton];
    
//    UILabel *versionL = [[UILabel alloc]  initWithFrame:CGRectMake(100, yy+150, (self.view.frame.size.width-180), 30)];
//    versionL.text = [NSString stringWithFormat:@"版本号 %@", [SVSDKHyVerify sdkVersion]];
//    versionL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
//    versionL.textColor = [UIColor colorWithRed:184/255.0 green:184/255.0 blue:188/255.0 alpha:1/1.0];
//    [versionL sizeToFit];
//    [self.view addSubview:versionL];
    
 //   [self openAuthPageButtonClick];

    
    // Do any additional setup after loading the view.
}

#pragma mark - 超链接跳转
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    //在这里是可以做一些判定什么的，用来确定对应的操作。
return YES;
}

#pragma mark - 微信登录

-(void)sendAuthRequest
{
    if(_agree == 0){
        [self showAlert:@"请点击同意" message:@"必须同意隐私协议才能登录"];
        return;
    }
    //构造SendAuthReq结构体
    [_wxButton setEnabled:NO];
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [_wxButton setEnabled:YES];
     });
    
    if([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi])
    {
        SendAuthReq* req =[[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req completion:nil];
        
    }else{
        
        [self showAlert:@"微信无法登录" message:@"抱歉您尚未安装微信，或者版本太低"];
    }

    
}




#pragma mark - 预取号

- (void)startPreLogin{
 //   WeakSelf
    
    [SVSDKHyVerify setDebug:YES];
    [SVSDKHyVerify preLogin:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {

   //     [weakSelf enableVerifyBtn:YES];

        if (!error){
            NSLog(@"### 预取号成功: %@", resultDic);
        }else{
            NSLog(@"### 预取号失败%@", error);
        }
    }];
    
}

#pragma mark - 拉起授权页面登录校验

-(void)openAuthPageButtonClick{

    if(_agree == 0){
        [self showAlert:@"请点击同意" message:@"必须同意隐私协议才能登录"];
        return;
    }
  //   * 建议做防止快速点击处理
  //   * eg.
 [_maButton setEnabled:NO];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [_maButton setEnabled:YES];
  });
    


    //1.创建一个ui配置对象
    SVSDKHyUIConfigure * uiConfigure = [[SVSDKHyUIConfigure alloc]init];

    //2.设置currentViewController，必传！请传入当前vc或视图顶层vc，可使用此vc调系统present测试是否可以present其他vc
    uiConfigure.currentViewController = self;

    //3.可选。设置一些定制化属性。eg. 开发者手动控制关闭授权页
    uiConfigure.manualDismiss = @(YES);

 
//     * 4.可选。设置代理，接收相关事件，自定义UI
//     * [SVSDKHyVerify setDelegate:self];
//     * 代理示例：通过代理接收ViewDidLoad事件，并自行设置控件约束或添加自定义控件
//     * -(void)svVerifyAuthPageViewDidLoad:(UIViewController *)authVC userInfo:(SVSDKHyProtocolUserInfo*)userInfo{
//     *   - 基本控件对象和相关信息在userInfo中
//     *   - 可在此处设置基本控件的样式和布局、添加自定义控件等
//     * }
 


    //5.调用拉起授权页方法，传入uiConfigure
    [SVSDKHyVerify openAuthPageWithModel:uiConfigure openAuthPageListener:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {

         
//            * 建议做防止快速点击的处理：
dispatch_async(dispatch_get_main_queue(), ^{
   [_maButton setEnabled:YES];
});
          


            if (error != nil ) {
                //拉起授权页失败
                [self showAlert:@"号码登录报错" message:@"请插入手机SIM卡，并打开蜂窝数据。"];
                NSLog(error.localizedDescription);
            }else{
                //拉起授权页成功
            }

        } cancelAuthPageListener:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {

            //点击了sdk自带返回、关闭、其他方式登录等（添加的自定义关闭按钮事件不会触发此回调）

        } oneKeyLoginListener:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
            //一键登录点击获取token回调：

            //关闭页面。当uiConfigure.manualDismiss = @(YES)时需要手动调用此方法关闭。
            [SVSDKHyVerify finishLoginVcAnimated:YES Completion:^{
                NSLog(@"%s",__func__);
            }];

  //          _strong typeof(weakSelf) strongSelf = weakSelf;

            //判断获取token是否成功
            if (error == nil) {

            
//                 * 获取token成功
//                 * 开始调用token置换手机号接口
//                 * [Tools getMobileByToken:resultDic completion:^(){}]...
                
                NSLog(@"弹出登陆成功");
         
            
                
              
           //     [self showAlert:@"登录情况" message:@"登录成功"];
                NSLog(@"resultDic是%@",resultDic);
            //    NSLog(@"operator是%@",operator);

                [self MobLogin:resultDic];
               
         
             
                   NSLog(@"openAuthPageButtonClick_index是。。。。。",_index);
 //                   [self.navigationController popViewControllerAnimated:NO];
 //                   [self.delegate returnToViewController:_index];
                 
          
           
 
                
       
                
               

                }else{

                    [self showAlert:@"登录情况" message:@"获取token失败"];
//                 * 获取token失败
//                 * 可以自定跳转其他页面
//                 * [self gotoSMSLogin];
//

            }

        }];
}


-(void)MobLogin:(NSDictionary *)resultDic
{
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/login/v1/moblogin",CampUrl];
 //   NSString *urlString = @"http://www.campingmap.site:18081/camping/login/v1/moblogin";
 
  //  NSURL *listURL = [NSURL URLWithString:urlString];
    //save string
    NSString *token1 = [resultDic objectForKey:@"token"];
    NSString *operator = [resultDic objectForKey:@"operator"];
    NSString *opToken = [resultDic objectForKey:@"opToken"];

    NSDictionary *parameters = @{@"pwd":[NSString stringWithFormat:@"%@;%@",token1,opToken],
                                     @"username":operator};
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
                self->_alert = [UIAlertController alertControllerWithTitle:@"登录情况"
                                                   message:@"登录成功"
                                                   preferredStyle:UIAlertControllerStyleAlert];
                
                    
                  

                _username = [dataArray objectForKey:@"username"];
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setObject:self->_Token forKey:@"token"];
                    [defaults setObject:_username forKey:@"username"];
                    [defaults setObject:loginID forKey:@"Pid"];
                    [defaults setObject:[dataArray objectForKey:@"userInfoId"] forKey:@"userInfoId"];
                    [defaults synchronize];
                
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                       NSLog(@"_index是。。。。。",_index);
                     
                     [self.navigationController popViewControllerAnimated:NO];
                     [self.delegate returnToViewController:_index];
//
                    
                     
                   }];
                
                [self->_alert addAction:okAction];
                [self presentViewController:self->_alert animated:YES completion:nil];
         //       [self dismissViewControllerAnimated:true completion:NULL];

//                NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
//                [usernamepasswordKVPairs setObject:self->_Token forKey:KEY_TOKEN];
//                [JJKeyChain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];

                
              //  [self.view setNeedsLayout];
//                [self viewDidLoad];
//                [self viewWillAppear:YES];
            
                
                
                
                
                
            }else{
                NSLog(@"弹出登陆失败");
                self->_alert = [UIAlertController alertControllerWithTitle:@"登录情况"
                                               message:@"登录失败，注册账号"
                                               preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                   handler:^(UIAlertAction * action) {
                    
                    [self.navigationController popViewControllerAnimated:NO];
                    [self.delegate returnToViewController:2];
                    
                }];
                
                 
                [self->_alert addAction:defaultAction];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回"
                style:UIAlertActionStyleCancel handler:nil];
                [self->_alert addAction:cancelAction];
                [self presentViewController:self->_alert animated:YES completion:nil];
                
            }
            

          
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败 %@",error);
            self->_alert = [UIAlertController alertControllerWithTitle:@"登录情况"
                                           message:@"连接失败"
                                           preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
               handler:^(UIAlertAction * action) {}];
             
            [self->_alert addAction:defaultAction];
            [self presentViewController:self->_alert animated:YES completion:nil];
        }];
   
    
    

}



-(void)logintouchclicked:(UIButton*)logintouch
{//登陆跳转到主界面按钮
    NSLog(@"登录开始");
    
    if([[self.passwordtextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] >5){
        
    NSString *username = self.usertextfield.text;
    NSString *password = self.passwordtextfield.text;
    
        extern NSString *CampUrl;
        NSString *urlString = [NSString stringWithFormat:@"%@/camping/login/v1/login",CampUrl];
 //     NSString *urlString = @"http://www.campingmap.site:18081/camping/login/v1/login";
 
  //  NSURL *listURL = [NSURL URLWithString:urlString];

    NSDictionary *parameters = @{   @"pwd":password,
                                     @"username": username};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        manager.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
  
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];

    [manager POST:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
            NSDictionary *dataArray = [responseObject objectForKey:@"content"];
            self->_Token = [dataArray objectForKey:@"token"];
        //    NSString *loginID = [NSString stringWithFormat:@"%@",[dataArray objectForKey:@"id"]];
            NSString *loginID = [dataArray objectForKey:@"id"];
            NSLog(@" Token是 %@",self->_Token);
            
            
            if ([self isBlankString:_Token]){
                    NSLog(@"弹出登陆成功");
                self->_alert = [UIAlertController alertControllerWithTitle:@"登录情况"
                                                   message:@"登录成功"
                                                   preferredStyle:UIAlertControllerStyleAlert];
                
                    
                  
                    //在cookie中设置用户内容
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setObject:self->_Token forKey:@"token"];
                    [defaults setObject:username forKey:@"username"];
                    [defaults setObject:loginID forKey:@"Pid"];
                    [defaults synchronize];
                
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                       NSLog(@"_index是。。。。。",_index);
                     
                     [self.navigationController popViewControllerAnimated:NO];
                     [self.delegate returnToViewController:_index];
//                     
                     
                     
                   }];
                
                [self->_alert addAction:okAction];
                [self presentViewController:self->_alert animated:YES completion:nil];
         //       [self dismissViewControllerAnimated:true completion:NULL];

//                NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
//                [usernamepasswordKVPairs setObject:self->_Token forKey:KEY_TOKEN];
//                [JJKeyChain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];

                
              //  [self.view setNeedsLayout];
//                [self viewDidLoad];
//                [self viewWillAppear:YES];
            
                
                
                
                
                
            }else{
                NSLog(@"弹出登陆失败");
                self->_alert = [UIAlertController alertControllerWithTitle:@"登录情况"
                                               message:@"登录失败，注册账号"
                                               preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                   handler:^(UIAlertAction * action) {
                    
                    [self.navigationController popViewControllerAnimated:NO];
                    [self.delegate returnToViewController:2];
                    
                }];
                
                 
                [self->_alert addAction:defaultAction];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回"
                style:UIAlertActionStyleCancel handler:nil];
                [self->_alert addAction:cancelAction];
                [self presentViewController:self->_alert animated:YES completion:nil];
                
            }
            

          
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败 %@",error);
            self->_alert = [UIAlertController alertControllerWithTitle:@"登录情况"
                                           message:@"连接失败"
                                           preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
               handler:^(UIAlertAction * action) {}];
             
            [self->_alert addAction:defaultAction];
            [self presentViewController:self->_alert animated:YES completion:nil];
        }];
   
    }else{
        [self showAlert:@"提示" message:@"密码不能少于5个字"];
        
    }
        

        

    
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


-(void)forgetpasswordclicked:(UIButton*)forgetpassword
{   //忘记密码跳转按钮
    
}

-(void)registerclicked:(UIButton*)forgetpassword
{   //忘记密码跳转按钮
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate returnToViewController:2];
    
}

-(void)logoutclicked:(UIButton*)logoutButton
{   //登出
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"id"];
   
}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    // Lets handle ValueChanged event only for selected button, and ignore for deselected
    if(sender.selected) {
//        _wxButton.enabled = YES;
//        _maButton.enabled = YES;
//        _appleIDButton.enabled = YES;
        _agree = 1;
        
    }
}

#pragma mark - Private
-(void)wxLoginButtonTouchUpInside:(id)sender
{
    NSLog(@"微信登录");
    if([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi])
    {
        SendAuthReq *request = [[SendAuthReq alloc]init];
        request.state = @"campingmap demo1";
        request.scope = @"test";
        [WXApi sendReq:request completion:^(BOOL success) {
            
        }];
        
    }else{
        
        [self showAlert:@"微信无法登录" message:@"抱歉您尚未安装微信，或者版本太低"];
    }
}

#pragma mark - apple登录
- (void)appleIDButtonClicked API_AVAILABLE(ios(13.0)) {
    if(_agree == 0){
        [self showAlert:@"请点击同意" message:@"必须同意隐私协议才能登录"];
        return;
    }
    //基于用户的Apple ID授权用户，生成用户授权请求的一种机制
    ASAuthorizationAppleIDProvider *provide = [[ASAuthorizationAppleIDProvider alloc] init];
    //创建新的AppleID 授权请求
    ASAuthorizationAppleIDRequest *request = provide.createRequest;
    //在用户授权期间请求的联系信息
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    //由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
    ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    //设置授权控制器通知授权请求的成功与失败的代理
    controller.delegate = self;
    //设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
    controller.presentationContextProvider = self;
    //在控制器初始化期间启动授权流
    [controller performRequests];
}

#pragma mark - ASAuthorizationControllerDelegate
//授权成功的回调
/**
 当授权成功后，我们可以通过这个拿到用户的 userID、email、fullName、authorizationCode、identityToken 以及 realUserStatus 等信息。
 */
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        
        //苹果用户唯一标识符，该值在同一个开发者账号下的所有 App 下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起来。
        NSString *userId = credential.user;
        NSString *state = credential.state;
        NSPersonNameComponents *fullName = credential.fullName;
        //苹果用户信息，邮箱
        NSString *email = credential.email;
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; // refresh token
        /**
         验证数据，用于传给开发者后台服务器，然后开发者服务器再向苹果的身份验证服务端验证本次授权登录请求数据的有效性和真实性，详见 Sign In with Apple REST API。如果验证成功，可以根据 userIdentifier 判断账号是否已存在，若存在，则返回自己账号系统的登录态，若不存在，则创建一个新的账号，并返回对应的登录态给 App。
         */
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        /**
         用于判断当前登录的苹果账号是否是一个真实用户
         取值有：unsupported、unknown、likelyReal。
         */
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        // 存储userId到keychain中，代码省略
        
        //访问后台服务器，返回username和token
        extern NSString *CampUrl;
        NSString *urlString = [NSString stringWithFormat:@"%@/camping/login/v1/appleLogin",CampUrl];
     
     
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:userId];
        NSMutableString* str1=[[NSMutableString alloc] initWithFormat:authorizationCode];
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*=_+.）\\|~(＜＞$%^&*)_ "];
        userId = [[str componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
        authorizationCode = [[str1 componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];

        NSDictionary *parameters = @{@"pwd":authorizationCode,
                                         @"username":userId};
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
                
//                if(dataArray == nil || [dataArray isKindOfClass:[NSNull class]] || dataArray.count == 0){
//                    [self showAlert:@"错误" message:@"服务器连接失败"];
//                    return;
//                }
                self->_Token = [dataArray objectForKey:@"token"];
            //    NSString *loginID = [NSString stringWithFormat:@"%@",[dataArray objectForKey:@"id"]];
                NSString *loginID = [dataArray objectForKey:@"id"];
                NSLog(@" Token是 %@",self->_Token);
                
                
                if ([self isBlankString:_Token]){
                        NSLog(@"弹出登陆成功");
                    [self showAlert:@"登录情况" message:@"登录成功"];

                           NSLog(@"_index是。。。。。",_index);
                 

//                           _imgUrl = [dataArray objectForKey:@"avatar"];
//
//                    if (!_imgUrl) {
//                        NSURL *url = [NSURL URLWithString: _imgUrl];// 获取的图片地址
//                               NSLog(@"%@", _imgUrl);
//                        _Image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
//                    }
//

               //            _username = [NSString stringWithFormat:@"Camper**%@",[[dataArray objectForKey:@"username"] substringFromIndex:7]];
                           _username = [dataArray objectForKey:@"username"];
                               NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                               [defaults setObject:self->_Token forKey:@"token"];
                               [defaults setObject:_username forKey:@"username"];
                               [defaults setObject:loginID forKey:@"Pid"];
                               [defaults setObject:[dataArray objectForKey:@"userInfoId"] forKey:@"userInfoId"];
//                               if(_Image){
//                                   NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:_Image];
//                                   [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"image"];
//                               }
//
                               [defaults synchronize];
     
                    
                    NSLog(@"_index是。。。。。",_index);
                    [self showAlert:@"登录情况" message:@"登录成功"];
                  [self.navigationController popViewControllerAnimated:NO];
                  [self.delegate returnToViewController:_index];
           

                    
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
       
        
           

        



         
       
               
         } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString *password = passwordCredential.password;
        
     //   _appleIDInfoTextView.text = [NSString stringWithFormat:@"%@",passwordCredential];
        
    } else {
        
    }
}

//失败的回调
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    
}

#pragma mark - ASAuthorizationControllerPresentationContextProviding
//告诉代理应该在哪个window 展示授权界面给用户
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    
    return self.view.window;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)closeKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - Private

- (void)showAlert:(NSString *)title message:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

@end
