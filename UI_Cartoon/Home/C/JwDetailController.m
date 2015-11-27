//
//  JwDetailController.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwDetailController.h"
#import "UIView+Extension.h"
#import "JwComic.h"
#import "NetHandler.h"
#import "JwDetailView.h"
#import "JwSubjectController.h"

@interface JwDetailController ()<UITableViewDelegate>

@property (nonatomic, strong)UIView *titleV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIButton *popB;
@property (nonatomic, strong)UIButton *allB;

@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)JwDetailView *detailV;

@property (nonatomic, assign)CGFloat begin;
@end

@implementation JwDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titleV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, 64))];
    self.titleV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navba_bg"]];
    [self.view addSubview:self.titleV];
    
    self.titleL = [[UILabel alloc] initWithFrame:(CGRectMake(self.view.width/20, self.titleV.height/2, self.view.width - self.view.width/10, 20))];
    self.titleL.font = [UIFont systemFontOfSize:15];
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self.titleV addSubview:self.titleL];
    self.titleL.text = self.comic.title;
    
    self.detailV = [[JwDetailView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.height))];
    self.detailV.tableV.delegate = self;
    self.detailV.comic = self.comic;
    [self.view addSubview:self.detailV];
    
    self.popB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.popB.frame = CGRectMake(self.view.width/20, self.view.height - 60, 40, 40);
    self.popB.layer.cornerRadius = self.popB.height/2;
    [self.view addSubview:self.popB];
    [self.popB setBackgroundImage:[UIImage imageNamed:@"iconfont-back (1)"] forState:(UIControlStateNormal)];
    [self.popB addTarget:self action:@selector(popBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.allB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.allB.frame = CGRectMake(self.view.width - self.view.width/20 - 40, self.view.height - 60, 40, 40);
    self.allB.layer.cornerRadius = self.allB.height/2;
    [self.view addSubview:self.allB];
    [self.allB setBackgroundImage:[UIImage imageNamed:@"iconfont-iconquanbuneirong (1)"] forState:(UIControlStateNormal)];
    [self.allB addTarget:self action:@selector(allBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view bringSubviewToFront:self.titleV];
    
    [self detailHandel];
}

- (void)popBAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)allBAction:(UIButton *)button{
    JwSubjectController *subjectVC = [[JwSubjectController alloc] init];
    subjectVC.comic = self.aComic;
    [self.navigationController pushViewController:subjectVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.detailV.tableV.bounds.size.width * 500/640;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y - self.begin > 64) {
        [self popHeadhid];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y < 64) {
        [self popHeaddis];
    }
    if (scrollView.contentOffset.y - self.begin > 64) {
        [self popHeadhid];
    }
    if (self.begin - scrollView.contentOffset.y > 64) {
        [self popHeaddis];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"开始减速");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.begin = scrollView.contentOffset.y;
}

- (void)popHeadhid{
    [UIView animateWithDuration:0.5 animations:^{
        self.titleV.frame = CGRectMake(0, -64, self.titleV.width, self.titleV.height);
        self.popB.alpha = 0;
        self.allB.alpha = 0;
    }];
}
- (void)popHeaddis{
    [UIView animateWithDuration:0.5 animations:^{
        self.titleV.frame = CGRectMake(0, 0, self.titleV.width, self.titleV.height);
        self.popB.alpha = 1;
        self.allB.alpha = 1;
    }];
}

- (void)detailHandel{
    self.array = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/comics/%@", self.comic.uId] completion:^(NSData *data) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dic2 = [dic1 objectForKey:@"data"];
            self.array = [dic2 objectForKey:@"images"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.detailV.array = self.array;
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
