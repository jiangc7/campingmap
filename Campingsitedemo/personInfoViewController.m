//
//  personInfoViewController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/11/30.
//

#import "personInfoViewController.h"

@interface personInfoViewController ()
@property(nonatomic,strong,readwrite) UITextField *nickNamefield;
@property(nonatomic,strong,readwrite) UITextField *Telfield;
@property(nonatomic,strong,readwrite) RadioButton *SexButton;
@property(nonatomic,strong,readwrite) RadioButton *SexButton2;
@property(nonatomic,strong,readwrite) UITextField *birthdayfield;
@property(nonatomic,strong,readwrite) UIImageView *personImage;
@property(nonatomic,readwrite) NSString *Pid;
@property(nonatomic,readwrite) NSString *userInfoId;
@property(nonatomic,readwrite)NSString * imgUrl;
@end

@implementation personInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    _Pid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Pid"];
    
    _userInfoId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoId"];
    
    self.personImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 80,100, 100)];
    self.personImage.backgroundColor = [UIColor blackColor];
    self.personImage.image = [UIImage imageNamed:@"camping.JPG"];
    self.personImage.layer.cornerRadius=self.personImage.frame.size.width/2;//裁成圆角
    self.personImage.layer.masksToBounds=YES;
    self.personImage.layer.borderWidth = 1.5f;
    self.personImage.layer.borderColor = [UIColor whiteColor].CGColor;
    UITapGestureRecognizer *personPic = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alterHeadPortrait:)];
    self.personImage.userInteractionEnabled = YES;
    [self.personImage addGestureRecognizer:personPic];
    [self.view addSubview:_personImage];
    
              NSData *imageData;
         
               imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
               if(imageData != nil)
               {
                   self.personImage.image = [NSKeyedUnarchiver unarchiveObjectWithData: imageData];
               }
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //用户昵称输入框
    self.nickNamefield=[[UITextField alloc]initWithFrame:CGRectMake(0, 190,self.view.frame.size.width, 40)];
    self.nickNamefield.autocorrectionType=UITextAutocorrectionTypeNo;
//    self.nickNamefield.clearsOnBeginEditing=YES;
    self.nickNamefield.backgroundColor=[UIColor lightGrayColor];
    self.nickNamefield.placeholder=@"用户昵称";
 //   self.nickNamefield.text = @"用户昵称";
    self.nickNamefield.font=[UIFont fontWithName:@"Arial" size:15];
    self.nickNamefield.secureTextEntry = NO;
    //usertextfield.delegate=self;
    [self.view addSubview:self.nickNamefield];
   

    //邮件输入框
    self.Telfield=[[UITextField alloc]initWithFrame:CGRectMake(0, 232 , (self.view.frame.size.width), 40)];
self.Telfield.autocorrectionType=UITextAutocorrectionTypeNo;
//self.Telfield.clearsOnBeginEditing=YES;
self.Telfield.backgroundColor=[UIColor lightGrayColor];
self.Telfield.placeholder=@"手机号码";
self.Telfield.font=[UIFont fontWithName:@"arial" size:15];
// self.passwordtextfield addGestureRecognizer:<#(nonnull UIGestureRecognizer *)#>
   // passwordtextfield.delegate=self;
 //   [self.view addSubview:self.Telfield];
