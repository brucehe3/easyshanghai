//
//  HomeHeadView.m
//  easyshanghai
//
//  Created by Bruce He on 15-3-16.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "HomeHeadView.h"

@implementation HomeHeadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGSize size = rect.size;
    
    UIView *_hv = self;
    
    //[_hv setFrame:CGRectMake(0, 0, size.width, 60)];
    //[self setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:133.0f/255.0f blue:0.0f/255.0f alpha:1]];
    
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




@end
