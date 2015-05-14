//
//  RotateItem.m
//  RotateAnimation
//
//  Created by zhubaoshi on 15/5/12.
//  Copyright (c) 2015年 tonychb. All rights reserved.
//

#import "RotateItem.h"

/**
 *  按钮内部内容百分比
 */
static CGFloat const kContentPercentage = 0.6f;

@implementation RotateItem

#pragma mark - 重写按钮初始化状态
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //设置按钮图标居中
        //self.imageView.contentMode = UIViewContentModeCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //设置按钮标题文字大小
        //self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        //设置按钮标题文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //        //设置选中按钮的背景图片
        //        [self setBackgroundImage:[UIImage imageNamed:kBtnBgImageName] forState:UIControlStateSelected];
        
    }
    return self;
}

#pragma mark - 重写按钮方法自定义样式
#pragma mark 按钮高亮方法
// 重写高亮事件为空，即跳过高亮事件过程，即点击按钮不会有高亮效果
- (void)setHighlighted:(BOOL)highlighted {
    
    return;
}

#pragma mark 按钮图标尺寸位置
//指定按钮图像边界,绘制区域
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    //按钮中图片占比上方60%，位置居中
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * kContentPercentage;
    
    return CGRectMake(0, 0, imageWidth, imageHeight);
}

#pragma mark 按钮标题文字尺寸位置
// 指定文字标题边界，绘制区域
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    //按钮文字占比下方40%，位置居中上移2个像素
    CGFloat titleY = contentRect.size.height * kContentPercentage - 2;
    CGFloat titleWidth = contentRect.size.width;
    CGFloat titleHeight = contentRect.size.height * (1 - kContentPercentage);
    
    return CGRectMake(0, titleY, titleWidth, titleHeight);
}



@end
