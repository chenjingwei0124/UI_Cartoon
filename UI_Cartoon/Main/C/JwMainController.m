//
//  JwMainController.m
//  UI_Anews
//
//  Created by lanou on 15/11/5.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwMainController.h"
#import "JwTabBarController.h"
#import "UIView+Extension.h"
#import "JwSeachController.h"

@interface JwMainController ()

@end

@implementation JwMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    UIView *headV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, 64))];
    headV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"car_nav_bg"]];
    [self.view addSubview:headV];
    
    self.titleL = [[UILabel alloc] initWithFrame:(CGRectMake(self.view.bounds.size.width/5, headV.bounds.size.height/2, self.view.bounds.size.width*3/5, 20))];
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [headV addSubview:self.titleL];
    
    self.seachB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.seachB.frame = CGRectMake(self.view.width - self.view.width/30 - 30, self.titleL.y - 5, 30, 30);
    
    [self.seachB setBackgroundImage:[UIImage imageNamed:@"iconfont-sousuo (2)"] forState:(UIControlStateNormal)];
    [self.seachB addTarget:self action:@selector(seachBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.seachB];
    
}

- (void)seachBAction:(UIButton *)button{
    JwSeachController *seachVC = [[JwSeachController alloc] init];
    [self.navigationController pushViewController:seachVC animated:YES];
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
