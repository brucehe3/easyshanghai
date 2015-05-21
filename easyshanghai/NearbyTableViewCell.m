//
//  MixTableViewCell.m
//  pinpintong
//
//  Created by Bruce He on 15-4-4.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "NearbyTableViewCell.h"
#import "NearbyTableViewFrame.h"

#define NJNameFont [UIFont systemFontOfSize:16]
#define NJTextFont [UIFont systemFontOfSize:12]

@interface NearbyTableViewCell ()

// 名称
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  地址
 */
@property (nonatomic, weak) UILabel *addressLabel;

@property (nonatomic,weak) UIImageView *starImage;

@property (nonatomic,weak) UIImageView *commentIcon;

@property (nonatomic, weak) UILabel *commentLabel;

@end


@implementation NearbyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier = @"status";
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[NearbyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 让自定义Cell和系统的cell一样, 一创建出来就拥有一些子控件提供给我们使用
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = NJNameFont;
        //nameLabel.numberOfLines = 0;
        // introLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.font = NJTextFont;
        addressLabel.numberOfLines = 0;
        addressLabel.textColor = [UIColor grayColor];

        [self.contentView addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        UIImageView *starImage = [[UIImageView alloc] init];
        self.starImage = starImage;
        
        [self.contentView addSubview:starImage];
        
        UIImageView *commentIcon = [[UIImageView alloc] init];
        self.commentIcon = commentIcon;
        
        [self.contentView addSubview:commentIcon];
        
        UILabel *commentLabel = [[UILabel alloc] init];
        commentLabel.textColor = [UIColor grayColor];
        commentLabel.font = [UIFont systemFontOfSize:11];
        
        self.commentLabel = commentLabel;
        
        [self.contentView addSubview:commentLabel];
        
        
    }
    return self;
}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

- (void)setViewFrame:(NearbyTableViewFrame *)viewFrame
{
    _viewFrame = viewFrame;
    
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}

/**
 *  设置子控件的数据
 */
- (void)settingData
{
    
    NSDictionary *data = self.viewFrame.data;
    
    
    NSString *image_url = [NSString stringWithFormat:@"http://easyshanghai.s11.baiwei.org/%@!m80x60.jpg",[data objectForKey:@"image"]];
    
    
    
    [self.imageView setImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]]]];
    
    CGSize itemSize = CGSizeMake(80, 60);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [self.imageView.image drawInRect:imageRect];
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.nameLabel.text = [data objectForKey:@"name"];
    self.addressLabel.text = [data objectForKey:@"address2"];
    
    NSInteger rate = [[data objectForKey:@"rate"] integerValue];

    self.starImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"star%d.png",rate]];
    
    self.commentIcon.image = [UIImage imageNamed:@"icon-shop-comments.png"];
    self.commentLabel.text = [data objectForKey:@"comments"];
    
    
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    
    // 设置昵称的frame
    self.nameLabel.frame = self.viewFrame.nameF;
    self.layer.borderColor = [[[UIColor alloc] initWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1] CGColor];
    self.layer.borderWidth=4.0;
    
    self.addressLabel.frame = self.viewFrame.addressF;
    
    self.starImage.frame = self.viewFrame.starF;
    
    self.commentIcon.frame = self.viewFrame.commentF;
    
    self.commentLabel.frame = self.viewFrame.commentLabelF;
    
    // 设置正文的frame
    //self.contentLabel.frame = self.viewFrame.contentF;
    
}


@end
