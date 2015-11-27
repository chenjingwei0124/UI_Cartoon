//
//  JwAuthorController.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwAuthorController.h"
#import "UIView+Extension.h"
#import "JwComic.h"
#import "JwTopic.h"
#import "JwUser.h"
#import "NetHandler.h"
#import "UIImageView+WebCache.h"
#import "JwAuthorCell.h"
#import "JwAcer.h"
#import "JwSubjectController.h"

@interface JwAuthorController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UIImageView *headImg;
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *array;

@property (nonatomic, strong)UIImageView *autV;
@property (nonatomic, strong)UILabel *autL;
@property (nonatomic, strong)UILabel *desL;

@property (nonatomic, strong)UIButton *popBackB;

@property (nonatomic, strong)UILabel *weiboL;
@end

@implementation JwAuthorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.height)) style:(UITableViewStyleGrouped)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.contentInset = UIEdgeInsetsMake(self.view.height/3, 0, 0, 0);
    [self.view addSubview:self.tableV];
    
    UIView *tabTopV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.width, self.view.width/8))];
    UIImageView *img = [[UIImageView alloc] initWithFrame:(CGRectMake(self.tableV.width/20, 10, tabTopV.height - 20, tabTopV.height - 20))];
    img.image = [UIImage imageNamed:@"iconfont-iconxinlangweibo"];
    [tabTopV addSubview:img];
    tabTopV.backgroundColor = JwColor(215, 215, 215);
    
    self.weiboL = [[UILabel alloc] initWithFrame:(CGRectMake(img.x + img.width, img.y, tabTopV.width - img.x + img.width - tabTopV.width/20, img.height))];
    self.weiboL.textColor = JwColor(203, 80, 70);
    self.weiboL.font = [UIFont systemFontOfSize:13];
    [tabTopV addSubview:self.weiboL];
    
    self.tableV.tableHeaderView = tabTopV;
    
    self.headImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, - self.view.height/3, self.tableV.width, self.view.height/3))];
    self.headImg.image = [UIImage imageNamed:@"rbg"];
    self.headImg.contentMode = UIViewTintAdjustmentModeAutomatic;
    self.headImg.autoresizesSubviews = YES;
    self.headImg.clipsToBounds = YES;
    [self.tableV addSubview:self.headImg];
    
    self.autV = [[UIImageView alloc] initWithFrame:(CGRectMake(0, self.headImg.height/5, self.headImg.width/4, self.headImg.width/4))];
    self.autV.layer.cornerRadius = self.autV.height/2;
    self.autV.layer.masksToBounds = YES;
    self.autV.centerX = self.headImg.width/2;
//    self.autV.autoresizesSubviews = YES;
//    self.autV.clipsToBounds = YES;
//    self.autV.contentMode = UIViewTintAdjustmentModeAutomatic;
    [self.headImg addSubview:self.autV];
    
    self.autL = [[UILabel alloc] initWithFrame:(CGRectMake(self.headImg.width/20, self.autV.y + self.autV.height + 10, self.headImg.width - self.headImg.width/10, 30))];
    self.autL.textColor = [UIColor whiteColor];
    self.autL.textAlignment = NSTextAlignmentCenter;
    self.autL.font = [UIFont systemFontOfSize:15];
    [self.headImg addSubview:self.autL];
    
    self.desL = [[UILabel alloc] initWithFrame:(CGRectMake(self.autL.x, self.autL.y + self.autL.height, self.autL.width, self.headImg.height - self.autL.height - self.autL.y - 10))];
    self.desL.font = [UIFont systemFontOfSize:13];
    self.desL.numberOfLines = 0;
    self.desL.textAlignment = NSTextAlignmentCenter;
    self.desL.textColor = [UIColor whiteColor];
    [self.headImg addSubview:self.desL];
    
    [self.autV sd_setImageWithURL:[NSURL URLWithString:self.comic.JwTopic.JwUser.avatar_url] placeholderImage:nil];
    self.autL.text = self.comic.JwTopic.JwUser.nickname;
    
    self.popBackB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.popBackB.frame = CGRectMake(self.view.width/20, self.view.height - 60, 40, 40);
    self.popBackB.layer.cornerRadius = self.popBackB.height/2;
    [self.view addSubview:self.popBackB];
    [self.popBackB setBackgroundImage:[UIImage imageNamed:@"iconfont-back (1)"] forState:(UIControlStateNormal)];
    [self.popBackB addTarget:self action:@selector(popAuthorBackBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self authorHandel];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, tableView.width, tableView.width/8))];
    UILabel *tiL = [[UILabel alloc] initWithFrame:(CGRectMake(tableView.width/20, 0, tableView.width - tableView.width/10, view.height))];
    tiL.text = @"TA的专题";
    tiL.textColor = [UIColor blackColor];
    tiL.font = [UIFont systemFontOfSize:15];
    [view addSubview:tiL];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableView.width/8;
}

- (void)popAuthorBackBAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    JwAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JwAuthorCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    JwUser *user = self.comic.JwTopic.JwUser;
    JwTopic *topic = self.array[indexPath.row];
    topic.JwUser = user;
    self.comic.JwTopic = topic;
    cell.comic = self.comic;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JwSubjectController *subVC = [[JwSubjectController alloc] init];
    
    JwUser *user = self.comic.JwTopic.JwUser;
    JwTopic *topic = self.array[indexPath.row];
    topic.JwUser = user;
    self.comic.JwTopic = topic;

    subVC.comic = self.comic;
    [self.navigationController pushViewController:subVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    if (y < - self.view.height/3) {
        CGRect frame = self.headImg.frame;
        frame.origin.y = y;
        frame.size.height = - y;
        self.headImg.frame = frame;
        
        self.autV.frame = CGRectMake(0, self.headImg.height/5, self.headImg.width/4, self.headImg.width/4);
        self.autV.centerX = self.headImg.width/2;
        self.autL.frame = CGRectMake(self.headImg.width/20, self.autV.y + self.autV.height + 10, self.headImg.width - self.headImg.width/10, 30);
        self.desL.frame = CGRectMake(self.autL.x, self.autL.y + self.autL.height, self.autL.width, self.headImg.height - self.autL.height - self.autL.y - 10);
    }
}

- (void)authorHandel{
    
    self.array = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/users/%@", self.comic.JwTopic.JwUser.uId] completion:^(NSData *data) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dic2 = [dic1 objectForKey:@"data"];
            NSString *weiboStr = [dic2 objectForKey:@"weibo_name"];
            NSString *introStr = [dic2 objectForKey:@"intro"];
            NSArray *arr1 = [dic2 objectForKey:@"topics"];
            for (NSDictionary *dic3 in arr1) {
                JwTopic *topic = [[JwTopic alloc] init];
                [topic setValuesForKeysWithDictionary:dic3];
                [self.array addObject:topic];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.weiboL.text = weiboStr;
                self.desL.text = introStr;
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
