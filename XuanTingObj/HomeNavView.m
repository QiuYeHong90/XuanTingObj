//
//  HomeNavView.m
//  QiuRongShop
//
//  Created by 赵 on 2018/4/27.
//  Copyright © 2018年 袁书辉. All rights reserved.
//
#import "XuanTingObj-Bridging-Header.h"
#import "XuanTingObj-Swift.h"
#import "HomeNavView.h"

#define IS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height == 812.0)

@interface HomeNavView()
@property (weak, nonatomic) IBOutlet UIView *kewordsBgView;

@property (weak, nonatomic) IBOutlet UIView *searchView;

@end

@implementation HomeNavView

+(instancetype)initWithNib
{
    
    HomeNavView * view  = [[NSBundle mainBundle]loadNibNamed:@"HomeNavView" owner:self options:nil][0];
    
    return view;
}
- (IBAction)bigBtnClick:(id)sender {
    [self.navLfetBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
}
+(CGFloat)statsHeight
{
    if (IS_IPHONE_X) {
        return 44;
    }
    return 20;
}

-(void)topHoverView:(NSObject *)hoverView rate:(CGFloat)rate
{
    NSLog(@"%f",rate);
    self.navTBarView.alpha = fmin(rate, 1);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
