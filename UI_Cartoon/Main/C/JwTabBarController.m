//
//  JwTabBarController.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwTabBarController.h"
#import "JwHomeController.h"
#import "JwNewsController.h"
#import "JwFoundController.h"

@interface JwTabBarController ()

@end

@implementation JwTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JwHomeController *homeVC = [[JwHomeController alloc] init];
    JwNewsController *newsVC = [[JwNewsController alloc] init];
    JwFoundController *foundVC = [[JwFoundController alloc] init];
    
    homeVC.tabBarItem.image = [UIImage imageNamed:@"iconfont-shouye"];
    newsVC.tabBarItem.image = [UIImage imageNamed:@"iconfont-yikeapp15"];
    foundVC.tabBarItem.image = [UIImage imageNamed:@"iconfont-sousuo (1)"];
    
    homeVC.tabBarItem.title = @"推荐";
    newsVC.tabBarItem.title = @"发现";
    foundVC.tabBarItem.title = @"搜索";
    self.tabBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"car_nav_bg"]];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg"]];
    
    self.viewControllers = @[homeVC, newsVC, foundVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
