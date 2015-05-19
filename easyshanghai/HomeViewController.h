//
//  FirstViewController.h
//  easyshanghai
//
//  Created by Bruce He on 15-3-16.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *homeHeadView;

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
//@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;

@property (strong,nonatomic) UIScrollView *bodyScrollView;


- (void) initHeadView;


- (void) initMenuView;

- (void) initADView;

@end

