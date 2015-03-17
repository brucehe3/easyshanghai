//
//  FirstViewController.m
//  easyshanghai
//
//  Created by Bruce He on 15-3-16.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "HomeViewController.h"
#import "BWCommon.h"
#import "AFNetworkTool.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize scrollView, slideImages;
@synthesize text;
@synthesize pageControl;
@synthesize bodyScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.navigationController.navigationBarHidden = YES;
    
    [[self view] setBackgroundColor:[UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1]];
    
    
    NSString *url = [BWCommon getAPIUrl:@"?11"];
    
    [AFNetworkTool JSONDataWithUrl:url success:^(id json) {
        
        NSLog(@"%@",json);
        
        NSInteger _errno =  (NSInteger) [json objectForKey: @"errno"];
        
        if ( _errno == 0 ){
            
        }
        
        // 提示:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        //        NSLog(@"%@", [NSThread currentThread]);
    } fail:^{
        NSLog(@"请求失败");
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    if (self.bodyScrollView == nil)
    {
        //init body scroll view
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize size = rect.size;
        
        self.bodyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, size.width, size.height-60-45)];
        self.bodyScrollView.scrollEnabled = YES;
        self.bodyScrollView.contentSize =CGSizeMake(size.width, size.height);
        [[self view]addSubview:[self bodyScrollView]];
        
        [self initHeadView];
        [self initPageView];
        [self initMenuView];
        [self initADView];
    
    }
    
}

- (void) initHeadView{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    
    UIView * _hv;
    _hv = [self homeHeadView];
    
    [_hv setFrame:CGRectMake(0, 0, 320, 60)];
    [_hv setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:133.0f/255.0f blue:0.0f/255.0f alpha:1]];
    
    //logo
    UIImageView * _logo;
    _logo = [[UIImageView alloc] init];
    [_logo setImage:[UIImage imageNamed:@"logo.png"]];
    [_logo setFrame:CGRectMake(10, 20, 80, 28)];
    [_hv addSubview:_logo];
    
    //map button
    UIButton * _map;
    _map = [UIButton buttonWithType:UIButtonTypeCustom];
    [_map setTitle:@"MAP" forState:UIControlStateNormal];
    [_map.layer setCornerRadius:12.0];
    _map.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    _map.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_map setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:133.0f/255.0f blue:0.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_map setBackgroundColor:[UIColor whiteColor]];

    [_map setFrame:CGRectMake(size.width - 70, 20, 60, 28)];
    [_hv addSubview:_map];
    
}


- (void) initPageView{
    [super viewDidLoad];

    // 初始化 scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.bodyScrollView addSubview:scrollView];
    // 初始化 数组 并添加四张图片
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"home-banner.jpg"];
    [slideImages addObject:@"home-banner.jpg"];
    [slideImages addObject:@"home-banner.jpg"];
    [slideImages addObject:@"home-banner.jpg"];
    // 初始化 pagecontrol
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(110,120,100,18)]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    pageControl.numberOfPages = [self.slideImages count];
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self.bodyScrollView addSubview:pageControl];
    // 创建四个图片 imageview
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((320 * i) + 320, 0, 320, 140);
        [scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
    }
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    imageView.frame = CGRectMake(0, 0, 320, 140); // 添加最后1页在首页 循环
    [scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake((320 * ([slideImages count] + 1)) , 0, 320, 140); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(320 * ([slideImages count] + 2), 140)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,140) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页

}

// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([slideImages count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([slideImages count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320 * [slideImages count],0,320,460) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([slideImages count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,460) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    NSInteger page = pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,460) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}

