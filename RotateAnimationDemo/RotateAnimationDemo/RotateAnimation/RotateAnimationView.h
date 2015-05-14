//
//  RotateAnimationView.h
//  RotateAnimation
//
//  Created by zhubaoshi on 15/5/12.
//  Copyright (c) 2015年 tonychb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RotateItem;

@protocol RotateAnimationViewDelegate <NSObject>

@optional
- (void)rotateAnimationViewWithRotateItem:(RotateItem *)rotateItem index:(NSInteger)index;

@end


/**
 *  封装了沿着中心图形外围的圆形轨迹移动动画视图的类
 */
@interface RotateAnimationView : UIView

/**
 *  中心图形图片视图的图片
 */
@property (nonatomic,strong) UIImage *centralFigureImage;

/**
 *  动画视图的背景颜色
 */
@property (nonatomic,strong) UIColor *animationViewBackgroundColor;


/**
 *  旋转按钮的文字数组
 */
@property (nonatomic,strong) NSArray *rotateItemTitles;

/**
 *  旋转按钮的文字颜色
 */
@property (nonatomic,strong) UIColor *rotateItemTitleColor;

/**
 *  旋转按钮的图片数组
 */
@property (nonatomic,strong) NSArray *rotateItemImages;

/**
 *  代理
 */
@property (nonatomic,weak) id <RotateAnimationViewDelegate> delegate;


/**
 *  初始化类方法
 *
 *  @param frame          动画视图的框架
 *  @param rotateItemSize 动画视图里的旋转按钮的宽高
 *
 *  @return 返回动画视图的实例化对象
 */
+ (id)rotateAnimationViewWithFrame:(CGRect)frame rotateItemSize:(CGSize)rotateItemSize;

/**
 *  创建围绕圆形路径移动动画
 *
 *  @param clockwise       是否顺时针方向绘制路径(以相反方向移动)
 *  @param rotateItemCount 围绕圆形路径旋转的按钮个数(设置1至6范围)
 */
- (void)creatingSurroundAnimationWithClockwise:(BOOL)clockwise
                               rotateItemCount:(NSInteger)rotateItemCount;

@end
