//
//  RotateAnimationView.m
//  RotateAnimation
//
//  Created by zhubaoshi on 15/5/12.
//  Copyright (c) 2015年 tonychb. All rights reserved.
//



#import "RotateAnimationView.h"
#import "RotateItem.h"

/**
 控件间隔
 */
static const CGFloat  kControlInterval = 10;


@interface RotateAnimationView ()
{
    //弧度
    CGFloat _radian;
    //开始按钮X\Y坐标
    CGFloat _fromRotateItemX;
    CGFloat _fromRotateItemY;
    //最后按钮X\Y坐标的数组
    NSMutableArray *_toRotateItemXArray;
    NSMutableArray *_toRotateItemYArray;
}

/**
 *  该视图的尺寸位置
 */
@property (nonatomic,assign) CGRect rotateAnimationViewFrame;

/**
 *  中心图形图片视图
 */
@property (nonatomic,strong) UIImageView *centralFigureImageView;

/**
 *  旋转按钮宽高
 */
@property (nonatomic,assign) CGSize rotateItemSize;


@end

@implementation RotateAnimationView


- (id)initRotateAnimationViewWithFrame:(CGRect)frame rotateItemSize:(CGSize)rotateItemSize {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _toRotateItemXArray = [NSMutableArray array];
        _toRotateItemYArray = [NSMutableArray array];
        
        self.rotateAnimationViewFrame = frame;
        self.rotateItemSize = rotateItemSize;
        //添加中心图形图片视图
        [self addCentralFigureImageView];
    }
    return self;
}

+ (id)rotateAnimationViewWithFrame:(CGRect)frame rotateItemSize:(CGSize)rotateItemSize {
    
    return [[self alloc]initRotateAnimationViewWithFrame:frame rotateItemSize:rotateItemSize];
    
}

#pragma mark - 设置动画视图的背景颜色
- (void)setAnimationViewBackgroundColor:(UIColor *)animationViewBackgroundColor {
    
    self.backgroundColor = animationViewBackgroundColor;
    _animationViewBackgroundColor = animationViewBackgroundColor;
    
}

#pragma mark - 添加中心图形图片视图
- (void)addCentralFigureImageView {
    
    CGFloat imageViewWH = _rotateAnimationViewFrame.size.width - kControlInterval * 2 - _rotateItemSize.width * 2;
    _centralFigureImageView = [[UIImageView alloc]initWithFrame:(CGRect){CGPointZero,{imageViewWH,imageViewWH}}];
    _centralFigureImageView.layer.cornerRadius = imageViewWH / 2;
    _centralFigureImageView.layer.masksToBounds = YES;
    _centralFigureImageView.contentMode = UIViewContentModeScaleAspectFit;
    _centralFigureImageView.center = CGPointMake(_rotateAnimationViewFrame.size.width / 2, _rotateAnimationViewFrame.size.height / 2);
    [self addSubview:_centralFigureImageView];
    [self sendSubviewToBack:_centralFigureImageView];
    
}


#pragma mark    设置中心图形图片视图的图片
- (void)setCentralFigureImage:(UIImage *)centralFigureImage {
    
    _centralFigureImageView.image = centralFigureImage;
    _centralFigureImage = centralFigureImage;
    
}


