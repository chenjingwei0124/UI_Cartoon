//
//  JwAuthorCell.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwAuthorCell.h"
#import "UIView+Extension.h"
#import "JwAcer.h"
#import "UIImageView+WebCache.h"
#import "JwComic.h"
#import "JwTopic.h"

@interface JwAuthorCell ()

@property (nonatomic, strong)UIImageView *subImg;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *dateL;
@end

@implementation JwAuthorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.subImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.subImg];
        
        self.titleL = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleL];
    
        self.dateL = [[UILabel alloc] init];
        self.dateL.numberOfLines = 0;
        [self.contentView addSubview:self.dateL];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.subImg.frame = CGRectMake(10, 10, self.contentView.width/4, self.contentView.height - 15);
    
    self.titleL.frame = CGRectMake(self.subImg.x + self.subImg.width + 10, self.subImg.y, self.contentView.width*3/4 - 30, 30);
    self.titleL.font = [UIFont systemFontOfSize:15];
    self.titleL.textColor = [UIColor blackColor];
    
    self.dateL.frame = CGRectMake(self.titleL.x, self.titleL.y + self.titleL.height, self.titleL.width, self.contentView.height - self.titleL.y - self.titleL.height - 10);
    self.dateL.font = [UIFont systemFontOfSize:12];
    self.dateL.textColor = JwColor(110, 110, 110);
}

- (void)setComic:(JwComic *)comic{
    _comic = comic;
    
    [self.subImg sd_setImageWithURL:[NSURL URLWithString:self.comic.JwTopic.cover_image_url] placeholderImage:nil];
    self.titleL.text = self.comic.JwTopic.title;
    self.dateL.text = self.comic.JwTopic.JwDescription;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
