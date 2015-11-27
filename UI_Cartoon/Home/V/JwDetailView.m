//
//  JwDetailView.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwDetailView.h"
#import "JwDetailCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "JwComic.h"
#import "JwTopic.h"
#import "JwUser.h"
#import "JwAcer.h"

@interface JwDetailView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation JwDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) style:(UITableViewStylePlain)];
        self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.tableV.delegate = self;
        self.tableV.dataSource = self;
        [self addSubview:self.tableV];
        
        self.tableV.tableHeaderView = [self tableHeadView];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifier";
    JwDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JwDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.cmicImV sd_setImageWithURL:[NSURL URLWithString:self.array[indexPath.row]] placeholderImage:nil];
    return cell;
}

- (void)setArray:(NSMutableArray *)array{
    _array = array;
    
    [self.tableV reloadData];
}

- (void)setComic:(JwComic *)comic{
    _comic = comic;
    
    self.tableV.tableHeaderView = [self tableHeadView];
    [self.tableV reloadData];
}


- (UIView *)tableHeadView{
    
    UIView *popV = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, self.tableV.width, 64 + self.tableV.width/7))];
    UIView *head = [[UIView alloc] initWithFrame:(CGRectMake(0, 64, self.tableV.width, self.tableV.width/7))];
    [popV addSubview:head];
    
    UIImageView *auImg = [[UIImageView alloc] initWithFrame:(CGRectMake(self.tableV.width/20, 5, head.height - 15, head.height - 15))];
    head.backgroundColor = JwColor(240, 240, 240);
    
    auImg.layer.cornerRadius = auImg.height/2;
    auImg.layer.masksToBounds = YES;
    [auImg sd_setImageWithURL:[NSURL URLWithString:self.comic.JwTopic.JwUser.avatar_url] placeholderImage:nil];
    [head addSubview:auImg];
    
    UILabel *auL = [[UILabel alloc] initWithFrame:(CGRectMake(auImg.x + auImg.width + 10, 0, head.width/2, head.height/2))];
    auL.text = self.comic.JwTopic.JwUser.nickname;
    auL.textColor = [UIColor blackColor];
    auL.font = [UIFont systemFontOfSize:15];
    [head addSubview:auL];
    
    UILabel *tiL = [[UILabel alloc] initWithFrame:(CGRectMake(auL.x, head.height/2, auL.width, head.height/2))];
    tiL.textColor = JwColor(110, 110, 110);
    tiL.font = [UIFont systemFontOfSize:12];
    tiL.text = self.comic.JwTopic.title;
    [head addSubview:tiL];
    
    return popV;
}

@end
