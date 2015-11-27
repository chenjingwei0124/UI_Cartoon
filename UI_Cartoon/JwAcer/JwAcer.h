//
//  JwAcer.h
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

//RGB颜色
#define JwColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JwBColor JwColor(245, 210, 80)

#define JwZColor JwColor(85, 85, 85)

//获取屏幕 宽度、高度
#define Screen_Frame ([UIScreen mainScreen].applicationFrame)
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)