//
//  ReserveViewController.m
//  easyshanghai
//
//  Created by Bruce He on 15-5-19.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "ReserveViewController.h"
#import "HomeViewController.h"
#import "BWUILabel.h"

@interface ReserveViewController ()

@end

@implementation ReserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLayout];
    
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"Reserve Detail";


}

- (void) initLayout{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    self.navigationController.navigationBarHidden = NO;
    [[self view] setBackgroundColor:[UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1]];
    
    self.bodyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.bodyScrollView.scrollEnabled = YES;
    self.bodyScrollView.contentSize =CGSizeMake(size.width, size.height);
    [[self view]addSubview:[self bodyScrollView]];
    
    UIView *actionView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, size.width-20, 200)];
    [self.bodyScrollView addSubview:actionView];
    
    //actionView.backgroundColor = [UIColor whiteColor];
    
    UIView *row = [self createRowView:@"Date"];
    row.frame = CGRectMake(0, 0, size.width-20, 40);
    [actionView addSubview:row];

    UITextField *textDate = [self createTextField:@"reserve-date.png"];
    [row addSubview:textDate];
    
    
    //time
    UIView *row2 = [self createRowView:@"Time"];
    row2.frame = CGRectMake(0, 39, size.width-20, 40);
    [actionView addSubview:row2];
    
    UITextField *textTime = [self createTextField:@"reserve-time.png"];
    [row2 addSubview:textTime];
    
    //people
    UIView *row3 = [self createRowView:@"People"];
    row3.frame = CGRectMake(0, 78, size.width-20, 40);
    [actionView addSubview:row3];
    
    UITextField *textPeople = [self createTextField:@"reserve-plus.png"];
    [row3 addSubview:textPeople];
    
    //Restaurant
    UIView *row4 = [self createRowView:@"Restaurant"];
    row4.frame = CGRectMake(0, 117, size.width-20, 40);
    [actionView addSubview:row4];
    
    UITextField *textName = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, 180, 40)];
    [row4 addSubview:textName];
    textName.placeholder = @"Name";
    textName.textAlignment = NSTextAlignmentLeft;
    
    
    //buttons
    UIButton *btnDetail = [self createActionButton:@"Restaurant Details"];
    
    btnDetail.frame = CGRectMake(0, 170, size.width/2-15, 40);
    [actionView addSubview:btnDetail];
    
    [btnDetail addTarget:self  action:@selector(detailTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnReserve = [self createActionButton:@"Reserve"];
    
    btnReserve.frame = CGRectMake(size.width/2-5, 170, size.width/2 -15, 40);
    [actionView addSubview:btnReserve];
    
    

    
    
    
}

- (void) detailTouched:(id)sender{
    
}

- (UIButton *) createActionButton:(NSString *) title{

    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [btn setBackgroundColor:[UIColor colorWithRed:250.0f/255.0f green:111.0f/255.0f blue:87.0f/255.0f alpha:1]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.layer setCornerRadius:2.0];
    
    return btn;
}

- (UIView *) createRowView:(NSString *) title{
    
    UIView *row = [[UIView alloc] init];
    row.backgroundColor = [UIColor whiteColor];
    
    [row.layer setCornerRadius:4.0f];
    [row.layer setBorderWidth:0.5f];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.8, 0.8, 0.8, 1 });
    [row.layer setBorderColor:colorref];
    
    BWUILabel *name = [[BWUILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40) andInsets:UIEdgeInsetsMake(5, 15, 5, 0)];
    name.text = title;
    [row addSubview:name];
    
    
    return row;
}

- (UITextField *) createTextField:(NSString *)image {
    
    UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, 180, 40)];
    //field.borderStyle = UITextBorderStyleRoundedRect;
    //[field.layer setCornerRadius:2.0];
    //field.text = @"222";
    field.textAlignment = NSTextAlignmentLeft;
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    field.rightView = icon;
    field.rightViewMode = UITextFieldViewModeAlways;
    //field.translatesAutoresizingMaskIntoConstraints = NO;
    //field.delegate = self;

    return field;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[HomeViewController class]] == YES)
    {
        self.navigationController.navigationBarHidden = YES;
    }
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
