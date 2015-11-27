//
//  JwFound.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/9.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwFound.h"

@implementation JwFound

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"priority"]) {
        self.JwPriority = [value stringValue];
    }
    if ([key isEqualToString:@"tag_id"]) {
        self.JwTag_id = [value stringValue];
    }
}

@end
