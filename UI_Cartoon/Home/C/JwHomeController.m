//
//  JwHomeController.m
//  UI_Anews
//
//  Created by lanou on 15/11/5.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwHomeController.h"
#import "JwHomeView.h"
#import "JwAcer.h"
#import "NetHandler.h"
#import "JwComic.h"
#import "JwDetailController.h"
#import "JwSubjectController.h"
#import "JwAuthorController.h"
#import "JwNewListController.h"
#import "MJRefresh.h"

@interface JwHomeController ()<UITableViewDelegate>

@property (nonatomic, strong)JwHomeView *homeV;
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, assign)NSInteger index;
@end

@implementation JwHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleL.text= @"推荐";
    self.index = 10;
    
    self.homeV = [[JwHomeView alloc] initWithFrame:(CGRectMake(0, 64, Screen_Width, Screen_Height - 64 - 44))];
    self.homeV.tableV.delegate = self;
    [self.view addSubview:self.homeV];
    
    self.homeV.tableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self searchHandel];
            [self.homeV.tableV.header endRefreshing];
        });
    }];
    
    self.homeV.tableV.header.automaticallyChangeAlpha = YES;
    self.homeV.tableV.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.index < 50) {
                self.index += 10;
            }
            [self searchHandel];
            [self.homeV.tableV.footer endRefreshing];
        });
    }];
    [self searchHandel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notDetail:) name:@"detail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notSubject:) name:@"subject" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notAuthor:) name:@"author" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notNewList:) name:@"newList" object:nil];

}

- (void)notNewList:(NSNotification *)object{
    JwNewListController *newListVC = [[JwNewListController alloc] init];
    newListVC.fonTopic = object.object;
    [self.navigationController pushViewController:newListVC animated:YES];
}

- (void)notAuthor:(NSNotification *)object{
    JwAuthorController *authorVC = [[JwAuthorController alloc] init];
    authorVC.comic = object.object;
    [self.navigationController pushViewController:authorVC animated:YES];
}

- (void)notSubject:(NSNotification *)object{
    JwSubjectController *subjectVC = [[JwSubjectController alloc] init];
    subjectVC.comic = object.object;
    [self.navigationController pushViewController:subjectVC animated:YES];
}

- (void)notDetail:(NSNotification *)object{
    JwDetailController *detailVC = [[JwDetailController alloc] init];
    NSArray *arr = object.object;
    detailVC.comic = arr[0];
    detailVC.aComic = arr[1];
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}

- (void)searchHandel{
    self.array = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/comic_lists/1?offset=0&limit=%ld", self.index] completion:^(NSData *data) {
        
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
                self.homeV.array = self.array;
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
