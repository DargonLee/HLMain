//
//  HLTabBarController.h
//  HLMain
//
//  Created by Harlan on 2018/9/18.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLTabBarController : UITabBarController

/**
 添加子控制器的block
 
 @param addVCBlock 添加代码块
 
 @return TabBarController
 */
+ (instancetype)tabBarControllerWithAddChildVCsBlock: (void(^)(HLTabBarController *tabBarC))addVCBlock;



/**
 添加子控制器

 @param vc 子控制器
 @param title 标题
 @param normalImageName 正常图片
 @param selectedImageName 选中图片
 */
- (void)addChildVC:(UIViewController *)vc title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName;


/**
 tabbar的基础属性设置

 @param titleFont 字号大小
 @param normalColor 正常字体颜色
 @param selectedColor 选中字体颜色
 */
- (void)tabBarConfigWithBarBackground:(UIColor *)bgColor titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end