#pragma mark - 创建围绕圆形路径移动动画
- (void)creatingSurroundAnimationWithClockwise:(BOOL)clockwise
                               rotateItemCount:(NSInteger)rotateItemCount {
    
    if (rotateItemCount > 0 || rotateItemCount <= 6) {
        
        for (NSInteger i = 0; i < rotateItemCount; i ++) {
            
            //创建移动动画
            CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            pathAnimation.calculationMode = kCAAnimationPaced;
            //默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
            pathAnimation.removedOnCompletion = NO;
            //决定当前对象在非active时间段的行为。比如动画开始之前或者动画结束之后
            /*
             fillMode属性值（要想fillMode有效，最好设置removedOnCompletion = NO）
             kCAFillModeRemoved : 这个是默认值，也就是说当动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态.
             kCAFillModeForwards : 当动画结束后，layer会一直保持着动画最后的状态.
             kCAFillModeBackwards : 在动画开始前，只需要将动画加入了一个layer，layer便立即进入动画的初始状态并等待动画开始。
             kCAFillModeBoth : 这个其实就是上面两个的合成.动画加入后开始之前，layer便处于动画初始状态，动画结束后layer保持动画最后的状态.
             */
            pathAnimation.fillMode = kCAFillModeForwards;
            //动画的持续时间
            pathAnimation.duration = 1.5;
            //重复次数，无限循环可以设置HUGE_VALF或者MAXFLOAT
            pathAnimation.repeatCount = 1;
            //beginTime：可以用来设置动画延迟执行时间，若想延迟2s，就设置为CACurrentMediaTime()+2，CACurrentMediaTime()为图层的当前时间
            //pathAnimation.beginTime = CACurrentMediaTime() + 2;
            //pathAnimation.rotationMode = rotationMode;
            
            //创建移动动画的圆形路径
            CGMutablePathRef curvedPath = CGPathCreateMutable();
            
            
            //圆形路径的半径
            CGFloat radiusOfCircle = (_centralFigureImageView.bounds.size.width  + kControlInterval   + _rotateItemSize.width ) / 2;
            
            //最后按钮X\Y坐标
            CGFloat toRotateItemX = 0.0;
            CGFloat toRotateItemY = 0.0;
            switch (rotateItemCount) {
                case 2: //两个按钮的布局
                {
                    switch (i) {
                        case 0:
                            _radian = 0;
                            break;
                        case 1:
                            _radian = M_PI;
                            break;
                    }
                }
                    break;
                    
                case 5: //五个按钮的布局
                {
                    switch (i) {
                        case 0:
                            _radian = - (M_PI / 6); //-30度
                            break;
                        case 1:
                            _radian = M_PI_4; //45度
                            break;
                        case 2:
                            _radian = M_PI_4 * 3; //135度
                            break;
                        case 3:
                            _radian = 7 * (M_PI / 6); //210度
                            break;
                        case 4:
                            _radian = 3 * M_PI_2; //270度
                            break;
                    }
                    
                }
                    break;
                case 6: //六个按钮的布局
                {
                    //弧度
                    switch (i) { //M_PI_4 = 45度
                        case 0:
                            _radian = - (M_PI_4 + M_PI / 14);
                            break;
                        case 1:
                            _radian = 0;
                            break;
                        case 2:
                            _radian = (i - 1) * M_PI_4 + M_PI / 14;
                            break;
                        case 3:
                            _radian = i * M_PI_4 - M_PI / 14;
                            break;
                        case 4:
                            _radian = M_PI;
                            break;
                        case 5:
                            _radian = i * M_PI_4 + M_PI / 14;
                            break;
                    }
                }
                    break;
                    
                default: //其余个数按钮的布局
                    /*
                     弧度＝度×π/180
                     例如：
                     90° ＝ 90×π/180  ＝ π/2 弧度
                     60° ＝ 60×π/180  ＝ π/3 弧度
                     45° ＝ 45×π/180  ＝ π/4 弧度
                     30° ＝ 30×π/180  ＝ π/6 弧度
                     120°＝ 120×π/180 ＝ 2π/3 弧度
                     
                     反过来，弧度化成度怎么算？
                     因为   π弧度＝180°
                     所以   1弧度＝180°/π （≈57.3°）
                     因此，可得到 把弧度化成度的公式：度＝弧度×180°/π
                     例如：
                     4π/3弧度 ＝ 4π/3 ×180°/π ＝ 240°
                     
                     */
                    
                    //弧度
                    _radian = i * M_PI_2; //M_PI_2 = 90度
                    break;
            }
            
            
            //设置移动动画的路径
            // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
            if (clockwise) {
                
                CGPathAddArc(curvedPath, NULL, _rotateAnimationViewFrame.size.width / 2, _rotateAnimationViewFrame.size.height / 2, radiusOfCircle , _radian , _radian - M_PI, clockwise);
                /* 计算控件在圆的边缘坐标点
                 开始坐标
                 x1 = x0 + r*cos(角度1)
                 y1 = y0 + r*sin(角度1)
                 x0 y0圆心坐标，r圆半径，sin正弦 cos余弦 c函数，不用引其他包;
                 结束坐标类似.
                 */
                _fromRotateItemX = _rotateAnimationViewFrame.size.width / 2 + radiusOfCircle * cos(_radian);
                _fromRotateItemY = _rotateAnimationViewFrame.size.height / 2 + radiusOfCircle * sin(_radian);
                
                toRotateItemX = _rotateAnimationViewFrame.size.width / 2 + radiusOfCircle * cos(_radian - M_PI);
                toRotateItemY = _rotateAnimationViewFrame.size.height / 2 + radiusOfCircle * sin(_radian - M_PI);
                
            } else {
                
                CGPathAddArc(curvedPath, NULL, _rotateAnimationViewFrame.size.width / 2, _rotateAnimationViewFrame.size.height / 2, radiusOfCircle , _radian , _radian + M_PI, clockwise);
                /* 计算控件在圆的边缘坐标点
                 开始坐标
                 x1 = x0 + r*cos(角度1)
                 y1 = y0 + r*sin(角度1)
                 x0 y0圆心坐标，r圆半径，sin正弦 cos余弦 c函数，不用引其他包;
                 结束坐标类似.
                 */
                _fromRotateItemX = _rotateAnimationViewFrame.size.width / 2 + radiusOfCircle * cos(_radian);
                _fromRotateItemY = _rotateAnimationViewFrame.size.height / 2 + radiusOfCircle * sin(_radian);
                
                toRotateItemX = _rotateAnimationViewFrame.size.width / 2 + radiusOfCircle * cos(_radian + M_PI);
                toRotateItemY = _rotateAnimationViewFrame.size.height / 2 + radiusOfCircle * sin(_radian + M_PI);
                
            }
            
            if (i == rotateItemCount - 1) {
                //动画代理
                pathAnimation.delegate = self;
            }
            
            //以绘制好的圆形路径对象设置动画的路径对象
            pathAnimation.path = curvedPath;
            //释放路径对象
            CGPathRelease(curvedPath);
            
            //循环创造按钮
            RotateItem *rotateItem = [[RotateItem alloc]init];
            rotateItem.frame = (CGRect){CGPointZero,_rotateItemSize};
            rotateItem.center = CGPointMake(_fromRotateItemX, _fromRotateItemY);
            [rotateItem setTitle:self.rotateItemTitles[i] forState:UIControlStateNormal];
            [rotateItem setTitleColor:self.rotateItemTitleColor forState:UIControlStateNormal];
            [rotateItem setImage:[UIImage imageNamed:self.rotateItemImages[i]] forState:UIControlStateNormal];
            rotateItem.tag = i + 1;
            [self addSubview:rotateItem];
            NSString *animationKey = [NSString stringWithFormat:@"pathAnimation%ld",(long)i];
            [rotateItem.layer addAnimation:pathAnimation forKey:animationKey];
            
            //存储每个按钮最后的坐标位置
            [_toRotateItemXArray addObject:@(toRotateItemX)];
            [_toRotateItemYArray addObject:@(toRotateItemY)];
        }
        
    }
    
    
    
}

