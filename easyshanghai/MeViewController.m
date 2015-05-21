//
//  MeViewController.m
//  easyshanghai
//
//  Created by Bruce on 15-5-21.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MeViewController.h"
#import "HomeHeadView.h"
#import "BWCommon.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self pageLayout];
}

- (void) pageLayout{
    
    self.navigationController.navigationBarHidden = YES;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    HomeHeadView *_hv = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, size.width, 60)];
    [_hv setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:133.0f/255.0f blue:0.0f/255.0f alpha:1]];
    
    [self.view addSubview:_hv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
