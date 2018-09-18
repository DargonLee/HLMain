//
//  HLAppDelegate.m
//  HLMain
//
//  Created by 2461414445@qq.com on 09/18/2018.
//  Copyright (c) 2018 2461414445@qq.com. All rights reserved.
//

#import "HLAppDelegate.h"
#import "HLTabBarController.h"

#import "HotViewController.h"
#import "TopLineViewController.h"
#import "ScoietyViewController.h"
#import "ReaderViewController.h"

@implementation HLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    HLTabBarController *rootVC = [HLTabBarController tabBarControllerWithAddChildVCsBlock:^(HLTabBarController *tabBarC) {
        [tabBarC addChildVC:[HotViewController new] title:@"首页" normalImageName:@"home" selectedImageName:@"home_press"];
        [tabBarC addChildVC:[TopLineViewController new] title:@"我的" normalImageName:@"me" selectedImageName:@"me_press"];
    }];
    [rootVC tabBarConfigWithBarBackground:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]
                                titleFont:[UIFont systemFontOfSize:12]
                         normalTitleColor:[UIColor colorWithRed:0.56f green:0.60f blue:0.70f alpha:1.00f]
                            selectedColor:[UIColor colorWithRed:0.21f green:0.39f blue:0.93f alpha:1.00f]];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
