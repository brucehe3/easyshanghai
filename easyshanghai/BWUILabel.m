//
//  BWUILabel.m
//  easyshanghai
//
//  Created by Bruce He on 15-5-19.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "BWUILabel.h"


@implementation BWUILabel

@synthesize insets=_insets;

-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
