//
//  JwComic.h
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JwTopic;

@interface JwComic : NSObject

@property (nonatomic, copy)NSString *uId;
@property (nonatomic, copy)NSString *topicId;
@property (nonatomic, copy)NSString *cover_image_url;
@property (nonatomic, copy)NSString *like_count;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *url;

@property (nonatomic, strong)JwTopic *JwTopic;

@end
