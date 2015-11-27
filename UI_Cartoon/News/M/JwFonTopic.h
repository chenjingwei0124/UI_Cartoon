//
//  JwFonTopic.h
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JwTopic;

@interface JwFonTopic : NSObject

@property (nonatomic, copy)NSString *action;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSMutableArray *topicArr;

@property (nonatomic, copy)NSString *JwType;

@end

