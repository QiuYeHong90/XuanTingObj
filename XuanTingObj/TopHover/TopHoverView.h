//
//  TopHoverView.h
//  XuanTingDemo
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 袁书辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TopHoverViewDelegate;

@interface TopHoverView : UIView



@property (nonatomic,strong,readonly) UIScrollView * contentView;
@property (nonatomic,strong,readonly) UIView <TopHoverViewDelegate>* headerView;
// 悬停控件的最大高度 44+44+34 默认值
@property (nonatomic,assign,readonly) CGFloat headerViewMax_h;
//悬停控件的最小高度  44+34 默认值
@property (nonatomic,assign,readonly) CGFloat headerViewMin_h;


/**
 初始化设置

 @param headerView 顶部悬浮视图
 @param contentView 滚动视图
 @param headerViewMax_h 最大高度
 @param headerViewMin_h 最小高度
 */
-(void)setHeaderView:(UIView <TopHoverViewDelegate>*)headerView
         contentView:(UIScrollView *)contentView
     headerViewMax_h:(CGFloat)headerViewMax_h
     headerViewMin_h:(CGFloat)headerViewMin_h;
-(void)reloadUI;
@end

@protocol TopHoverViewDelegate <NSObject>

/**
 从最大高度到最小值得变化率

 @param hoverView 父视图顶部悬浮
 @param rate 大高度到最小值得变化率 0代表最小值 1最大值 大于1 都是最大值
 */
-(void)topHoverView:(NSObject *)hoverView rate:(CGFloat)rate;


/**
 获取状态栏的高度适配iPhoneX

 @return 状态栏的高度
 */
+(CGFloat)statsHeight;

@end

