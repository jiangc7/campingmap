//
//  SuccessLoginDelegate.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,functionPageName ){
    functionPageNameA = 1,
    functionPageNameB = 2,
};

@protocol SuccessLoginDelegate <NSObject>

-(void)returnToViewController:(functionPageName )pageName;

- (void)viewDidLoad;


@end

NS_ASSUME_NONNULL_END
