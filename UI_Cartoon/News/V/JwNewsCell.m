//
//  JwNewsCell.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNewsCell.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "JwFonTopic.h"
#import "JwScolCell.h"
#import "JwComic.h"

@interface JwNewsCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UIView *popV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIButton *moreB;

@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
@property (nonatomic, strong)UICollectionView *collsctV;
@end

@implementation JwNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.popV = [[UIView alloc] init];
        [self.contentView addSubview:self.popV];
        
        self.titleL = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleL];
        
        self.moreB = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.contentView addSubview:self.moreB];
        
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        self.collsctV = [[UICollectionView alloc] initWithFrame:(CGRectZero) collectionViewLayout:self.layout];
        self.collsctV.delegate = self;
        self.collsctV.dataSource = self;

        [self.collsctV registerClass:[JwScolCell class] forCellWithReuseIdentifier:@"scolCell"];
        [self.contentView addSubview:self.collsctV];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.popV.frame = CGRectMake(self.contentView.width/25, self.contentView.width/20, 5, 20);
    self.popV.backgroundColor = JwColor(247, 173, 4);
    self.popV.layer.cornerRadius = 5;
    
    self.titleL.frame = CGRectMake(self.popV.x + 10, self.popV.y, self.contentView.width/2, 20);
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.font = [UIFont systemFontOfSize:15];
    
    self.moreB.frame = CGRectMake(self.contentView.width - self.contentView.width/20 - 60, self.titleL.y, 60, 20);
    [self.moreB setTitle:@"查看更多" forState:(UIControlStateNormal)];
    [self.moreB setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.moreB addTarget:self action:@selector(moreBAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.layout.itemSize = CGSizeMake(self.contentView.width/2.6, self.contentView.height - self.popV.y - self.popV.height - 30);
    self.layout.minimumInteritemSpacing = 10;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collsctV.collectionViewLayout = self.layout;
    
    self.collsctV.frame = CGRectMake(0, self.popV.y + self.popV.height + 15, self.contentView.width, self.contentView.height - self.popV.y - self.popV.height - 30);
    
    self.collsctV.contentSize = CGSizeMake(self.contentView.width/2.6 * self.fonTopic.topicArr.count, 0);
    self.collsctV.backgroundColor = [UIColor whiteColor];
}

- (void)moreBAction:(UIButton *)button{
//    NSLog(@"%@", self.fonTopic);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newList" object:self.fonTopic];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fonTopic.topicArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JwScolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"scolCell" forIndexPath:indexPath];
    cell.topic = self.fonTopic.topicArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JwComic *comic = [[JwComic alloc] init];
    JwTopic *topic = self.fonTopic.topicArr[indexPath.item];
    comic.JwTopic = topic;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"subject" object:comic];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (void)setFonTopic:(JwFonTopic *)fonTopic{
    _fonTopic = fonTopic;
    self.titleL.text = self.fonTopic.title;
    [self layoutSubviews];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)er{
    
    //        self.scollV = [[UIScrollView alloc] init];
    //        self.scollV.scrollEnabled = YES;
    //        self.scollV.showsHorizontalScrollIndicator = NO;
    //        self.scollV.showsVerticalScrollIndicator = NO;
    //        [self.contentView addSubview:self.scollV];
    
    
    //    self.scollV.frame = CGRectMake(0, self.popV.y + self.popV.height + 15, self.contentView.width, self.contentView.height - self.popV.y - self.popV.height - 30);
    //
    //    CGFloat w = self.contentView.width/2.2;
    //    CGFloat l = self.contentView.width/30;
    //    NSArray *topicArr = self.fonTopic.topicArr;
    //    if (topicArr.count > 0) {
    //        if (self.isFast) {
    //            self.scollV.contentSize = CGSizeMake(topicArr.count * (w + l), self.scollV.height);
    //            for (int i = 0; i < topicArr.count; i++) {
    //                JwScolView *scV = [[JwScolView alloc] initWithFrame:(CGRectMake(i * (w + l) + l, 0, w, 188))];
    //                scV.topic = topicArr[i];
    //                [self.scollV addSubview:scV];
    //            }
    //            self.isFast = NO;
    //        }
    //    }
}

@end