#pragma mark - 按钮点击事件
- (void)rotateItemClick:(RotateItem *)sender {
    
    NSInteger index = sender.tag;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rotateAnimationViewWithRotateItem: index:)]) {
        [self.delegate rotateAnimationViewWithRotateItem:sender index:index];
    }
    
}

#pragma mark - 动画代理(CAAnimationDelegate)
/**
 *  动画开始时，执行的方法。
 *
 *  @param anim 正在执行动画的CAAnimation实例。
 */
- (void)animationDidStart:(CAAnimation *)anim {
    
    NSLog(@"动画开始");
    
}

/**
 *  动画执行完成或者动画为执行被删除时，执行该方法。
 *
 *  @param anim 完成或者被删除的动画实例
 *  @param flag 标志该动画是执行完成或者被删除：YES：执行完成；NO：被删除。
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        NSLog(@"动画结束");
        
        for (NSInteger j = 0; j < _toRotateItemXArray.count; j ++) {
            
            RotateItem *rotateItem = (RotateItem *)[self viewWithTag:j + 1];
            CGFloat toRotateItemX = [_toRotateItemXArray[j] floatValue];
            CGFloat toRotateItemY = [_toRotateItemYArray[j] floatValue];
            rotateItem.center = CGPointMake(toRotateItemX, toRotateItemY);
            [rotateItem addTarget:self action:@selector(rotateItemClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
    }
    
}


@end
