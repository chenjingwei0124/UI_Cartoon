//
//  JwDetailView.h
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JwComic;

@interface JwDetailView : UIView

@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)JwComic *comic;
@property (nonatomic, strong)UITableView *tableV;
@end
