//
//  JwSubjectView.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwSubjectView.h"
#import "JwSubjectCell.h"
#import "UIView+Extension.h"
#import "JwAcer.h"

@interface JwSubjectView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableV;
@end

@implementation JwSubjectView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) style:(UITableViewStylePlain)];
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        [self addSubview:self.tableV];
        
        UIView *head = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.tableV.width, 40))];
        head.backgroundColor = JwColor(240, 240, 240);
        UILabel *tiL = [[UILabel alloc] initWithFrame:(CGRectMake(head.width/20, 0, head.width/2, head.height))];
        tiL.textColor = JwZColor;
        tiL.text = @"专题列表";
        tiL.font = [UIFont systemFontOfSize:14];
        [head addSubview:tiL];
        self.tableV.tableHeaderView = head;
    }
    return self;
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
    JwSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JwSubjectCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.comic = self.array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JwComic *comic = self.array[indexPath.row];
    NSArray *arr = @[comic, self.aComic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"detail" object:arr];
}

- (void)setArray:(NSArray *)array{
    _array = array;
    
    [self.tableV reloadData];
}

@end
