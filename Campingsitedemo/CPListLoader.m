//
//  CPListLoader.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/7/1.
//

#import "CPListLoader.h"
#import "CPlistItem.h"
#import  <AFNetworking.h>



@implementation CPListLoader
int failCount = 0;

- (void)LoadlistDataWithFinishBlock:(CPlistLoaderFinishBlock)finishBlock{
    
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/campsite/v1/campsites",CampUrl];

 //   NSDictionary *parameters = @{@"campsiteId": CPID};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        manager.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
  
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];

    [manager GET:urlString parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
            NSDictionary *dataArray = [responseObject objectForKey:@"content"];
            NSMutableArray *listItemArray = @[].mutableCopy;
           

            for(NSDictionary *info in dataArray){
                CPlistItem *listItem = [[CPlistItem alloc]init];
                [listItem configWithDictionary:info];
                [listItemArray addObject:listItem];

                }
         
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock(&access,listItemArray.copy);
                    
                }
            });

           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败 %@",error);
          //重新连接一次
            [manager GET:urlString parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@" 连接成功 %@",responseObject);
                    NSDictionary *dataArray = [responseObject objectForKey:@"content"];
                    NSMutableArray *listItemArray = @[].mutableCopy;
                   

                    for(NSDictionary *info in dataArray){
                        CPlistItem *listItem = [[CPlistItem alloc]init];
                        [listItem configWithDictionary:info];
                        [listItemArray addObject:listItem];

                        }
                 
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (finishBlock) {
                            finishBlock(&access,listItemArray.copy);
                            
                        }
                    });

                   
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"连接失败 %@",error);
                    [self showAlert:@"网络信号差" message:@"请检查手机网络"];
                    
                }];
             //二次连接完毕

            
        }];
   

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

@end
