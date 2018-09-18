//
//  HLTabBarController.m
//  HLMain
//
//  Created by Harlan on 2018/9/18.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import "HLTabBarController.h"
#import "HLNavigationController.h"
#import "UIImage+Extension.h"

@interface HLTabBarController ()

@end

@implementation HLTabBarController

+ (instancetype)tabBarControllerWithAddChildVCsBlock:(void (^)(HLTabBarController *))addVCBlock
{
    HLTabBarController *tabbarVC = [[HLTabBarController alloc]init];
    if (addVCBlock) {
        addVCBlock(tabbarVC);
    }
    return tabbarVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置tabbar
    [self setUpTabbar];
}

- (void)setUpTabbar
{
//    [self setValue:[[XMGTabBar alloc] init] forKey:@"tabBar"];
}


- (void)addChildVC:(UIViewController *)vc title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName
{
    HLNavigationController *nav = [[HLNavigationController alloc]initWithRootViewController:vc];
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
    [self addChildViewController:nav];
}

- (void)tabBarConfigWithBarBackground:(UIColor *)bgColor titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
    //设置为不透明
    [[UITabBar appearance]setTranslucent:NO];
    //设置背景颜色
    [UITabBar appearance].tintColor = bgColor;
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = titleFont;
    normalAtts[NSForegroundColorAttributeName] = normalColor;
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = titleFont;
    selectAtts[NSForegroundColorAttributeName] = selectedColor;
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}


@end
