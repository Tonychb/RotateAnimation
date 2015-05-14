# RotateAnimation
按钮沿着圆形的轨迹移动动画效果

使用说明:
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
