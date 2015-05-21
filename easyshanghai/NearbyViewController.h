//
//  SecondViewController.h
//  easyshanghai
//
//  Created by Bruce He on 15-3-16.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NearbyViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate,
MBProgressHUDDelegate>{
    
    MBProgressHUD *hud;
    NSMutableArray *_items;
    NSMutableArray *_itemsKeys;
    
    
    NSMutableArray *dataArray; //创建个数组来放我们的数据
}

@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,retain) NSMutableArray *itemsKeys;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,retain) NSMutableArray *dataArray;

@end

