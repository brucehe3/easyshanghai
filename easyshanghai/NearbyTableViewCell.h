//
//  NearbyTableViewCell.h
//  easyshanghai
//
//  Created by Bruce He on 15-5-21.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyTableViewFrame.h"

@interface NearbyTableViewCell : UITableViewCell

@property (nonatomic,strong) NearbyTableViewFrame *viewFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
