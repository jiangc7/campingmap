//
//  CPrentViewController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2022/1/5.
//

#import "CPrentViewController.h"

@interface CPrentViewController ()

@property(nonatomic,strong,readwrite) UILabel *titleLabel;
@property(nonatomic,strong,readwrite) UILabel *detailLabel;
@property(nonatomic,strong,readwrite) UILabel *questionLabel;
@property(nonatomic,strong,readwrite) UILabel *answerLabel;
@property(nonatomic,strong,readwrite) UILabel *telLabel;

@end

@implementation CPrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 2);
    scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 300, 20)];
//       self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    self.titleLabel.text = @"自己有地 我们帮你改成露营地赚钱";
    [self.titleLabel sizeToFit];
    [scrollView addSubview:_titleLabel];
    
    self.telLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 65, 300, 20)];
//       self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    self.telLabel.font = [UIFont systemFontOfSize:18];
    self.telLabel.text = @"微信联系:18611345936 合作 675094287@qq.com";
  //  self.telLabel.textColor = [UIColor systemBlueColor];
    [self.telLabel sizeToFit];
    [scrollView addSubview:_telLabel];
//    UITapGestureRecognizer *tapTel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callTel)];
//    self.telLabel.userInteractionEnabled = YES;
//    [self.telLabel addGestureRecognizer:tapTel];
    
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40, 100)];
 //   self.detailLabel.backgroundColor = [UIColor lightGrayColor];
    self.detailLabel.font = [UIFont systemFontOfSize:18];
    NSString *string = @"什么是爱露营地图导航? 爱露营是一个不断发展的社区，由爱好露营的人们组成，是独特的户外住宿的最全面的资源汇聚平台我们收集了全国200多个正规露营地信息，用户可以通过app快速预定和导航到营地我们与土地所有者合作，提供帐篷露营、房车公园、小木屋、树屋和豪华帐篷——从国家公园到蓝莓农场，无处不在。通过为土地所有者创造机会来接待大自然爱好者，爱露营致力于开拓更多不同风格的营地，让更多的人走向星空。";
   // self.detailLabel.textAlignment = UITextAlignmentCenter;
    
    self.detailLabel.textAlignment = UITextAlignmentLeft;
    self.detailLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.detailLabel.numberOfLines = 0;
     
    //行间距
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 8;
 
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    self.detailLabel.attributedText = attrString;
    [self.detailLabel sizeToFit];
    [scrollView addSubview:_detailLabel];
    
    self.questionLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 500, 300, 20)];
//       self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    self.questionLabel.font = [UIFont systemFontOfSize:22];
    self.questionLabel.text = @"你的土地合适吗？";
    [self.questionLabel sizeToFit];
    [scrollView addSubview:_questionLabel];
    
    self.answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 550, self.view.bounds.size.width-40, 100)];
  //  self.detailLabel.backgroundColor = [UIColor redColor];
    self.answerLabel.font = [UIFont systemFontOfSize:18];
    NSString *string2 = @"有特色的风景，小河，湖泊，高山，树林都会让您的露营地有吸引力，特色农场，樱桃园等等更会受到用户的欢迎，所以不要犹豫，马上联系我们。";
    self.answerLabel.textAlignment = UITextAlignmentLeft;
    self.answerLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.answerLabel.numberOfLines = 0;
     
    //行间距
    NSMutableParagraphStyle *style2 = [NSMutableParagraphStyle new];
    style.lineSpacing = 8;
 
    NSMutableAttributedString *attrString2 = [[NSMutableAttributedString alloc] initWithString:string2];
    [attrString2 addAttribute:NSParagraphStyleAttributeName value:style2 range:NSMakeRange(0, string2.length)];
    self.answerLabel.attributedText = attrString2;
    [self.answerLabel sizeToFit];
    [scrollView addSubview:_answerLabel];
    
    
    
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