- (void) initMenuView{
    UIView *_menuView;
    
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 320, 80)];
    
    [self.bodyScrollView addSubview:_menuView];
    
    UIButton *_btnBooking = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 100, 30)];
    [_btnBooking setTitle:@"Booking" forState:UIControlStateNormal];
    _btnBooking.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_btnBooking setBackgroundColor:[UIColor colorWithRed:250.0f/255.0f green:163.0f/255.0f blue:60.0f/255.0f alpha:1]];
    [_btnBooking setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnBooking setImage:[UIImage imageNamed:@"icon-booking.png"] forState:UIControlStateNormal];
    [_btnBooking setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15.0, 0.0, 0.0)];
    [_btnBooking.layer setCornerRadius:2.0];
    
    [_menuView addSubview:_btnBooking];
    
    //restaurant
    UIButton *_btnRestaurant = [[UIButton alloc] initWithFrame:CGRectMake(110, 0, 100, 30)];
    [_btnRestaurant setTitle:@"Restaurant" forState:UIControlStateNormal];
    _btnRestaurant.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_btnRestaurant setBackgroundColor:[UIColor colorWithRed:235.0f/255.0f green:94.0f/255.0f blue:76.0f/255.0f alpha:1]];
    [_btnRestaurant setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnRestaurant setImage:[UIImage imageNamed:@"icon-restaurant.png"] forState:UIControlStateNormal];
    [_btnRestaurant setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0)];
    [_btnRestaurant.layer setCornerRadius:2.0];
    
    [_menuView addSubview:_btnRestaurant];
    
    //delivery
    UIButton *_btnDelivery = [[UIButton alloc] initWithFrame:CGRectMake(215, 0, 100, 30)];
    [_btnDelivery setTitle:@"Delivery" forState:UIControlStateNormal];
    _btnDelivery.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_btnDelivery setBackgroundColor:[UIColor colorWithRed:93.0f/255.0f green:130.0f/255.0f blue:209.0f/255.0f alpha:1]];
    [_btnDelivery setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnDelivery setImage:[UIImage imageNamed:@"icon-delivery.png"] forState:UIControlStateNormal];
    [_btnDelivery setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15.0, 0.0, 0.0)];
    [_btnDelivery.layer setCornerRadius:2.0];
    
    [_menuView addSubview:_btnDelivery];
    
    //add
    UIButton *_btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(5, 35, 100, 30)];
    [_btnAdd setTitle:@"Add Restaurant" forState:UIControlStateNormal];
    _btnAdd.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_btnAdd setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:126.0f/255.0f blue:48.0f/255.0f alpha:1]];
    [_btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnAdd setImage:[UIImage imageNamed:@"icon-add.png"] forState:UIControlStateNormal];
    [_btnAdd setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [_btnAdd.layer setCornerRadius:2.0];
    
    [_menuView addSubview:_btnAdd];
    
    //events
    UIButton *_btnEvents = [[UIButton alloc] initWithFrame:CGRectMake(110, 35, 100, 30)];
    [_btnEvents setTitle:@"Events Venue" forState:UIControlStateNormal];
    _btnEvents.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_btnEvents setBackgroundColor:[UIColor colorWithRed:64.0f/255.0f green:191.0f/255.0f blue:245.0f/255.0f alpha:1]];
    [_btnEvents setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnEvents setImage:[UIImage imageNamed:@"icon-event.png"] forState:UIControlStateNormal];
    [_btnEvents setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [_btnEvents.layer setCornerRadius:2.0];
    
    [_menuView addSubview:_btnEvents];
    
    //Promotion
    UIButton *_btnPromotion = [[UIButton alloc] initWithFrame:CGRectMake(215, 35, 100, 30)];
    [_btnPromotion setTitle:@"Promotion" forState:UIControlStateNormal];
    _btnPromotion.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_btnPromotion setBackgroundColor:[UIColor colorWithRed:239.0f/255.0f green:78.0f/255.0f blue:65.0f/255.0f alpha:1]];
    [_btnPromotion setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnPromotion setImage:[UIImage imageNamed:@"icon-promotion.png"] forState:UIControlStateNormal];
    [_btnPromotion setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0)];
    [_btnPromotion.layer setCornerRadius:2.0];
    
    [_menuView addSubview:_btnPromotion];
    
    
}

- (void) initADView{
    
    UIView * _leftAD;
    _leftAD = [[UIView alloc] initWithFrame:CGRectMake(5, 220, 155, 305)];
    [_leftAD setBackgroundColor:[UIColor whiteColor]];
    
    UIView * _rightADOne;
    _rightADOne = [[UIView alloc] initWithFrame:CGRectMake(165, 220, 150, 150)];
    [_rightADOne setBackgroundColor:[UIColor whiteColor]];
    
    UIView * _rightADTwo;
    _rightADTwo = [[UIView alloc] initWithFrame:CGRectMake(165, 375, 150, 150)];
    [_rightADTwo setBackgroundColor:[UIColor whiteColor]];
    
    [[self bodyScrollView] addSubview:_leftAD];
    [[self bodyScrollView] addSubview:_rightADOne];
    [[self bodyScrollView] addSubview:_rightADTwo];
}

@end
