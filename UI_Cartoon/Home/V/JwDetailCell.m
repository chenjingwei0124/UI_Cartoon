//
//  JwDetailCell.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwDetailCell.h"
#import "UIView+Extension.h"

@interface JwDetailCell ()

@end

@implementation JwDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.cmicImV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.cmicImV];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.cmicImV.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
