//
//  CPlistItem.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//列表数据结构华

@interface CPlistItem : NSObject

@property(nonatomic,copy,readwrite)NSString *CPid;
@property(nonatomic,copy,readwrite)NSString *Photolink;
@property(nonatomic,copy,readwrite)NSString *videolink;
@property(nonatomic,copy,readwrite)NSString *longitude;
@property(nonatomic,copy,readwrite)NSString *latitude;
@property(nonatomic,copy,readwrite)NSString *evaluation;
@property(nonatomic,copy,readwrite)NSString *address;
@property(nonatomic,copy,readwrite)NSString *createTime;
@property(nonatomic,copy,readwrite)NSString *deleted;
@property(nonatomic,copy,readwrite)NSString *telephone;
@property(nonatomic,copy,readwrite)NSString *rate;
@property(nonatomic,copy,readwrite)NSString *CPname;
@property(nonatomic,copy,readwrite)NSString *updateTime;
@property(nonatomic,copy,readwrite)NSString *commentValue;
@property(nonatomic,copy,readwrite)NSString *CPprice;

- (void)configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
