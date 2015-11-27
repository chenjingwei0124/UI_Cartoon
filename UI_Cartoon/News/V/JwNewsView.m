//
//  JwNewsView.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNewsView.h"
#import "JwNewsCell.h"
#import "JwFonTopic.h"

@interface JwNewsView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation JwNewsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height))];
        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        [self addSubview:self.tableV];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifier = @"reuseIdentifier";
//    JwNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[JwNewsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
//        cell.fonTopic = self.array[indexPath.row];
//    }
    JwNewsCell *cell = [[JwNewsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fonTopic = self.array[indexPath.row];

    return cell;
}

- (void)setArray:(NSMutableArray *)array{
    _array = array;
    for (int i = (int)_array.count - 1; i > 0; i--) {
        JwFonTopic *ft = _array[i];
        if ([ft.JwType isEqualToString:@"1"]) {
            [self.array removeObject:ft];
        }
    }
    [self.tableV reloadData];
}

@end
