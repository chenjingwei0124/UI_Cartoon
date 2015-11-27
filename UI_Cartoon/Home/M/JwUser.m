//
//  JwUser.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwUser.h"

@implementation JwUser

- (instancetype)init:(id)value{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:value];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.uId = [value stringValue];
    }
}

@end
