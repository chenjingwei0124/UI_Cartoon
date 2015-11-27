//
//  JwHomeView.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwHomeView.h"
#import "JwHomeCell.h"
#import "JwComic.h"
#import "JwAcer.h"
#import "UIView+Extension.h"

@interface JwHomeView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation JwHomeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) style:(UITableViewStylePlain)];
//        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableV];
        
        UIView *head = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.tableV.width, self.tableV.width/8))];
        head.backgroundColor = JwColor(240, 240, 240);
        UIImageView *image = [[UIImageView alloc] initWithFrame:(CGRectMake(self.tableV.width/20, 15, head.height - 30, head.height - 30))];
        image.image = [UIImage imageNamed:@"iconfont-shijian"];
        image.layer.cornerRadius = image.height/2;
        [head addSubview:image];
        
        UILabel *title = [[UILabel alloc] initWithFrame:(CGRectMake(image.x + image.width + 10, image.y, self.tableV.width/2, image.height))];
        title.text = @"今日推荐";
        title.font = [UIFont systemFontOfSize:13];
        title.textColor = JwColor(180, 180, 180);
        [head addSubview:title];
        
        self.tableV.tableHeaderView = head;
    }
    return self;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return tableView.width/6;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *head = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, tableView.width, tableView.width/6))];
//    UIImageView *image = [[UIImageView alloc] initWithFrame:(CGRectMake(tableView.width/20, 10, head.height - 20, head.height - 20))];
//    image.layer.cornerRadius = image.height/2;
//    [head addSubview:image];
//    
//    UILabel *title = [[UILabel alloc] initWithFrame:(CGRectMake(image.x + image.width + 10, image.y, tableView.width/2, image.height))];
//    title.text = @"今日推荐";
//    title.font = [UIFont systemFontOfSize:13];
//    title.textColor = JwColor(180, 180, 180);
//    [head addSubview:title];
//    
//    return head;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    JwHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JwHomeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = JwColor(230, 230, 230);
    JwComic *comic = self.array[indexPath.row];
    cell.comic = comic;
    return cell;
}

- (void)setArray:(NSArray *)array{
    _array = array;
    
    [self.tableV reloadData];
}


@end
