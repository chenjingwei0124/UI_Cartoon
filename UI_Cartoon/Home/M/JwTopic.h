//
//  JwTopic.h
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JwUser;

@interface JwTopic : NSObject

- (instancetype)init:(id)value;

@property (nonatomic, copy)NSString *uId;
@property (nonatomic, copy)NSString *cover_image_url;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *JwDescription;
@property (nonatomic, copy)NSString *vertical_image_url;
@property (nonatomic, copy)NSString *JwLikes;

@property (nonatomic, strong)JwUser *JwUser;
@end
