//
//  TopHoverView.m
//  XuanTingDemo
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 袁书辉. All rights reserved.
//

#import <MJRefresh.h>
#import <Masonry.h>
#import "TopHoverView.h"
#define IS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height == 812.0)


static void * SwipeTableViewItemContentOffsetContext   = &SwipeTableViewItemContentOffsetContext;
@implementation TopHoverView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initComon];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initComon];
    }
    return self;
}

-(void)initComon
{
    self.backgroundColor = [UIColor redColor];
    _headerViewMax_h = 44+44+34;
    _headerViewMin_h = 44+34;
   
}

-(void)setContentView:(UIScrollView *)contentView
{
    if (_contentView!=contentView) {
        [_contentView removeObserver:self forKeyPath:@"contentOffset"  context:SwipeTableViewItemContentOffsetContext];
        _contentView = contentView;
        [contentView removeFromSuperview];
        [self addSubview:contentView];
        __weak typeof(self) weakSelf = self;
       
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf);
             make.left.equalTo(weakSelf);
             make.right.equalTo(weakSelf);
             make.bottom.equalTo(weakSelf);
            
        }];
        
        if (@available(iOS 11.0, *)) {
            contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
       
         [contentView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:SwipeTableViewItemContentOffsetContext];
    }
    
    
}

-(void)setHeaderView:(UIView <TopHoverViewDelegate>*)headerView
{
    if (_headerView!= headerView) {
        _headerView = headerView;
//        _headerView.frame = CGRectMake(0,0,self.bounds.size.width,_headerView.bounds.size.height);
//        [headerView removeFromSuperview];
        [self addSubview:headerView];
        __weak typeof(self) weakSelf = self;

        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf);
            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.height.equalTo(@(self.headerViewMax_h));
        }];

    }
}

-(void)setHeaderView:(UIView <TopHoverViewDelegate>*)headerView
         contentView:(UIScrollView *)contentView
     headerViewMax_h:(CGFloat)headerViewMax_h
     headerViewMin_h:(CGFloat)headerViewMin_h

{
    _headerViewMin_h = headerViewMin_h;
    _headerViewMax_h = headerViewMax_h;
    self.contentView = contentView;
    self.headerView = headerView;
   
    
    [self reloadUI];
    
}

-(void)reloadUI
{
    
    self.contentView.mj_header.ignoredScrollViewContentInsetTop = _headerViewMax_h;
    self.contentView.contentInset = UIEdgeInsetsMake(_headerViewMax_h, 0, 0, 0);
}
#pragma mark - observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == SwipeTableViewItemContentOffsetContext) {
        UIScrollView * scrollView = object;
        CGFloat y  =  scrollView.contentOffset.y;
        CGFloat y_f  = y+ _headerViewMax_h;
        
        CGFloat topMinOffset = _headerViewMin_h ;
        
        CGFloat topMarginOffset = _headerViewMax_h;
        CGFloat y_min = topMinOffset -topMarginOffset;
        // stick the bar
        
        CGFloat offset_y ;
        if (y < - topMarginOffset) {

            offset_y = -y_f;
            [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(-y_f);
            }];
        }else {
            if (y< -topMinOffset) {

                offset_y = -y_f;
                [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(-y_f);
                }];
            }else{
//                可以不重新赋值了
                offset_y = y_min;
                
            }
            
            
        }
        
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(offset_y);
        }];
       
        // 告诉self.view约束需要更新
        [self.headerView setNeedsUpdateConstraints];
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        [self.headerView updateConstraintsIfNeeded];
        
        //    这一点被我弄糊涂了 不管是mansory 还是xib约束 更新尺寸都得 layoutIfNeeded
        [self layoutIfNeeded];
        
        
        CGFloat rate = 1-offset_y/y_min;
        
        UIView <TopHoverViewDelegate>* headView = self.headerView;
        if (headView) {
            if ([headView respondsToSelector:@selector(topHoverView:rate:)]) {
                [headView topHoverView:self rate:rate];
            }
        }
        
        
 
    }

}

+(CGFloat)statsHeight
{
    if (IS_IPHONE_X) {
        return 44;
    }
    return 20;
}
@end



