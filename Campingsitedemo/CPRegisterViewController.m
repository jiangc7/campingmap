//
//  CPRegisterViewController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/10/29.
//

#import "CPRegisterViewController.h"

@interface CPRegisterViewController ()
@property(nonatomic,strong,readwrite) UIImageView *imageView;
@property(nonatomic,strong,readwrite) NSString *Token;
@property(nonatomic,strong,readwrite) UIAlertController* alert;
@property(nonatomic,strong,readwrite) UITextField *usertextfield;
@property(nonatomic,strong,readwrite) UITextField *passwordtextfield;
@property(nonatomic,strong,readwrite) UIButton *logintouch;
@property(nonatomic,strong,readwrite) UIButton *forgetpassword;

@end

@implementation CPRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, (self.view.frame.size.width*2/3))];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.image = [UIImage imageNamed:@"camping.JPG"];
    [self.view addSubview:_imageView];
    
           self.view.backgroundColor=[UIColor systemBlueColor];

        //用户名标签
        int yy = (self.view.frame.size.width*2/3)+10;
    
    //用户名输入框
    self.usertextfield=[[UITextField alloc]initWithFrame:CGRectMake(0, yy,self.view.frame.size.width, 40)];
    self.usertextfield.secureTextEntry=YES;
    self.usertextfield.autocorrectionType=UITextAutocorrectionTypeNo;
    self.usertextfield.clearsOnBeginEditing=YES;
    self.usertextfield.backgroundColor=[UIColor lightGrayColor];
    self.usertextfield.placeholder=@"用户名/邮箱/手机号";
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
   // passwordtextfield.delegate=self;
    [self.view addSubview:self.passwordtextfield];

//登陆界面的点击登陆按钮
self.logintouch=[UIButton buttonWithType:UIButtonTypeRoundedRect];
[self.logintouch setTitle:@"注册用户" forState:UIControlStateNormal];
[self.logintouch setFrame:CGRectMake(100, yy+150, (self.view.frame.size.width-200), 30)];
[self.logintouch addTarget:self action:@selector(Registertouchclicked:) forControlEvents:UIControlEventTouchUpInside];
    self.logintouch.backgroundColor=[UIColor blueColor];
    self.logintouch.enabled = YES;
    self.logintouch.userInteractionEnabled = YES;
[self.view addSubview:self.logintouch];

//登陆界面的忘记密码按钮
self.forgetpassword=[UIButton buttonWithType:UIButtonTypeRoundedRect];
[self.forgetpassword setTitle:@"忘记密码" forState:UIControlStateNormal];
[self.forgetpassword setFrame:CGRectMake(100, yy+190, (self.view.frame.size.width-200), 30)];
[self.forgetpassword addTarget:self action:@selector(forgetpasswordclicked:) forControlEvents:UIControlEventTouchUpInside];
    self.forgetpassword.backgroundColor=[UIColor blueColor];
    self.forgetpassword.enabled = YES;
[self.view addSubview:self.forgetpassword];

//点击屏幕，让键盘退下
UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
tap.numberOfTapsRequired = 1;
tap.numberOfTouchesRequired = 1;
[self.view addGestureRecognizer:tap];
//     self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        NSLog(@"宽@%",self.view.frame.size.width);
//        NSLog(@"长@%",self.view.frame.size.height);
//    self.view.userInteractionEnabled = YES;
}



-(void)Registertouchclicked:(UIButton*)logintouch
{//登陆跳转到主界面按钮
    NSLog(@"登录开始");
    NSString *username = self.usertextfield.text;
    NSString *password = self.passwordtextfield.text;
    
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/login/v1/register",CampUrl];
 // NSString *urlString = @"http://www.campingmap.site:18081/camping/login/v1/register";
 
  //  NSURL *listURL = [NSURL URLWithString:urlString];
    //登录相关的检查
    if(self.usertextfield.text.length < 6){
            [self showAlert:@"提示" message:@"用户名不能小于6位"];
        return;
    }
    
    if([[self.passwordtextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] <5){
            [self showAlert:@"提示" message:@"密码不能小于6位"];
        return;
    }
   

    NSDictionary *parameters = @{    @"code": @"string",
                                     @"pwd": password,
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
            NSString *Pid = [dataArray objectForKey:@"id"];
            NSLog(@" Token是 %@",self->_Token);
            
            
            if ((![(self->_Token) length]) == 0 ){
                    NSLog(@"注册成功");
                self->_alert = [UIAlertController alertControllerWithTitle:@"注册情况"
                                                   message:@"注册成功"
                                                   preferredStyle:UIAlertControllerStyleAlert];
                
                    
                  
                    //save string
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setObject:self->_Token forKey:@"token"];
                    [defaults setObject:username forKey:@"username"];
                    [defaults setObject:Pid forKey:@"Pid"];
                    [defaults synchronize];
                
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                       NSLog(@"_index是。。。。。",_index);
                     
                     [self.navigationController popViewControllerAnimated:NO];
                     [self.delegate returnToViewController:_index];
                     
                     
                   }];
                
                [self->_alert addAction:okAction];
                
         //       [self dismissViewControllerAnimated:true completion:NULL];

//                NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
//                [usernamepasswordKVPairs setObject:self->_Token forKey:KEY_TOKEN];
//                [JJKeyChain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];

                
              //  [self.view setNeedsLayout];
//                [self viewDidLoad];
//                [self viewWillAppear:YES];
            
                
                
                
                
                
            }else{
                NSLog(@"弹出注册失败");
                self->_alert = [UIAlertController alertControllerWithTitle:@"注册情况"
                                               message:@"注册失败，请更换注册名称"
                                               preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                   handler:^(UIAlertAction * action) {
                    
                    
                    
                }];
                
                 
                [self->_alert addAction:defaultAction];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回"
                style:UIAlertActionStyleCancel handler:nil];
                [self->_alert addAction:cancelAction];
                
            }
            

            [self presentViewController:self->_alert animated:YES completion:nil];
            
           
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
