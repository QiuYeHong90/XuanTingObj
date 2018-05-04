//
//  HomeNavView.h
//  QiuRongShop
//
//  Created by 赵 on 2018/4/27.
//  Copyright © 2018年 袁书辉. All rights reserved.
//



#import "TopHoverView.h"
#import <UIKit/UIKit.h>



@interface HomeNavView : UIView<TopHoverViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (weak, nonatomic) IBOutlet UIButton *navLfetBtn;

@property (weak, nonatomic) IBOutlet UIView *bgView;

//第二层顶部距离

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navTop2;
@property (weak, nonatomic) IBOutlet UIView *navTBarView;

/**
 搜索按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
//关键字搜索
@property (weak, nonatomic) IBOutlet UICollectionView *kewWordsCollView;
//34
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *kewWordsFlowLayout;
+(instancetype)initWithNib;

+(CGFloat)statsHeight;
@end
