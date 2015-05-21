//
//  NearbyTableViewFrame.m
//  easyshanghai
//
//  Created by Bruce He on 15-5-21.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//


#import "NearbyTableViewFrame.h"

#define NJNameFont [UIFont systemFontOfSize:16]
#define NJTextFont [UIFont systemFontOfSize:12]


@implementation NearbyTableViewFrame


- (void)setData:(NSDictionary *) data{
    _data = data;
    
    CGFloat paddingY = 6;
    CGFloat paddingX = 5;
    
    //CGFloat imageX = padding;
    //CGFloat imageY = padding;
    //self.imageF = CGRectMake(imageX, imageY, 100, 60);
    
    CGFloat nameX = 100+paddingX*2;
    CGFloat nameY = paddingY*2;
    CGSize nameSize = [self sizeWithString:[_data objectForKey:@"name"] font:NJNameFont maxSize:CGSizeMake(190, MAXFLOAT)];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = 16;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat starX = 100+paddingX*2;
    CGFloat starY = nameY + nameH+paddingY;
    self.starF = CGRectMake(starX, starY, 80, 14);
    
    CGFloat addressX = 100+paddingX*2;
    CGFloat addressY = 14 + starY+paddingY;
    CGSize addressSize = [self sizeWithString:[_data objectForKey:@"address2"] font:NJTextFont maxSize:CGSizeMake(190, MAXFLOAT)];
    self.addressF = CGRectMake(addressX,addressY,addressSize.width,addressSize.height);
    
    CGFloat commentX = addressX;
    CGFloat commentY = addressY+addressSize.height+paddingY;
    self.commentF = CGRectMake(commentX, commentY, 12, 12);
    
    self.commentLabelF = CGRectMake(commentX+14, commentY, 60, 12);
    
    self.cellHeight = commentY+ 12 + paddingY*2;
    
    //self.cellHeight =CGRectGetMaxY(self.contentF) +padding;
    
    
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

@end
