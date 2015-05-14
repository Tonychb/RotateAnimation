//
//  ViewController.m
//  RotateAnimationDemo
//
//  Created by zhubaoshi on 15/5/14.
//  Copyright (c) 2015年 tonychb. All rights reserved.
//

#import "ViewController.h"
#import "RotateAnimationView.h"

@interface ViewController ()<RotateAnimationViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //首先，实例化动画视图，设置视图尺寸位置和视图里的旋转按钮的宽高。
    RotateAnimationView *rotateAnimationView = [RotateAnimationView rotateAnimationViewWithFrame:self.view.bounds rotateItemSize:CGSizeMake(60, 60)];
    //设置背景图片
    rotateAnimationView.animationViewBackgroundColor = [UIColor whiteColor];
    //设置中心圆形的图像视图图片
    rotateAnimationView.centralFigureImage = [UIImage imageNamed:@"sun"];
    //设置动画视图代理方法
    rotateAnimationView.delegate = self;
    //然后，设置旋转按钮的文字、文字颜色和图片(都是传入字符串类型)
    rotateAnimationView.rotateItemTitles = @[@"按钮1",@"按钮2",@"按钮3",@"按钮4",@"按钮5",@"按钮6"];
    rotateAnimationView.rotateItemTitleColor = [UIColor blackColor];
    rotateAnimationView.rotateItemImages = @[@"ara",@"de",@"el",@"en",@"fra",@"it"];
    //最后，创建围绕圆形路径移动动画,设置是否顺时针方向绘制，设置按钮的个数(1至6的范围)
    [rotateAnimationView creatingSurroundAnimationWithClockwise:NO rotateItemCount:6];
    [self.view addSubview:rotateAnimationView];
    
}


#pragma mark - RotateAnimationViewDelegate(处理各个按钮的点击事件)
- (void)rotateAnimationViewWithRotateItem:(RotateItem *)rotateItem index:(NSInteger)index {
    NSLog(@"第%ld个按钮点击了",(long)index);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
