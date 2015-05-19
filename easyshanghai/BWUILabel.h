//
//  BWUILabel.h
//  easyshanghai
//
//  Created by Bruce He on 15-5-19.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWUILabel : UILabel

@property(nonatomic) UIEdgeInsets insets;
-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(id) initWithInsets: (UIEdgeInsets) insets;

@end