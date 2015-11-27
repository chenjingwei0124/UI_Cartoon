//
//  JwBanner.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwBanner.h"

@implementation JwBanner

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"type"]) {
        self.JwType = [value stringValue];
    }
}

@end
