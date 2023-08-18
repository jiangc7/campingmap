//
//  CPListLoader.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/7/1.
//

#import <Foundation/Foundation.h>
#import "UIKit+AFNetworking.h"

@class CPlistItem;
NS_ASSUME_NONNULL_BEGIN


typedef void(^CPlistLoaderFinishBlock)(bool success, NSArray<CPlistItem *> *dataArray);
//列表请求

@interface CPListLoader : NSObject
@property(nonatomic,readwrite)int failCount;
- (void)LoadlistDataWithFinishBlock:(CPlistLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
