//
//  JwFoundListController.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/9.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwFoundListController.h"
#import "UIView+Extension.h"
#import "NetHandler.h"
#import "JwTopic.h"
#import "JwNewListCell.h"
#import "MJRefresh.h"
#import "JwComic.h"

@interface JwFoundListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UIView *titleV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIButton *popB;

@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *foundListArr;
@property (nonatomic, assign)NSInteger index;

@end

@implementation JwFoundListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.foundListArr = [NSMutableArray array];
    
    self.titleV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, 64))];
    self.titleV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navba_bg"]];
    [self.view addSubview:self.titleV];
    
    self.titleL = [[UILabel alloc] initWithFrame:(CGRectMake(self.view.width/20, self.titleV.height/2, self.view.width - self.view.width/10, 20))];
    self.titleL.font = [UIFont systemFontOfSize:15];
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self.titleV addSubview:self.titleL];
    self.titleL.text = self.foundTitle;
    
    self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, self.titleV.y + self.titleV.height, self.view.width, self.view.height - self.titleV.y - self.titleV.height))];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    self.index = 0;
    self.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.index = 0;
            [self foundListHandel];
            [self.tableV.header endRefreshing];
        });
    }];
    
    self.tableV.header.automaticallyChangeAlpha = YES;
    self.tableV.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.index += 20;
            [self foundListHandel];
            [self.tableV.footer endRefreshing];
        });
    }];
    
    
    self.popB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.popB.frame = CGRectMake(self.view.width/20, self.view.height - 60, 40, 40);
    self.popB.layer.cornerRadius = self.popB.height/2;
    [self.view addSubview:self.popB];
    [self.popB setBackgroundImage:[UIImage imageNamed:@"iconfont-back (1)"] forState:(UIControlStateNormal)];
    [self.popB addTarget:self action:@selector(popBNewListAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self foundListHandel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.foundListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    JwNewListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JwNewListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.topic = self.foundListArr[indexPath.row];
    return cell;
}

- (void)popBNewListAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JwComic *comic = [[JwComic alloc] init];
    JwTopic *topic = self.foundListArr[indexPath.row];
    comic.JwTopic = topic;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"subject" object:comic];
}


- (void)foundListHandel{
    
    NSString *fonString = [NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/topics?offset=%ld&limit=20&tag=%@",self.index, self.foundTitle];
    
    [NetHandler getDataWithUrl:fonString completion:^(NSData *data) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dic2 = [dic1 objectForKey:@"data"];
            
            NSArray *arr1 = [dic2 objectForKey:@"topics"];
            
            for (NSDictionary *dic3 in arr1) {
                JwTopic *topic = [[JwTopic alloc] init];
                [topic setValuesForKeysWithDictionary:dic3];
                [self.foundListArr addObject:topic];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableV reloadData];
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
