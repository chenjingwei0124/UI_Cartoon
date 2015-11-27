//
//  JwNewsController.m
//  UI_Anews
//
//  Created by lanou on 15/11/5.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNewsController.h"
#import "NetHandler.h"
#import "JwBannerView.h"
#import "UIView+Extension.h"
#import "JwBanner.h"
#import "JwFonTopic.h"
#import "JwTopic.h"
#import "JwUser.h"
#import "JwComic.h"
#import "JwNewsView.h"

@interface JwNewsController ()

@property (nonatomic, strong)JwNewsView *newsV;
@property (nonatomic, strong)JwBannerView *bannnerV;
@property (nonatomic, strong)NSMutableArray *bannnerArr;
@property (nonatomic, strong)NSMutableArray *newsArr;
@end

@implementation JwNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleL.text= @"发现";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.newsV = [[JwNewsView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64 - 44))];
    [self.view addSubview:self.newsV];
    
    self.bannnerV = [[JwBannerView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.height/3.3))];
    self.newsV.tableV.tableHeaderView = self.bannnerV;
    
    [self bannerHandel];
    [self newsHandel];
}

- (void)bannerHandel{
    
    self.bannnerArr = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/banners"] completion:^(NSData *data) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dic2 = [dic1 objectForKey:@"data"];
           
            NSArray *arr1 = [dic2 objectForKey:@"banner_group"];
            for (NSDictionary *dic3 in arr1) {
                JwBanner *banner = [[JwBanner alloc] init];
                [banner setValuesForKeysWithDictionary:dic3];
                [self.bannnerArr addObject:banner];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.bannnerArr addObject:self.bannnerArr[0]];
                self.bannnerV.array = self.bannnerArr;
            });
        });
    }];
}

- (void)newsHandel{
    
    self.newsArr = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/topic_lists/mixed"] completion:^(NSData *data) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dic2 = [dic1 objectForKey:@"data"];
            NSArray *arr1 = [dic2 objectForKey:@"topics"];
            
            for (NSDictionary *dic3 in arr1) {
                JwFonTopic *fontopic = [[JwFonTopic alloc] init];
                [fontopic setValuesForKeysWithDictionary:dic3];
                [self.newsArr addObject:fontopic];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                self.newsV.array = self.newsArr;
                
            });
        });
    }];
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
