//
//  HLNavigationController.m
//  HLMain
//
//  Created by Harlan on 2018/9/18.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import "HLNavigationController.h"
#import "AnimationContoller.h"
#import "UIImage+Extension.h"

@interface HLNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic) UIImageView * screenshotImgView;
@property(strong,nonatomic) UIView * coverView;
@property(strong,nonatomic) NSMutableArray * screenshotImgs;
@property(strong,nonatomic) UIImage * nextVCScreenShotImg;
@property(strong,nonatomic) AnimationContoller * animationController;

@end

@implementation HLNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        
        self.navTintFont = [UIFont systemFontOfSize:17];
        self.navTintColor = [UIColor blackColor];
        
        self.itemTintFont = [UIFont systemFontOfSize:13];
        self.itemTintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
        
        self.backImageName = @"backImage";
    }
    return self;
}


- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupConfig];
    
    [self setupTransitions];
    
}

#pragma 基本配置
- (void)setupConfig
{
    
    //设置导航栏标题颜色
    //创建字典保存文字和颜色
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    color[NSFontAttributeName] = self.itemTintFont;
    color[NSForegroundColorAttributeName] = self.navTintColor;
    [self.navigationBar setTitleTextAttributes:color];
    
    //拿到整个控制器的外观
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    // 设置字典的字体大小
    NSMutableDictionary * atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = self.itemTintFont;
    atts[NSForegroundColorAttributeName] = self.itemTintColor;
    [item setTitleTextAttributes:atts forState:UIControlStateNormal];
}


#pragma 转场设置
- (void)setupTransitions
{
    // 1,创建Pan手势识别器,并绑定监听方法
    _panGestureRec = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRec:)];
    _panGestureRec.edges = UIRectEdgeLeft;
    // 为导航控制器的view添加Pan手势识别器
    [self.view addGestureRecognizer:_panGestureRec];
    
    // 2.创建截图的ImageView
    _screenshotImgView = [[UIImageView alloc] init];
    // app的frame是包括了状态栏高度的frame
    _screenshotImgView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    
    // 3.创建截图上面的黑色半透明遮罩
    _coverView = [[UIView alloc] init];
    // 遮罩的frame就是截图的frame
    _coverView.frame = _screenshotImgView.frame;
    // 遮罩为黑色
    _coverView.backgroundColor = [UIColor blackColor];
    
    // 4.存放所有的截图数组初始化
    _screenshotImgs = [NSMutableArray array];
}

#pragma 设置专场动画代理
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    self.animationController.navigationOperation = operation;
    self.animationController.navigationController = self;
    return self.animationController;
}

#pragma 重写push方法

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置返回按钮
    if (self.childViewControllers.count > 0) {
        // 调用自定义方法,使用上下文截图
        [self screenShot];
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"" forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:self.backImageName] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:self.backImageName] forState:UIControlStateHighlighted];
        //        [backBtn sizeToFit];
        //让按钮内部所有的内容往左靠拢
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //可以让按钮内部图片往左移动10的距离
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        //隐藏tabbar 当push到下个页面的时候
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //这句一定要放到后面，让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma 重写pop方法
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    NSInteger index = self.viewControllers.count;
    NSString * className = nil;
    if (index >= 2) {
        className = NSStringFromClass([self.viewControllers[index -2] class]);
    }
    
    if (_screenshotImgs.count >= index - 1) {
        [_screenshotImgs removeLastObject];
    }
    
    return [super popViewControllerAnimated:animated];
}

#pragma popToViewController
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    NSInteger removeCount = 0;
    for (NSInteger i = self.viewControllers.count - 1; i > 0; i--) {
        if (viewController == self.viewControllers[i]) {
            break;
        }
        
        [_screenshotImgs removeLastObject];
        removeCount ++;
        
    }
    _animationController.removeCount = removeCount;
    return [super popToViewController:viewController animated:animated];
}

#pragma popToRootViewController
- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    [_screenshotImgs removeAllObjects];
    [_animationController removeAllScreenShot];
    return [super popToRootViewControllerAnimated:animated];
}

#pragma 监听手势的方法,只要是有手势就会执行
- (void)panGestureRec:(UIScreenEdgePanGestureRecognizer *)panGestureRec
{
    
    // 如果当前显示的控制器已经是根控制器了，不需要做任何切换动画,直接返回
    if(self.visibleViewController == self.viewControllers[0]) return;
    
    // 判断pan手势的各个阶段
    switch (panGestureRec.state) {
        case UIGestureRecognizerStateBegan:
            // 开始拖拽阶段
            [self dragBegin];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
            // 结束拖拽阶段
            [self dragEnd];
            break;
            
        default:
            // 正在拖拽阶段
            [self dragging:panGestureRec];
            break;
    }
}

