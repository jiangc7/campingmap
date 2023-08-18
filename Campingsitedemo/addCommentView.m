//
//  addCommentView.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/10/20.
//

#import "addCommentView.h"
#import "TZImagePickerController.h"
#import "TZImagePreviewController.h"
#import  <AFNetworking.h>

@interface addCommentView ()
@property (nonatomic, strong) IBOutlet UILabel *lastRatingTitleLabel;

@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UILabel *ranklabel;
@property(nonatomic,strong,readwrite) UITextField *commentText;
@property(nonatomic,strong,readwrite) UIButton *commentbutton;
@property(nonatomic,strong,readwrite) UIButton *pickPicbutton;
@property(nonatomic,strong,readwrite) UIAlertController* alert;
@property(nonatomic,readwrite) NSString *okIF;
@property(nonatomic,strong,readwrite) UIImage *image;
@property(nonatomic,strong,readwrite) UIView *cView;
@property(nonatomic,readwrite)NSString *loginID;
@property(nonatomic,readwrite)NSString *loginName;
@property(nonatomic,strong,readwrite) HCSStarRatingView *starRatingView;
@end
int i;

@implementation addCommentView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    starRatingView.maximumValue = 6;
    starRatingView.minimumValue = 0;
    starRatingView.value = 0;
    starRatingView.tintColor = [UIColor redColor];
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
    
    starRatingView.allowsHalfStars = YES;
    starRatingView.value = 2.5f;
    
    starRatingView.accurateHalfStars = YES;
    //心型图案
    starRatingView.emptyStarImage = [UIImage imageNamed:@"heart-empty"];
    starRatingView.halfStarImage = [UIImage imageNamed:@"heart-half"]; // optional
    starRatingView.filledStarImage = [UIImage imageNamed:@"heart-full"];
    */
     _loginID = [[NSUserDefaults standardUserDefaults] objectForKey:@"Pid"];
    _loginName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 150, 30)];
    _titlelabel.text = self.campTitle;
    _titlelabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_titlelabel];
    NSLog(@"名字是",self.campTitle);
    
    _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(20, 110, 200, 30)];
    _starRatingView.maximumValue = 6;
    _starRatingView.minimumValue = 0;
    _starRatingView.value = 3.5;
    _starRatingView.tintColor = [UIColor redColor];
    _starRatingView.allowsHalfStars = YES;
    _starRatingView.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRatingView.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRatingView.halfStarImage = [UIImage imageNamed:@"heart-half"];
    [_starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_starRatingView];
    
    _ranklabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, 100, 40)];
    _ranklabel.text = @"选定星级";
    [self.view addSubview:_ranklabel];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 100, 40)];
    _label.text = [NSString stringWithFormat:@"%f",_starRatingView.value];
    [self.view addSubview:_label];
     
    _commentText = [[UITextField alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 180)];
    _commentText.backgroundColor = [UIColor whiteColor];
    _commentText.font = [UIFont systemFontOfSize:16];
    _commentText.borderStyle = UITextBorderStyleRoundedRect;
    _commentText.layer.cornerRadius = 6;
    _commentText.layer.masksToBounds = YES;
        //设置描边
    _commentText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _commentText.layer.borderWidth = 1;

    [self.view addSubview:_commentText];
    
    self.commentbutton = [[UIButton alloc]initWithFrame:CGRectMake(20, 480, 200, 50)];
    [self.commentbutton setTitle:@"提交点评" forState:UIControlStateNormal];
    self.commentbutton.enabled = YES;

    self.commentbutton.backgroundColor = [UIColor systemTealColor];
    self.commentbutton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:self->_commentbutton];
    [self->_commentbutton addTarget:self action:@selector(addcomment:)forControlEvents:UIControlEventTouchUpInside];
    
    //pickPicbutton选择图片
//      _cView = [[UIView alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 70)];
//    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 90, 60)];
//    image1.image = [UIImage imageNamed:@"add"];
//    [_cView addSubview:image1];
//    [self.view addSubview:_cView];
//  //  _cView.backgroundColor = [UIColor lightGrayColor];
//    _cView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGe = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPic:)];
//    [_cView addGestureRecognizer:tapGe];
    
    
  //  _starRatingView.value = [self getStarValue:_loginID];
    
    

    
    
    //点击屏幕，让键盘退下
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    

//
    
}

- (int)getStarValue:(NSString *)loginID{
    
    NSString *urlString = @"http://www.campingmap.site:18081/camping/comment/v1/getStarByCampsiteAndUser";
    __block NSString *starNumber;
//    NSString *star = [NSString stringWithFormat:@"%f",_starRatingView.value];
   
               
    NSDictionary *parameters1 = @
    {
      @"campsiteId": _campsiteid,
      @"loginId": _loginID,
    };
    
        NSLog(@"参数是%@",parameters1);
        
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];

//        manager1.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
        manager1.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager1.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
   
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];

    [manager1 GET:urlString parameters:parameters1 headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
           
            starNumber = [responseObject objectForKey:@"content"];
         //  _okIF = [dataArray objectForKey:@"content"];
            NSLog(@" Token是",starNumber);
            
            
            if (starNumber){
                    NSLog(@"评星成功");
            }else{
                NSLog(@"评星失败");
             
            }
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"star连接失败 %@",error);
           
        }];
   
    int intString = (int)(starNumber);
    
    return intString;
}



- (void)didChangeValue:(HCSStarRatingView*)sender{
//    NSLog(@"starView.value:%f",starView.value);
    _label.text = [NSString stringWithFormat:@"%f",sender.value];
}

