//
//  SecondViewController.m
//  easyshanghai
//
//  Created by Bruce He on 15-3-16.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "NearbyViewController.h"
#import "BWCommon.h"
#import "HomeHeadView.h"
#import "NearbyTableViewCell.h"
#import "NearbyTableViewFrame.h"
#import "MJRefresh.h"

#import "AFNetworkTool.h"

@interface NearbyViewController ()

@property (nonatomic, strong) NSArray *statusFrames;
@property (nonatomic, assign) NSUInteger tid;
@property (nonatomic,assign) NSUInteger gpage;
@property (nonatomic, assign) NSString *updateLink;

@end

@implementation NearbyViewController

@synthesize items = _items;
@synthesize itemsKeys = _itemsKeys;
@synthesize tableview;
@synthesize dataArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self pageLayout];

}


- (void) refreshingData:(NSUInteger)page callback:(void(^)()) callback
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.delegate=self;
    
    NSString *list_url = [BWCommon getAPIUrl:@"shop/list"];
    list_url = [list_url stringByAppendingFormat:@"?page=%lu&page_size=10",(unsigned long)page];
    
    NSLog(@"%@",list_url);
    //load data
    [AFNetworkTool JSONDataWithUrl:list_url success:^(id json) {
        
        NSInteger errNo = [[json objectForKey:@"errno"] integerValue];
        
        [hud removeFromSuperview];
        if(errNo == 0)
        {
            
            //NSArray *data = [[NSArray alloc] init];
            if(page == 1)
            {
                dataArray = [[json objectForKey:@"data"] mutableCopy];
            }
            else
            {
                [dataArray addObjectsFromArray:[[json objectForKey:@"data"] mutableCopy]];
                
            }
            
            NSLog(@"%@",dataArray);
            self.statusFrames = nil;
            
            [tableview reloadData];
            
            if(callback){
                callback();
            }
            
            //NSLog(@"%@",json);
        }
        else
        {
            NSLog(@"%@",[json objectForKey:@"error"]);
        }
        
    } fail:^{
        [hud removeFromSuperview];
        NSLog(@"请求失败");
    }];
    
    
}

- (void) pageLayout{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    HomeHeadView *_hv = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, size.width, 60)];
    [_hv setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:133.0f/255.0f blue:0.0f/255.0f alpha:1]];
    
    [self.view addSubview:_hv];
    
    //cuisine   location   deals

    UIView *actionView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, size.width, 36)];
    
    actionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:actionView];
    
    
    
    UIButton *cuisine = [self createButton:self Selector:nil Image:@"arrow-down.png" Title:@"Cuisine"];
    cuisine.frame = CGRectMake(0, 0, 100, 36);
    
    UIButton *location = [self createButton:self Selector:nil Image:@"arrow-down.png" Title:@"Location"];
    location.frame = CGRectMake(104, 0, 100, 36);
    
    UIButton *deals = [self createButton:self Selector:nil Image:@"arrow-down.png" Title:@"Deals"];
    deals.frame = CGRectMake(208, 0, 100, 36);
    
    [actionView addSubview:cuisine];
    [actionView addSubview:location];
    [actionView addSubview:deals];
    
    actionView.layer.shadowColor = [UIColor blackColor].CGColor;
    actionView.layer.shadowOffset = CGSizeMake(0, 3);
    actionView.layer.shadowOpacity = 0.2;
    actionView.layer.shadowRadius = 1;
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 96, size.width, size.height-146)];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    
    self.gpage = 1;
    [self refreshingData:1 callback:^{
        //[self.tableview.header endRefreshing];
    }];
    
    [self.tableview addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    [self.tableview addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
}

- (void) headerRefreshing{
    
    self.gpage = 1;
    [self refreshingData:1 callback:^{
        [self.tableview.header endRefreshing];
    }];
    
}

- (void )footerRereshing{
    
    [self refreshingData:++self.gpage callback:^{
        [self.tableview.footer endRefreshing];
    }];
}

- (UIButton*) createButton:(id)target Selector:(SEL)selector Image:(NSString *)image Title:(NSString *) title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    //button.translatesAutoresizingMaskIntoConstraints= NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14.0];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

/* 这个函数是指定显示多少cells*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self dataArray] count];//这个是指定加载数据的多少即显示多少个cell，如果这个地方弄错了会崩溃的哟
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NearbyTableViewCell *cell = [NearbyTableViewCell cellWithTableView:tableview];
    
    cell.viewFrame = self.statusFrames[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"heightForRowAtIndexPath");
    // 取出对应航的frame模型
    NearbyTableViewFrame *vf = self.statusFrames[indexPath.row];
    NSLog(@"height = %f", vf.cellHeight);
    return vf.cellHeight;
}

- (NSArray *)statusFrames
{
    if (_statusFrames == nil) {
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dataArray.count];
        
        for (NSDictionary *dict in dataArray) {
            // 创建模型
            NearbyTableViewFrame *vf = [[NearbyTableViewFrame alloc] init];
            vf.data = dict;
            [models addObject:vf];
        }
        self.statusFrames = [models copy];
    }
    return _statusFrames;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger detail_id;
    /*detail_id = [[[dataArray objectAtIndex:[indexPath row]] objectForKey:@"id"] integerValue];
    
    MixDetailViewController *detailViewController = [[MixDetailViewController alloc] init];
    
    detailViewController.hidesBottomBarWhenPushed = YES;
    self.delegate = detailViewController;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [self.delegate setValue:detail_id];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
