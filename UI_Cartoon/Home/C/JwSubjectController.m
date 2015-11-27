//
//  JwSubjectController.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwSubjectController.h"
#import "UIView+Extension.h"
#import <QuartzCore/QuartzCore.h>
#import "JwAcer.h"
#import "JwComic.h"
#import "JwTopic.h"
#import "JwUser.h"
#import "UIImageView+WebCache.h"
#import "JwSubjectView.h"
#import "NetHandler.h"
#import "JwAbstractView.h"
#import "JwAuthorController.h"

@interface JwSubjectController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIView *titleV;
@property (nonatomic, strong)UIImageView *headImg;
@property (nonatomic, strong)UILabel *headL;
@property (nonatomic, strong)UIView *headPopV;
@property (nonatomic, strong)UILabel *countL;
@property (nonatomic, strong)UISegmentedControl *segC;

@property (nonatomic, strong)UIScrollView *scrollV;
@property (nonatomic, strong)JwSubjectView *subjectV;
@property (nonatomic, strong)JwAbstractView *abstrV;

@property (nonatomic, strong)UIButton *popBackB;
@property (nonatomic, strong)UIButton *userB;
@property (nonatomic, strong)NSMutableArray *array;
@end

@implementation JwSubjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.height/4 + 40))];
    [self.view addSubview:self.titleV];
    
    self.headImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.height/4))];
    [self.titleV addSubview:self.headImg];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.comic.JwTopic.cover_image_url] placeholderImage:nil];
    
    self.headPopV = [[UIView alloc] init];
    [self.headImg addSubview:self.headPopV];
    [self.headPopV.layer addSublayer:[self shadowAsInverse]];
    
    self.headL = [[UILabel alloc] initWithFrame:(CGRectMake(self.headImg.width/20, self.headImg.height - 40, self.headImg.width/2 - self.headImg.width/20, 40))];
    self.headL.font = [UIFont systemFontOfSize:16];
    self.headL.textColor = [UIColor whiteColor];
    self.headL.text = self.comic.JwTopic.title;
    [self.headImg addSubview:self.headL];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:(CGRectMake(self.headImg.width*3/4, self.headL.y, 40, 40))];
    img.image = [UIImage imageNamed:@"iconfont-dianzan (2)"];
    [self.headImg addSubview:img];
    self.countL = [[UILabel alloc] initWithFrame:(CGRectMake(img.x + img.width, img.y, self.headL.width - img.width, img.height))];
    self.countL.font = [UIFont systemFontOfSize:12];
    self.countL.textColor = [UIColor whiteColor];
    [self.headImg addSubview:self.countL];
    
    self.segC  = [[UISegmentedControl alloc] initWithItems:@[@"简介", @"内容"]];
    self.segC.frame = CGRectMake(0, self.headImg.height, self.headImg.width, 40);
    [self.segC setBackgroundImage:[UIImage imageNamed:@"seg_he"] forState:(UIControlStateNormal) barMetrics:(UIBarMetricsDefault)];
    self.segC.tintColor = [UIColor blackColor];
    self.segC.backgroundColor = [UIColor blackColor];
    self.segC.selectedSegmentIndex = 1;
    [self.segC addTarget:self action:@selector(segChange:) forControlEvents:(UIControlEventValueChanged)];
    [self.titleV addSubview:self.segC];
    
    self.scrollV = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, self.titleV.height, self.view.width, self.view.height - self.titleV.height))];
    self.scrollV.contentSize = CGSizeMake(self.view.bounds.size.width *2, self.scrollV.bounds.size.height);
    self.scrollV.contentOffset = CGPointMake(self.scrollV.width, 0);
    self.scrollV.pagingEnabled = YES;
    self.scrollV.scrollEnabled = YES;
    self.scrollV.bounces = NO;
    self.scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollV.showsVerticalScrollIndicator = NO;
    self.scrollV.delegate = self;
    [self.view addSubview:self.scrollV];
    
    self.abstrV = [[JwAbstractView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.scrollV.height))];
    self.abstrV.comic = self.comic;
//    NSLog(@"%@", self.abstrV.comic);
    [self.scrollV addSubview:self.abstrV];
    
    self.subjectV = [[JwSubjectView alloc] initWithFrame:(CGRectMake(self.scrollV.width, 0, self.view.width, self.scrollV.height))];
    self.subjectV.aComic = self.comic;
    [self.scrollV addSubview:self.subjectV];
    
    
    self.popBackB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.popBackB.frame = CGRectMake(self.view.width/20, self.view.height - 60, 40, 40);
    self.popBackB.layer.cornerRadius = self.popBackB.height/2;
    [self.view addSubview:self.popBackB];
    [self.popBackB setBackgroundImage:[UIImage imageNamed:@"iconfont-back (1)"] forState:(UIControlStateNormal)];
    [self.popBackB addTarget:self action:@selector(popBackBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.userB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.userB.frame = CGRectMake(self.view.width - self.view.width/20 - 40, self.view.height - 60, 40, 40);
    self.userB.layer.cornerRadius = self.userB.height/2;
    [self.view addSubview:self.userB];
    [self.userB setBackgroundImage:[UIImage imageNamed:@"iconfont-yonghu (4)"] forState:(UIControlStateNormal)];
    [self.userB addTarget:self action:@selector(userBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self subjectHandel];
}

- (void)segChange:(UISegmentedControl *)seg{
    if (seg.selectedSegmentIndex == 0) {
        self.scrollV.contentOffset = CGPointMake(0, 0);
    }
    if (seg.selectedSegmentIndex == 1) {
        self.scrollV.contentOffset = CGPointMake(self.scrollV.width, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == scrollView.width) {
        self.segC.selectedSegmentIndex = 1;
    }
    if (scrollView.contentOffset.x == 0) {
        self.segC.selectedSegmentIndex = 0;
    }
}

- (void)popBackBAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userBAction:(UIButton *)button{
    JwAuthorController *autVC = [[JwAuthorController alloc] init];
    autVC.comic = self.comic;
    [self.navigationController pushViewController:autVC animated:YES];
}

- (void)subjectHandel{
    
    self.array = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/topics/%@?sort=0", self.comic.JwTopic.uId] completion:^(NSData *data) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dic2 = [dic1 objectForKey:@"data"];
            NSArray *arr1 = [dic2 objectForKey:@"comics"];
            
            for (NSDictionary *dic3 in arr1) {
                JwComic *comic = [[JwComic alloc] init];
                [comic setValuesForKeysWithDictionary:dic3];
                [self.array addObject:comic];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"%@", self.array);
                self.subjectV.array = self.array;
                
                NSInteger index = 0;
                for (JwComic *comic in self.array) {
                    index = index + [comic.like_count integerValue];
                }
                if (index > 10000) {
                    self.countL.text = [NSString stringWithFormat:@"%ld万", index/10000];
                }
            });
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = (CGRectMake(0, self.headImg.height - 40, self.headImg.width, 40));
    newShadow.frame = newShadowFrame;
    newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,(id)JwColor(100, 100, 100).CGColor,nil];
    return newShadow;
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