- (void)addPic:(UIButton *)button{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
      
        if (photos.count) {
            
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
        
            i = 0;
                    NSMutableArray *array = [NSMutableArray array];
            
            for (__strong UIImage *image in photos) {
                  //
                        NSData *data = UIImageJPEGRepresentation(image, 0.5);
                        image =[UIImage imageWithData:data];
                        [array addObject:image];
                UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake((5+(i*95)), 5, 90, 60)];
                [image1 setImage:image];
                [_cView addSubview:image1];
                i = i+1;
                
            //上传图片
                
            [manager POST:URL.absoluteString parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                

                    
                    [formData appendPartWithFileData:data
                                                    name:@"file"
                                            fileName: [NSString stringWithFormat:@"commentPIC%d.jpg",i] mimeType:@"image/jpeg"];
                      
              

                    // etc.
                } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"成功成功成功上传图片图片图片: %@", responseObject);

                    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",string);

                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];

            }
            
            
            
            UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake((5+(i*95)), 5, 90, 60)];
            image1.image = [UIImage imageNamed:@"add"];
            [_cView addSubview:image1];
               //     self.view.addImageA = array;
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
    
/*      //成功上传图片
        NSURL *URL = [NSURL URLWithString:@"http://www.campingmap.site:18081/camping/file/v1/pic/upload"];

        UIImage *myImageObj = [UIImage imageNamed:@"camp.jpg"];
        NSData *imageData= UIImageJPEGRepresentation(myImageObj, 0.6);

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //manager.responseSerializer=[AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
 
    [manager POST:URL.absoluteString parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [
                
                formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:@"image.jpg" mimeType:@"image/jpeg"];

            // etc.
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Response: %@", responseObject);

            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@",string);

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    */
}


- (void)addcomment:(UIButton *)button{
    

    NSLog(@"加123点评");
  //使用AFNetwork
    
    NSLog(@"取出的token是%@",_loginID);
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/comment/v1/writeComments",CampUrl];
//    NSString *urlString = @"http://www.campingmap.site:18081/camping/comment/v1/writeComments";
 
  //  NSURL *listURL = [NSURL URLWithString:urlString];
    if([[_commentText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] <6){
        [self showAlert:@"提示" message:@"评论不能少于6个字"];
        return;
      }
               
    NSDictionary *parameters = @
    {
      @"campsiteId": _campsiteid,
      @"content": _commentText.text,
      @"loginId": _loginID,
      @"topic": @"很棒的营地"
    };
    
        NSLog(@"参数是%@",parameters);
        
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        manager.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
  
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
   // manager.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",_token] forHTTPHeaderField:@"token"];


    [manager POST:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
            NSDictionary *dataArray = [responseObject objectForKey:@"result"];
           _okIF = [NSString stringWithFormat:@"%@",[dataArray objectForKey:@"code"]];
            NSLog(@" Token是 %@",_okIF);
            

            if ([_okIF isEqualToString:@"200"]){
                    NSLog(@"弹出评论成功");
     //           self->_alert = [UIAlertController alertControllerWithTitle:@"评论"
  //                                                 message:@"评论成功"
    //                                               preferredStyle:UIAlertControllerStyleAlert];
                
                NSLog(@"评论返回内容",dataArray);
                [self showAlert:@"评论" message:@"评论成功"];
                [self addcommentStar];
                   //    NSLog(@"_index是。。。。。",_index);
                     
                     [self.navigationController popViewControllerAnimated:NO];
                   // [self.delegate viewDidLoad];
                

//                NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
//                [usernamepasswordKVPairs setObject:self->_Token forKey:KEY_TOKEN];
//                [JJKeyChain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];

                
              //  [self.view setNeedsLayout];
//                [self viewDidLoad];
//                [self viewWillAppear:YES];
              
            }else{
                
                if([_okIF isEqualToString:@"4001"]){
                    [self showAlert:@"输入错误" message:@"请勿输入敏感词"];
                    
                }else{
                NSLog(@"弹出点评失败");

                    
                    [self showAlert:@"点评" message:@"点评失败"];
                }
            }
            
          
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败 %@",error);

            [self showAlert:@"点评" message:@"服务器连接失败"];
            
        }];
   
  
}

- (void)addcommentStar{
    
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/comment/v1/setStarByCampsiteAndUser",CampUrl];
//    NSString *urlString = @"http://www.campingmap.site:18081/camping/comment/v1/setStarByCampsiteAndUser";
 
//    NSString *star = [NSString stringWithFormat:@"%f",_starRatingView.value];
    int intString = (int)(_starRatingView.value*2);
               
    NSDictionary *parameters1 = @
    {
      @"campsiteId": _campsiteid,
      @"loginId": _loginID,
      @"star":[NSNumber numberWithInt:intString]
    };
    
        NSLog(@"参数是%@",parameters1);
        
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];

        manager1.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager1.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
    [manager1.requestSerializer setValue:[NSString stringWithFormat:@"%@",_token] forHTTPHeaderField:@"token"];
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];

    [manager1 POST:urlString parameters:parameters1 headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
            NSString *starNumber;
            starNumber = [responseObject objectForKey:@"content"];
         //  _okIF = [dataArray objectForKey:@"content"];
            NSLog(@" Token是",starNumber);
            
            
            if (starNumber){
                    NSLog(@"评星成功");
            }else{
                NSLog(@"评星失败");
             
            }
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"star连接失败 %@",error);
           
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

- (BOOL)isRightString:(NSString *)str {
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

- (void)closeKeyboard:(id)sender
{
    [self.view endEditing:YES];
}
// 进入功能A
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
