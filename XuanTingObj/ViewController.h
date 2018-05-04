//
//  ViewController.h
//  XuanTingDemo
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 袁书辉. All rights reserved.
//

#import "TopHoverView.h"
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet TopHoverView *hoverView;

@end

