//
//  JwScolCell.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwScolCell.h"
#import "UIView+Extension.h"
#import "JwTopic.h"
#import "JwUser.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "JwAcer.h"

@interface JwScolCell ()

@property (nonatomic, strong)UIImageView *headImg;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *nameL;
@property (nonatomic, strong)UIView *popV;
@end

@implementation JwScolCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.headImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height))];
        [self addSubview:self.headImg];
        
        self.popV = [[UIView alloc] init];
        [self.headImg addSubview:self.popV];
        [self.popV.layer addSublayer:[self shadowAsInverse]];
        
        self.titleL = [[UILabel alloc] initWithFrame:(CGRectMake(self.headImg.width/15, self.headImg.height - 40, self.headImg.width - frame.size.width/15 * 2, 20))];
        self.titleL.textColor = [UIColor whiteColor];
        self.titleL.font = [UIFont systemFontOfSize:14 weight:0.2];
        [self.headImg addSubview:self.titleL];
        
        self.nameL = [[UILabel alloc] initWithFrame:(CGRectMake(self.titleL.x, self.titleL.y + self.titleL.height, self.titleL.width, 20))];
        self.nameL.font = [UIFont systemFontOfSize:12];
        self.nameL.textColor = [UIColor whiteColor];
        [self.headImg addSubview:self.nameL];
        
    }
    return self;
}

- (void)setTopic:(JwTopic *)topic{
    _topic = topic;
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.topic.vertical_image_url] placeholderImage:nil];
    self.titleL.text = self.topic.title;
    self.nameL.text = self.topic.JwUser.nickname;
}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = (CGRectMake(0, self.headImg.height - 40, self.headImg.width, 40));
    newShadow.frame = newShadowFrame;
    newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,(id)JwColor(100, 100, 100).CGColor,nil];
    return newShadow;
}


@end
