//
//  CPTableViewCell.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/7/5.
//

#import "CPTableViewCell.h"
#import "CPlistItem.h"
#import "SDWebImage.h"

@interface CPTableViewCell()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *addressLabel;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;
@property (nonatomic, strong, readwrite) UILabel *timeLabel;

@property (nonatomic, strong, readwrite) UIImageView *rightImageView;

@end

@implementation CPTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 240, 50)];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.numberOfLines = 2;
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel;
        })];

        [self.contentView addSubview:({
            self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 220, 20)];
            self.addressLabel.font = [UIFont systemFontOfSize:12];
            self.addressLabel.textColor = [UIColor grayColor];
            self.addressLabel;
        })];

        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 360, 20)];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel;
        })];

        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 50, 20)];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
        })];

        [self.contentView addSubview:({
            self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, 10, 120, 80)];
            self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.rightImageView;
        })];


    }
    return self;
}

- (void)layoutTableViewCellWithItem:(CPlistItem *)item {
    
//    BOOL hasRead = [[NSUserDefaults standardUserDefaults] boolForKey:item.uniqueKey];
    
//    if (hasRead) {
//        self.titleLabel.textColor = [UIColor lightGrayColor];
//    }else{
        self.titleLabel.textColor = [UIColor blackColor];
//    }

    self.titleLabel.text = item.CPname;

    if(item.address == nil){
        item.address = @"中国";
    }
    self.addressLabel.text = item.address;
  //  [self.addressLabel sizeToFit];
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if(item.evaluation == nil){
        item.evaluation = @"特别好";
    }
    self.commentLabel.text = item.evaluation;
 //   [self.commentLabel sizeToFit];
    self.commentLabel.lineBreakMode = NSLineBreakByTruncatingTail;

    
//    self.commentLabel.frame = CGRectMake(self.addressLabel.frame.origin.x + self.addressLabel.frame.size.width + 15, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);
   
  //  if(item.createTime == nil){
        item.createTime = @"2021/7/1";
  //  }
 

  //  self.timeLabel.text = item.createTime;
    [self.timeLabel sizeToFit];

  //  self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + 15, self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);

   
  //   self.rightImageView.image = [UIImage imageNamed:@"Icon@2x.png"];

//    NSThread *downloadImageThread = [[NSThread alloc] initWithBlock:^{
//        NSString *imgurl;
//        imgurl = [[NSString alloc] initWithFormat:@"http://www.campingmap.site/photo/%@.jpg",item.CPid];
//        NSLog(@"%@", imgurl);
//        [self.rightImageView setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"camping.JPG"]];
//
//    }];
//
//    downloadImageThread.name = @"downloadImageThread";
//    [downloadImageThread start];
    
/*
 //GCD的方式调用异步线程来下载图片
    dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();

    dispatch_async(downloadQueue, ^{
        NSString *imgurl;
               imgurl = [[NSString alloc] initWithFormat:@"http://www.campingmap.site/photo/%@.jpg",item.CPid];
               NSLog(@"%@", imgurl);
      //  UIImage *Image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
        [ self.rightImageView setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"camping.JPG"]];

//        dispatch_async(mainQueue, ^{
//            self.rightImageView = Image;
//        });
    });
 */
    //采用第三方图片框架SDWebImage来下载图片
    NSString *imgurl;
           imgurl = [[NSString alloc] initWithFormat:@"http://www.campingmap.site/photo/IMG_%@_1.JPG",item.CPid];
           NSLog(@"%@", imgurl);
  
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"camping.JPG"]
                                  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                     NSLog(@"%@", imgurl);
                                  }];
  
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
