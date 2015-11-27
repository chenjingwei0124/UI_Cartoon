//
//  JwHomeCell.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwHomeCell.h"
#import "UIView+Extension.h"
#import "JwComic.h"
#import "JwTopic.h"
#import "JwUser.h"
#import "UIImageView+WebCache.h"
#import "JwAcer.h"

@interface JwHomeCell ()
@property (nonatomic, strong)UIImageView *auImageV;
@property (nonatomic, strong)UILabel *auL;
@property (nonatomic, strong)UILabel *topL;
@property (nonatomic, strong)UILabel *tiL;
@property (nonatomic, strong)UIImageView *conImageV;
@property (nonatomic, strong)UILabel *conL;

@property (nonatomic, strong)UIView *leftV;
@property (nonatomic, strong)UIView *rightV;
@property (nonatomic, strong)UIView *changeV;

@end

@implementation JwHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftV = [[UIView alloc] init];
        [self.contentView addSubview:self.leftV];
        self.auImageV = [[UIImageView alloc] init];
        [self.leftV addSubview:self.auImageV];
        self.auL = [[UILabel alloc] init];
        [self.leftV addSubview:self.auL];
        
        self.rightV = [[UIView alloc] init];
        [self.contentView addSubview:self.rightV];
        self.tiL = [[UILabel alloc] init];
        [self.rightV addSubview:self.tiL];
        self.topL = [[UILabel alloc] init];
        [self.rightV addSubview:self.topL];
        
        self.conImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.conImageV];
        self.conImageV.userInteractionEnabled = YES;
        
        self.changeV = [[UIView alloc] init];
        [self.contentView addSubview:self.changeV];
        
        self.conL = [[UILabel alloc] init];
        [self.contentView addSubview:self.conL];
        
        [self.leftV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftVAction:)]];
        [self.rightV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightVAction:)]];
        [self.conImageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(conImageVAction:)]];
    }
    return self;
}

- (void)leftVAction:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"author" object:self.comic];
}
- (void)rightVAction:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"subject" object:self.comic];
}
- (void)conImageVAction:(UITapGestureRecognizer *)tap{
    NSArray *arr = @[self.comic, self.comic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"detail" object:arr];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    
    self.leftV.frame = CGRectMake(0, 0, width/2, height/5.5 + 10);
    self.auImageV.frame = CGRectMake(width/20, 5, self.leftV.height - 15, self.leftV.height - 15);
    self.auImageV.layer.cornerRadius = self.auImageV.height/2;
    self.auImageV.layer.masksToBounds = YES;
    
    self.auL.frame = CGRectMake(self.auImageV.x + self.auImageV.width + 10, self.auImageV.y, width/2 - (self.auImageV.x + self.auImageV.width + 10), self.auImageV.height);
    self.auL.font = [UIFont systemFontOfSize:14];
    
    self.rightV.frame = CGRectMake(width/2, 0, width/2, self.leftV.height);
    self.tiL.frame = CGRectMake(self.rightV.width - 50, 5, 50, self.rightV.height - 5);
    self.tiL.text = @"专题";
    self.tiL.textColor = JwBColor;
    self.tiL.textAlignment = NSTextAlignmentCenter;
    self.tiL.font = [UIFont systemFontOfSize:11];
    
    self.topL.frame = CGRectMake(0, 5, self.rightV.width - self.tiL.width, self.tiL.height);
    self.topL.textColor = JwColor(110, 110, 110);
    self.topL.font = [UIFont systemFontOfSize:12];
    self.topL.textAlignment = NSTextAlignmentRight;
    
    self.conImageV.frame = CGRectMake(0, self.leftV.height, width, height - self.leftV.height - 15);
    
    self.conL.frame = CGRectMake(width/20, self.conImageV.height + self.conImageV.y - 30, width - width/10, 30);
    self.conL.textColor = [UIColor whiteColor];
    self.conL.font = [UIFont systemFontOfSize:16];
    
    self.changeV.frame = CGRectMake(0, self.conImageV.height + self.conImageV.y - 30, width, 30);
    self.changeV.alpha = 0.3;
    self.changeV.backgroundColor = JwColor(80, 80, 80);
    
    self.leftV.backgroundColor = JwColor(252, 252, 252);
    self.rightV.backgroundColor = JwColor(252, 252, 252);
}

//- (CAGradientLayer *)shadowAsInverse
//{
//    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
//    CGRect newShadowFrame = CGRectMake(0, self.conImageV.height + self.conImageV.y - 30, self.contentView.width, 30);
//    newShadow.frame = newShadowFrame;
//
//    newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,(id)JwColor(100, 100, 100).CGColor,nil];
//    return newShadow;
//}

- (void)setComic:(JwComic *)comic{
    _comic = comic;
    
    [self.auImageV sd_setImageWithURL:[NSURL URLWithString:self.comic.JwTopic.JwUser.avatar_url] placeholderImage:nil];
    self.auL.text = self.comic.JwTopic.JwUser.nickname;
    self.topL.text = self.comic.JwTopic.title;
  
    [self.conImageV sd_setImageWithURL:[NSURL URLWithString:self.comic.cover_image_url] placeholderImage:nil];
    self.conL.text = self.comic.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
