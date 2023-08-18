//
//  CPlistItem.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/26.
//

#import "CPlistItem.h"

@implementation CPlistItem
- (void)configWithDictionary:(NSDictionary *)dictionary{
    
    self.CPid = [dictionary objectForKey:@"id"];
    self.Photolink = [dictionary objectForKey:@"Photolink"];
    self.videolink = [dictionary objectForKey:@"videolink"];
    self.longitude = [dictionary objectForKey:@"longitude"];
    self.latitude = [dictionary objectForKey:@"latitude"];
    self.evaluation = [dictionary objectForKey:@"evaluation"];
    self.address = [dictionary objectForKey:@"address"];
    self.createTime = [dictionary objectForKey:@"createTime"];
    self.deleted = [dictionary objectForKey:@"deleted"];
    self.telephone = [dictionary objectForKey:@"telephone"];
    self.rate = [dictionary objectForKey:@"rate"];
    self.CPname = [dictionary objectForKey:@"name"];
    self.updateTime = [dictionary objectForKey:@"updateTime"];
    self.commentValue = [dictionary objectForKey:@"commentValue"];
    self.CPprice = [dictionary objectForKey:@"price"];


    
}



@end
