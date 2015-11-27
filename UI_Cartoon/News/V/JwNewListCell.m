//
//  JwNewListCell.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/8.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwNewListCell.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "UIImageView+WebCache.h"
#import "JwTopic.h"
#import "JwUser.h"

@interface JwNewListCell ()

@property (nonatomic, strong)UIImageView *subImg;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *nameL;

@property (nonatomic, strong)UIImageView *dateV;
@property (nonatomic, strong)UILabel *dateL;
@end

@implementation JwNewListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.subImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.subImg];
        
        self.titleL = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleL];
        
        self.nameL = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameL];
        
        self.dateV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.dateV];
        
        self.dateL = [[UILabel alloc] init];
        [self.contentView addSubview:self.dateL];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.subImg.frame = CGRectMake(10, 10, self.contentView.width/4, self.contentView.height - 20);
    
    self.titleL.frame = CGRectMake(self.subImg.x + self.subImg.width + 10, self.subImg.y, self.contentView.width*3/4 -20, 30);
    self.titleL.font = [UIFont systemFontOfSize:15];
    self.titleL.textColor = [UIColor blackColor];
    
    self.nameL.frame = CGRectMake(self.titleL.x, self.titleL.y + self.titleL.height, self.titleL.width, 20);
    self.nameL.font = [UIFont systemFontOfSize:13];
    self.nameL.textColor = JwColor(120, 120, 120);
    
    self.dateV.frame = CGRectMake(self.contentView.width*2.5/4, self.subImg.y + self.subImg.height - 40, 40, 40);
    self.dateV.image = [UIImage imageNamed:@"iconfont-dianzan (1)"];
    
    self.dateL.frame = CGRectMake(self.dateV.x + self.dateV.width, self.dateV.y, self.contentView.width*1.5/4 - 10 - self.dateV.width, 40);
    self.dateL.font = [UIFont systemFontOfSize:12];
    self.dateL.textColor = JwColor(110, 110, 110);
}

- (void)setTopic:(JwTopic *)topic{
    _topic = topic;
    
    [self.subImg sd_setImageWithURL:[NSURL URLWithString:self.topic.cover_image_url] placeholderImage:nil];
    
    self.titleL.text = self.topic.title;
    
    self.nameL.text = self.topic.JwUser.nickname;
    
    NSInteger index = [self.topic.JwLikes integerValue];
    if (index > 10000) {
        self.dateL.text = [NSString stringWithFormat:@"%ld万", index/10000];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
