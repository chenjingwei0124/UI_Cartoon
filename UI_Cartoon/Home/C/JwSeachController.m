//
//  JwSeachController.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/9.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwSeachController.h"
#import "UIView+Extension.h"
#import "NetHandler.h"
#import "JwTopic.h"
#import "JwNewListCell.h"
#import "JwComic.h"

@interface JwSeachController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIButton *popBackB;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *array;
@end

@implementation JwSeachController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
     [self.seachB addTarget:self action:@selector(seachBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.popBackB = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.popBackB.frame = CGRectMake(self.view.width/40, self.seachB.y, 30, 30);
    [self.view addSubview:self.popBackB];
    [self.popBackB setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui (1)"] forState:(UIControlStateNormal)];
    [self.popBackB addTarget:self action:@selector(popSeachBackBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(self.popBackB.x + self.popBackB.width, self.seachB.y, self.seachB.x - self.popBackB.x - self.popBackB.width - 5, 30)];
    self.searchBar.centerY = self.seachB.centerY;
    self.searchBar.layer.cornerRadius = 5;
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.placeholder = @"输入要搜索的关键字:";
    self.searchBar.delegate = self;
    self.searchBar.barStyle = UIBarMetricsDefault;
    [self.searchBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"car_nav_bg"]]];
    self.searchBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"car_nav_bg"]];
    [self.view addSubview:self.searchBar];
    
    
    self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64))];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.view addSubview:self.tableV];
    
}

- (void)seachBAction:(UIButton *)button{
    [self seachHandel:self.searchBar.text];
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([self.searchBar.text isEqualToString:@""]) {
        [self.searchBar resignFirstResponder];
        return;
    }
    [self seachHandel:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self seachHandel:self.searchBar.text];
    [self.searchBar resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JwComic *comic = [[JwComic alloc] init];
    JwTopic *topic = self.array[indexPath.row];
    comic.JwTopic = topic;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"subject" object:comic];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    JwNewListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JwNewListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.topic = self.array[indexPath.row];
    return cell;
}

- (void)seachHandel:(NSString *)value{
    
    self.array = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/topics/search?keyword=%@&offset=0&limit=20", value] completion:^(NSData *data) {
       
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
//        NSLog(@"%@", dic1);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dic2 = [dic1 objectForKey:@"data"];
            
            NSArray *arr1 = [dic2 objectForKey:@"topics"];
            
            for (NSDictionary *dic3 in arr1) {
                JwTopic *topic = [[JwTopic alloc] init];
                [topic setValuesForKeysWithDictionary:dic3];
                [self.array addObject:topic];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableV reloadData];
            });
        });

    }];
}

- (void)popSeachBackBAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
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
