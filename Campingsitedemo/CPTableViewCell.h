//
//  CPTableViewCell.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/7/5.
//

#import <UIKit/UIKit.h>
#import "UIKit+AFNetworking.h"



NS_ASSUME_NONNULL_BEGIN
@class CPlistItem;

@protocol  CPTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end

@interface CPTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<CPTableViewCellDelegate>delegate;

- (void)layoutTableViewCellWithItem:(CPlistItem *)item;


@end

NS_ASSUME_NONNULL_END
