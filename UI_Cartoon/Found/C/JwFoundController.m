//
//  JwFoundController.m
//  UI_Cartoon
//
//  Created by lanou on 15/11/6.
//  Copyright © 2015年 陈警卫. All rights reserved.
//

#import "JwFoundController.h"
#import "UIView+Extension.h"
#import "JwFoundCell.h"
#import "NetHandler.h"
#import "JwFound.h"
#import "JwFoundListController.h"

@interface JwFoundController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectV;
@property (nonatomic, strong)NSMutableArray *array;
@end

@implementation JwFoundController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleL.text= @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.width/4, self.view.width/3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(self.view.width/30, self.view.width/30, self.view.width/30, self.view.width/30);
    
    self.collectV = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64 - 44)) collectionViewLayout:layout];
    self.collectV.dataSource = self;
    self.collectV.delegate = self;
    self.collectV.backgroundColor = [UIColor whiteColor];
    [self.collectV registerClass:[JwFoundCell class] forCellWithReuseIdentifier:@"foundCell"];
    [self.view addSubview:self.collectV];
    
    [self foundHandel];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JwFoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foundCell" forIndexPath:indexPath];
    cell.found = self.array[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JwFoundListController *foundListVC = [[JwFoundListController alloc] init];
    JwFound *found = self.array[indexPath.item];
    foundListVC.foundTitle = found.title;
    [self.navigationController pushViewController:foundListVC animated:YES];
}

- (void)foundHandel{
    self.array = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:@"http://api.kuaikanmanhua.com/v1/tag/suggestion" completion:^(NSData *data) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
//        NSLog(@"%@", dic1);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSDictionary *dic2 = [dic1 objectForKey:@"data"];
            NSArray *arr1 =[dic2 objectForKey:@"suggestion"];
            
            for (NSDictionary *dic3 in arr1) {
                JwFound *found = [[JwFound alloc] init];
                [found setValuesForKeysWithDictionary:dic3];
                [self.array addObject:found];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"%@", self.array);
                [self.collectV reloadData];
            });
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
