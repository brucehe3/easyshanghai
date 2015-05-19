//
//  FirstViewController.m
//  easyshanghai
//
//  Created by Bruce He on 15-3-16.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "HomeViewController.h"
#import "ReserveViewController.h"
#import "BWCommon.h"
#import "AFNetworkTool.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize scrollView, slideImages;
@synthesize text;
//@synthesize pageControl;
@synthesize bodyScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    backItem.image=[UIImage imageNamed:@""];
    self.navigationItem.backBarButtonItem=backItem;
    
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

        [self initReserveButton];
        [self initMenuView];
        [self initADView];
        
        
    
    }
    
}

- (void) initHeadView{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    
    UIView * _hv;
    _hv = [self homeHeadView];
    
    [_hv setFrame:CGRectMake(0, 0, size.width, 60)];
    [_hv setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:133.0f/255.0f blue:0.0f/255.0f alpha:1]];
    
    //logo
    UIImageView * _logo;
    _logo = [[UIImageView alloc] init];
    [_logo setImage:[UIImage imageNamed:@"logo.png"]];
    [_logo setFrame:CGRectMake(10, 20, 80, 28)];
    [_hv addSubview:_logo];
    
    //search
    UIButton *_search;
    _search = [UIButton buttonWithType:UIButtonTypeCustom];
    [_search setTitle:@"Search here..." forState:UIControlStateNormal];
    [_search.layer setCornerRadius:12.0f];
    [_search.layer setBorderWidth:1.0f];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [_search.layer setBorderColor:colorref];
    _search.titleLabel.font = [UIFont systemFontOfSize:12.0];
    _search.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_search setFrame:CGRectMake(100, 20, size.width - 180, 28)];
    
    [_hv addSubview:_search];
    
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


- (UIButton*) createButton:(id)target Selector:(SEL)selector Image:(NSString *)image Title:(NSString *) title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints= NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:12.0];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, -20.0, 0.0)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void) initReserveButton{

    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    UIButton *_btnBooking = [[UIButton alloc] initWithFrame:CGRectMake(20, 130, size.width-40, 40)];
    [_btnBooking setTitle:@"Reserve" forState:UIControlStateNormal];
    _btnBooking.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [_btnBooking setBackgroundColor:[UIColor colorWithRed:250.0f/255.0f green:111.0f/255.0f blue:87.0f/255.0f alpha:1]];
    [_btnBooking setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnBooking setImage:[UIImage imageNamed:@"icon-booking.png"] forState:UIControlStateNormal];
    [_btnBooking setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15.0, 0.0, 0.0)];
    [_btnBooking.layer setCornerRadius:5.0];
    [_btnBooking addTarget:self action:@selector(reserveTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bodyScrollView addSubview:_btnBooking];
}

- (void) reserveTouched:(id)sender
{
    
    ReserveViewController * reserveView = [[ReserveViewController alloc] init];
    //reserveView.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:reserveView animated:YES];
}


- (void) initMenuView{
    UIView *_menuView;
    
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 120)];
    
    [self.bodyScrollView addSubview:_menuView];
    

    
    //restaurant
    
    UIButton *_btnRestaurant = [self createButton:self Selector:nil Image:@"home-restaurant.png" Title:@"Restaurant"];
    
    [_menuView addSubview:_btnRestaurant];
    
    UIButton *_btnPickup = [self createButton:self Selector:nil Image:@"home-pickup.png" Title:@"Pick-up"];
    
    [_menuView addSubview:_btnPickup];
    
    UIButton *_btnNew = [self createButton:self Selector:nil Image:@"home-new.png" Title:@"New"];
    
    [_menuView addSubview:_btnNew];
    
    UIButton *_btnDeals = [self createButton:self Selector:nil Image:@"home-deals.png" Title:@"Deals"];
    
    [_menuView addSubview:_btnDeals];
    
    NSArray *constraints1= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_btnRestaurant(<=68)]-10-[_btnPickup(<=68)]-10-[_btnNew(<=68)]-10-[_btnDeals(<=68)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnRestaurant,_btnPickup,_btnNew,_btnDeals)];
    NSArray *constraints2= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_btnRestaurant(<=68)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnRestaurant)];
    NSArray *constraints3= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_btnPickup(<=68)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnPickup)];
    NSArray *constraints4= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_btnNew(<=68)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnNew)];
    NSArray *constraints5= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_btnDeals(<=68)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnDeals)];

    [_menuView addConstraints:constraints1];
    [_menuView addConstraints:constraints2];
    [_menuView addConstraints:constraints3];
    [_menuView addConstraints:constraints4];
    [_menuView addConstraints:constraints5];

    
}

- (void) initADView{
    
    UIView * _leftAD;
    _leftAD = [[UIView alloc] initWithFrame:CGRectMake(5, 190, 155, 305)];
    [_leftAD setBackgroundColor:[UIColor whiteColor]];
    
    UIView * _rightADOne;
    _rightADOne = [[UIView alloc] initWithFrame:CGRectMake(165, 190, 150, 150)];
    [_rightADOne setBackgroundColor:[UIColor whiteColor]];
    
    UIView * _rightADTwo;
    _rightADTwo = [[UIView alloc] initWithFrame:CGRectMake(165, 345, 150, 150)];
    [_rightADTwo setBackgroundColor:[UIColor whiteColor]];
    
    [[self bodyScrollView] addSubview:_leftAD];
    [[self bodyScrollView] addSubview:_rightADOne];
    [[self bodyScrollView] addSubview:_rightADTwo];
}

@end
