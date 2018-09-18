//
//  UIImage+Extension.h
//  HLMain
//
//  Created by Harlan on 2018/9/18.
//  Copyright © 2018年 Harlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)originImageWithName: (NSString *)name;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)circleImage;

@end