#pragma 使用上下文截图,并使用指定的区域裁剪,模板代码
- (void)screenShot
{
    // 将要被截图的view,即窗口的根控制器的view(必须不含状态栏,默认ios7中控制器是包含了状态栏的)
    UIViewController *beyondVC = self.view.window.rootViewController;
    // 背景图片 总的大小
    CGSize size = beyondVC.view.frame.size;
    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    // 要裁剪的矩形范围
    CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    //判读是导航栏是否有上层的Tabbar  决定截图的对象
    if (self.tabBarController == beyondVC) {
        [beyondVC.view drawViewHierarchyInRect:rect  afterScreenUpdates:NO];
    }
    else
    {
        [self.view drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    }
    // 从上下文中,取出UIImage
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    // 添加截取好的图片到图片数组
    if (snapshot) {
        [_screenshotImgs addObject:snapshot];
        //self.lastVCScreenShotImg = snapshot;
    }
    // 千万记得,结束上下文(移除栈顶的基于当前位图的图形上下文)
    UIGraphicsEndImageContext();
    
}

#pragma mark 开始拖动,添加图片和遮罩
- (void)dragBegin
{
    // 重点,每次开始Pan手势时,都要添加截图imageview 和 遮盖cover到window中
    [self.view.window insertSubview:_screenshotImgView atIndex:0];
    [self.view.window insertSubview:_coverView aboveSubview:_screenshotImgView];
    
    // 并且,让imgView显示截图数组中的最后(最新)一张截图
    _screenshotImgView.image = [_screenshotImgs lastObject];
    //_screenshotImgView.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
}


// 默认的将要变透明的遮罩的初始透明度(全黑)
#define kDefaultAlpha 0.6


// 当拖动的距离,占了屏幕的总宽高的3/4时, 就让imageview完全显示，遮盖完全消失
#define kTargetTranslateScale 0.75
#pragma mark 正在拖动,动画效果的精髓,进行位移和透明度变化
- (void)dragging:(UIPanGestureRecognizer *)pan
{
    
    // 得到手指拖动的位移
    CGFloat offsetX = [pan translationInView:self.view].x;
    
    // 让整个view都平移     // 挪动整个导航view
    if (offsetX > 0) {
        self.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    }
    
    
    // 计算目前手指拖动位移占屏幕总的宽高的比例,当这个比例达到3/4时, 就让imageview完全显示，遮盖完全消失
    double currentTranslateScaleX = offsetX/self.view.frame.size.width;
    
    if (offsetX < ScreenWidth) {
        
        _screenshotImgView.transform = CGAffineTransformMakeTranslation((offsetX - ScreenWidth) * 0.6, 0);
    }
    
    // 让遮盖透明度改变,直到减为0,让遮罩完全透明,默认的比例-(当前平衡比例/目标平衡比例)*默认的比例
    double alpha = kDefaultAlpha - (currentTranslateScaleX/kTargetTranslateScale) * kDefaultAlpha;
    _coverView.alpha = alpha;
}

#pragma mark 结束拖动,判断结束时拖动的距离作相应的处理,并将图片和遮罩从父控件上移除
- (void)dragEnd
{
    // 取出挪动的距离
    CGFloat translateX = self.view.transform.tx;
    // 取出宽度
    CGFloat width = self.view.frame.size.width;
    
    if (translateX <= 40) {
        // 如果手指移动的距离还不到屏幕的一半,往左边挪 (弹回)
        [UIView animateWithDuration:0.3 animations:^{
            // 重要~~让被右移的view弹回归位,只要清空transform即可办到
            self.view.transform = CGAffineTransformIdentity;
            // 让imageView大小恢复默认的translation
            self->_screenshotImgView.transform = CGAffineTransformMakeTranslation(-ScreenWidth, 0);
            // 让遮盖的透明度恢复默认的alpha 1.0
            self->_coverView.alpha = kDefaultAlpha;
        } completion:^(BOOL finished) {
            // 重要,动画完成之后,每次都要记得 移除两个view,下次开始拖动时,再添加进来
            [self->_screenshotImgView removeFromSuperview];
            [self->_coverView removeFromSuperview];
        }];
    } else {
        // 如果手指移动的距离还超过了屏幕的一半,往右边挪
        [UIView animateWithDuration:0.3 animations:^{
            // 让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform
            self.view.transform = CGAffineTransformMakeTranslation(width, 0);
            // 让imageView位移还原
            self->_screenshotImgView.transform = CGAffineTransformMakeTranslation(0, 0);
            // 让遮盖alpha变为0,变得完全透明
            self->_coverView.alpha = 0;
        } completion:^(BOOL finished) {
            // 重要~~让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform,不然下次再次开始drag时会出问题,因为view的transform没有归零
            self.view.transform = CGAffineTransformIdentity;
            // 移除两个view,下次开始拖动时,再加回来
            [self->_screenshotImgView removeFromSuperview];
            [self->_coverView removeFromSuperview];
            
            // 执行正常的Pop操作:移除栈顶控制器,让真正的前一个控制器成为导航控制器的栈顶控制器
            [self popViewControllerAnimated:NO];
            
            // 重要~记得这时候,可以移除截图数组里面最后一张没用的截图了
            // [_screenshotImgs removeLastObject];
            [self.animationController removeLastScreenShot];
        }];
    }
}

#pragma lazy
- (AnimationContoller *)animationController
{
    if (_animationController == nil) {
        _animationController = [[AnimationContoller alloc]init];
        
    }
    return _animationController;
}


@end