//性别
    _SexButton = [[RadioButton alloc]initWithFrame:CGRectMake(20, 285 , 40, 40)];
    _SexButton2 = [[RadioButton alloc]initWithFrame:CGRectMake(100, 285 , 40, 40)];
    [_SexButton setTitle:@"男" forState:UIControlStateNormal];
    [_SexButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _SexButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_SexButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [_SexButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [_SexButton addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_SexButton2 setTitle:@"女" forState:UIControlStateNormal];
    [_SexButton2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _SexButton2.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_SexButton2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [_SexButton2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [_SexButton2 setSelected:YES];
    [_SexButton2 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    
//    [_SexButton setValue:@"男" forKey:UIControlStateNormal];
//    [_SexButton2 setValue:@"女" forKey:UIControlStateNormal];
    _SexButton.groupButtons = @[_SexButton,_SexButton2];
    [self.view addSubview:self.SexButton];
    [self.view addSubview:self.SexButton2];
///生日
//    self.birthdayfield=[[UITextField alloc]initWithFrame:CGRectMake(0, 274 , (self.view.frame.size.width), 40)];
//self.birthdayfield.secureTextEntry=YES;
//self.birthdayfield.autocorrectionType=UITextAutocorrectionTypeNo;
//self.birthdayfield.clearsOnBeginEditing=YES;
//self.birthdayfield.backgroundColor=[UIColor lightGrayColor];
//self.birthdayfield.placeholder=@"输入生日";
//self.birthdayfield.font=[UIFont fontWithName:@"arial" size:15];
//// self.passwordtextfield addGestureRecognizer:<#(nonnull UIGestureRecognizer *)#>
//   // passwordtextfield.delegate=self;
//    [self.view addSubview:self.birthdayfield];
//
    //  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
      UIButton *saveInfor =[UIButton buttonWithType:UIButtonTypeRoundedRect];
      [saveInfor setTitle:@"保存资料" forState:UIControlStateNormal];
      [saveInfor setFrame:CGRectMake((self.view.frame.size.width)/2-80, 350 , 160, 40)];
      [saveInfor addTarget:self action:@selector(saveUserinfo:) forControlEvents:UIControlEventTouchUpInside];
      saveInfor.backgroundColor=[UIColor blueColor];
      [self.view addSubview:saveInfor];
    
    [self  getUserInfo];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)getUserInfo{
    
  
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/userInfo/v1/getUserInfoByLoginId",CampUrl];
//    NSString *urlString = @"http://www.campingmap.site:18081/camping/userInfo/v1/getUserInfoByLoginId";
    NSLog(urlString);
    
  //  NSURL *listURL = [NSURL URLWithString:urlString];
    

    NSDictionary *parameters = @{@"loginId":_Pid};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        manager.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
  
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];

    [manager GET:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
            NSDictionary *dataArray = [responseObject objectForKey:@"content"];
           
            if(dataArray == nil || [dataArray isKindOfClass:[NSNull class]] || dataArray.count == 0){
                [self showAlert:@"错误" message:@"服务器连接失败"];
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
          
                NSString * nickname = [NSString stringWithFormat:@"%@",[dataArray objectForKey:@"nickname"]];
                 self.nickNamefield.text = nickname;
              
                self.Telfield.text = [dataArray objectForKey:@"phone"];
                NSString *male = [NSString stringWithFormat:@"%@",[dataArray objectForKey:@"male"]];
                
                if([male isEqualToString:@"0"]){
                    [_SexButton setSelected:YES];
                }else{
                    [_SexButton2 setSelected:YES];
                }
                
                _imgUrl = [dataArray objectForKey:@"avatar"];
                
                if(!_imgUrl&&![[NSUserDefaults standardUserDefaults] objectForKey:@"image"]){
                    
                    //GCD的方式调用异步线程来下载图片
                       dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                       dispatch_queue_main_t mainQueue = dispatch_get_main_queue();

                       dispatch_async(downloadQueue, ^{
                           
                           NSURL *url = [NSURL URLWithString: _imgUrl];// 获取的图片地址
                                  NSLog(@"%@", _imgUrl);
                           UIImage *Image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];

                           dispatch_async(mainQueue, ^{
                               self.personImage.image = Image;
                           });
                       });
           
                    
        //        self.personImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片
                }
             
                
           
 
        
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败 %@",error);
        }];
   
    
}
//  方法：alterHeadPortrait
-(void)alterHeadPortrait:(UITapGestureRecognizer *)gesture{
    /**
     *  弹出提示框
     */
            //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
            //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
            //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
            //自代理
        PickerImage.delegate = self;
            //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
        //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
        //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _personImage.image = newPhoto;
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:newPhoto];
    
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"image"];
    
    //上传图片
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/file/v1/pic/upload",CampUrl];
    NSURL *URL = [NSURL URLWithString:urlString];

//         UIImage *myImageObj = [UIImage imageNamed:@"camp.jpg"];
//         NSData *imageData= UIImageJPEGRepresentation(myImageObj, 0.6);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
   //上传图片代码

            NSMutableArray *array = [NSMutableArray array];
    

          //
                NSData *data = UIImageJPEGRepresentation(newPhoto, 0.5);


  
        
    //上传图片
        
    [manager POST:URL.absoluteString parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        

            
            [formData appendPartWithFileData:data
                                            name:@"file"
                                    fileName: [NSString stringWithFormat:@"PersonIcon%d.jpg",_Pid] mimeType:@"image/jpeg"];
              
      

            // etc.
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功成功成功上传图片图片图片: %@", responseObject);
          
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@",string);
            
            

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@", error);
        }];


    
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    // Lets handle ValueChanged event only for selected button, and ignore for deselected
    if(sender.selected) {
        NSLog(@"Selected color: %@", sender.titleLabel.text);
    }
}

-(void)saveUserinfo:(UIButton*) Button{
    
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/userInfo/v1/updateUserInfo",CampUrl];

    NSLog(urlString);
    int male = 1;
    
  //  NSURL *listURL = [NSURL URLWithString:urlString];
    
  
    if([_SexButton isSelected]){
        male = 0;
    }
    
    NSDictionary *parameters = @{
        @"avatar": [NSString stringWithFormat:@"http://www.campingmap.site/PIC/PersonIcon%d.jpg",_Pid],
        @"id": _userInfoId,
        @"loginId": _Pid,
        @"male":@(male),
        @"nickname": self.nickNamefield.text,
        @"phone": self.Telfield.text
      };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        manager.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式

   // manager.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",_token] forHTTPHeaderField:@"token"];


    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];

    [manager POST:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
            NSDictionary *dataArray = [responseObject objectForKey:@"result"];
           
            if(dataArray.count != 0){
                if([[dataArray objectForKey:@"code"] isEqualToNumber:@(200)]){
                    [self showAlert:@"个人数据" message:@"更改成功"];
                    
                    //在cookie中设置用户内容
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
 //                   [defaults setObject:self->_token forKey:@"token"];
                    [defaults setObject:self.nickNamefield.text forKey:@"username"];
  //                  [defaults setObject:loginID forKey:@"Pid"];
                    [defaults synchronize];
                    
                    [self.navigationController popViewControllerAnimated:NO];
                    [self.delegate returnToViewController:_index];
                }

           
            }
            [self showAlert:@"个人数据" message:@"更改失败"];
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败 %@",error);
            [self showAlert:@"个人数据" message:@"服务器连接失败"];
        }];
   
    
}
@end
