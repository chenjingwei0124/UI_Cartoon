//
//  JwFonTopic.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwFonTopic.h"
#import "JwTopic.h"

@implementation JwFonTopic

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"type"]) {
        self.JwType = [value stringValue];
    }
    if ([key isEqualToString:@"topics"]) {
        NSArray *arr = value;
        self.topicArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            JwTopic *topic = [[JwTopic alloc] init:dic];
            [self.topicArr addObject:topic];
        }
    }
}

@end
