//
//  UINavigationBar+Alpha.m
//  HLMain
//
//  Created by Harlan on 2018/9/18.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import "UINavigationBar+Alpha.h"
#import <objc/runtime.h>


static char *navAlphaKey = "navAlphaKey";
@implementation UINavigationBar (Alpha)

- (void)setNavAlpha:(CGFloat)navAlpha
{
    CGFloat alpha = MAX(MIN(navAlpha, 1), 0);
    UIView *barBackground = self.subviews[0];
    if (self.translucent == NO || [self backgroundImageForBarMetrics:UIBarMetricsDefault] != nil) {
        barBackground.alpha = alpha;
    }else{
        if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0) {
            UIView *effectFilterView = barBackground.subviews.lastObject;
            effectFilterView.alpha = alpha;
        }else{
            UIView *effectFilterView = barBackground.subviews.firstObject;
            effectFilterView.alpha = alpha;
        }
    }
    
    UIImageView *shadowView = [barBackground valueForKey:@"_shadowView"];
    if (alpha < 0.01) {
        shadowView.hidden = YES;
    }else{
        shadowView.hidden = NO;
        shadowView.alpha = alpha;
    }
    
    objc_setAssociatedObject(self, navAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)navAlpha
{
    if (objc_getAssociatedObject(self, navAlphaKey) == nil) {
        return 1;
    }
    return [objc_getAssociatedObject(self, navAlphaKey) floatValue];
}

@end
