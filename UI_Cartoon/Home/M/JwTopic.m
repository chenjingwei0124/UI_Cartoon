//
//  JwTopic.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwTopic.h"
#import "JwUser.h"

@implementation JwTopic

- (instancetype)init:(id)value{
    self = [super init];
    if (self!= nil) {
        [self setValuesForKeysWithDictionary:value];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.uId = [value stringValue];
    }
    if ([key isEqualToString:@"likes_count"]) {
        self.JwLikes = [value stringValue];
    }
    if ([key isEqualToString:@"description"]) {
        self.JwDescription = value;
    }
    if ([key isEqualToString:@"user"]) {
        self.JwUser = [[JwUser alloc] init:value];
    }
}

@end
