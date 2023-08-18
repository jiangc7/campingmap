//
//  TableViewController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/2.
//

#import "TableViewController.h"
#import "detailViewController.h"
#import "CPlistItem.h"
#import "CPListLoader.h"
#import "CPTableViewCell.h"


@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate,CPTableViewCellDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic,strong,readwrite)CPListLoader *listLoader;
@property(nonatomic,strong,readwrite)NSArray *dataArray;


@end

@implementation TableViewController

NSMutableArray *listItemArray;
CPlistItem *listItem;


- (void)viewDidLoad {
    [super viewDidLoad];
 //   [self loadListData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    self.listLoader = [[CPListLoader alloc]init];
    
    __weak typeof(self)wself = self;
    [self.listLoader LoadlistDataWithFinishBlock:^(bool success, NSArray<CPlistItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
        
    }];
    
    
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return [listItemArray count];
}

*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //回收池逻辑，从回收池找到丢弃的cell
    CPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if(!cell){
        
    cell = [[CPTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
   // cell.textLabel.text = [NSString stringWithFormat: @"主标题 -%@",@(indexPath.row)];
 //   cell.textLabel.text = listItem.CPname;
    
 //   cell.detailTextLabel.text = @"副标题";
  //  cell.imageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    
    
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CPlistItem *item = [self.dataArray objectAtIndex:indexPath.row];
    detailViewController *controller1 = [[detailViewController alloc]initWithObject:item];
    controller1.view.backgroundColor = [UIColor whiteColor];
    controller1.navigationItem.title = [NSString stringWithFormat:@"",@(indexPath.row)];
    [self.navigationController pushViewController:controller1 animated:YES];
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(self.tableView.contentOffset.y < 0){
        
    __weak typeof(self)wself = self;
    [self.listLoader LoadlistDataWithFinishBlock:^(bool success, NSArray<CPlistItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
        
    }];
        
    }
}
@end
