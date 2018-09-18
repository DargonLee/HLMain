//
//  HotViewController.m
//  网易新闻
//
//  Created by xiaomage on 16/3/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "HotViewController.h"
#import "UINavigationBar+Alpha.h"

#import "TopLineViewController.h"

@interface HotViewController ()

@end

@implementation HotViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.navAlpha = 0.0f;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.navAlpha = 1.0f;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    self.navigationItem.title = @"哈哈哈";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)nextPage
{
    TopLineViewController *vc = [[TopLineViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
