//
//  JwComic.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwComic.h"
#import "JwTopic.h"

@implementation JwComic

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.uId = [value stringValue];
    }
    if ([key isEqualToString:@"topic_id"]) {
        self.topicId = [value stringValue];
    }
    if ([key isEqualToString:@"topic"]) {
        self.JwTopic = [[JwTopic alloc] init:value];
    }
    if ([key isEqualToString:@"likes_count"]) {
        self.like_count = [value stringValue];
    }
}

@end
