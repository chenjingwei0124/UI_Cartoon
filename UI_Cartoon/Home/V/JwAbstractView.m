//
//  JwAbstractView.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwAbstractView.h"
#import "JwComic.h"
#import "JwTopic.h"
#import "JwAcer.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "JwUser.h"

@interface JwAbstractView ()

@property (nonatomic, strong)UIView *backsV;
@property (nonatomic, strong)UIView *backxV;
@property (nonatomic, strong)UILabel *desL;

@property (nonatomic, strong)UIImageView *autV;
@property (nonatomic, strong)UILabel *autL;
@end

@implementation JwAbstractView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JwColor(236, 236, 236);
        
        self.backsV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, 0))];
        [self addSubview:self.backsV];
        self.backsV.backgroundColor = [UIColor whiteColor];
        
        self.desL = [[UILabel alloc] initWithFrame:(CGRectMake(frame.size.width/20, frame.size.width/20, frame.size.width - frame.size.width/10, 0))];
        self.desL.textColor = JwZColor;
        self.desL.font = [UIFont systemFontOfSize:15];
        self.desL.numberOfLines = 0;
        [self.backsV addSubview:self.desL];
        [self addSubview:self.backsV];
        
        self.backxV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.width/7))];
        [self addSubview:self.backxV];
        self.backxV.backgroundColor = [UIColor whiteColor];
        
        self.autV = [[UIImageView alloc] initWithFrame:(CGRectMake(frame.size.width/20, 5, self.backxV.height - 10, self.backxV.height - 10))];
        self.autV.layer.cornerRadius = self.autV.height/2;
        self.autV.layer.masksToBounds = YES;
        [self.backxV addSubview:self.autV];
        
        self.autL = [[UILabel alloc] initWithFrame:(CGRectMake(self.autV.x + self.autV.width + 10, self.autV.y, frame.size.width/2, self.autV.height))];
        self.autL.textColor = [UIColor blackColor];
        self.autL.font = [UIFont systemFontOfSize:15];
        [self.backxV addSubview:self.autL];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:(CGRectMake(self.backxV.width - 40, 0, 40, 40))];
        img.centerY = self.backxV.centerY;
        img.image = [UIImage imageNamed:@"icon_rig"];
        [self.backxV addSubview:img];
        
        [self.backxV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backxVAction:)]];

    }
    return self;
}

- (void)backxVAction:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"author" object:self.comic];
}

- (void)setComic:(JwComic *)comic{
    _comic = comic;
    self.desL.text = self.comic.JwTopic.JwDescription;
    [self.desL sizeToFit];
    self.backsV.height = self.desL.height + self.width/10;
    
    UIView *lin = [[UIView alloc] initWithFrame:(CGRectMake(0, self.backsV.height, self.width, 1))];
    lin.backgroundColor = [UIColor blackColor];
    [self addSubview:lin];
    
    self.backxV.y = self.backsV.height + 1;
    [self.autV sd_setImageWithURL:[NSURL URLWithString:self.comic.JwTopic.JwUser.avatar_url] placeholderImage:nil];
    self.autL.text = self.comic.JwTopic.JwUser.nickname;
}


@end
