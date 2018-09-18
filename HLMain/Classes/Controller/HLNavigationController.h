//
//  HLNavigationController.h
//  HLMain
//
//  Created by Harlan on 2018/9/18.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLNavigationController : UINavigationController

@property(strong,nonatomic)UIScreenEdgePanGestureRecognizer *panGestureRec;

@property (nonatomic,strong) UIColor *navTintColor;

@property (nonatomic,strong) UIFont *navTintFont;

@property (nonatomic,strong) UIColor *itemTintColor;

@property (nonatomic,strong) UIFont *itemTintFont;

@property (nonatomic,strong) NSString *backImageName;

@end
