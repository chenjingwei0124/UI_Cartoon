//
//  JwUser.h
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JwUser : NSObject

- (instancetype)init:(id)value;

@property (nonatomic, copy)NSString *avatar_url;
@property (nonatomic, copy)NSString *uId;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *reg_type;

@property (nonatomic, copy)NSString *weibo_name;
@end
