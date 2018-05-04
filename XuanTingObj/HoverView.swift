//
//  HoverView.swift
//  SwiftDemo
//
//  Created by 赵 on 2018/5/2.
//  Copyright © 2018年 袁书辉. All rights reserved.
//

//#define IS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height == 812.0)



import UIKit

@objc protocol HoverViewDelete {
    //    -(void)topHoverView:(TopHoverView *)hoverView rate:(CGFloat)rate
    func topHoverView(hoverView:NSObject,rate:CGFloat) ;
}

class HoverView: UIView {
    let IS_IPHONE_X  = UIScreen.main.bounds.size.height ==  812.0 
    var headView:UIView!
    var scrollView:UIScrollView!
    var  MaxH:CGFloat!=0
    var MinH:CGFloat! = 0
    var scrollViewOffset:NSObject?
    
    
    
    
    @objc public func setInitHoverView(headView:UIView,scrollView:UIScrollView,MaxH:CGFloat,MinH:CGFloat)
    {
        
        self.MaxH = MaxH
        self.MinH = MinH
        self.scrollView = scrollView
        self.headView = headView
        
        self.scrollView.removeFromSuperview()
        self.headView.removeFromSuperview()
        
        self.addSubview(self.scrollView)
        self.addSubview(self.headView)
        
        self.headView.mas_makeConstraints({ (make:MASConstraintMaker!)in
            make.top.mas_equalTo()(0)
            make.left.mas_equalTo()(0)
            make.right.mas_equalTo()(0)
            make.height.mas_equalTo()(MaxH)
        })
        
    self.scrollView.mas_makeConstraints({ (make:MASConstraintMaker!)in
            make.top.mas_equalTo()(0)
            make.left.mas_equalTo()(0)
            make.right.mas_equalTo()(0)
            make.bottom.mas_equalTo()(0)
        })
        
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        self.scrollView.contentInset.top = self.MaxH
        
        self.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: &scrollViewOffset)
        
        
        self.scrollView.mj_header.ignoredScrollViewContentInsetTop = self.MaxH;
        self.scrollView.contentInset = UIEdgeInsetsMake(self.MaxH, 0, 0, 0);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &scrollViewOffset {
            let scrollView:UIScrollView = object as! UIScrollView
            let y:CGFloat = scrollView.contentOffset.y
//            初始值 为 -100 M
            var offy = y+self.MaxH
            
            
            let minOf:CGFloat = self.MaxH - self.MinH
            offy = fmin(offy,minOf)
            
            print(minOf,offy,1-offy/minOf)
            self.headView.mas_updateConstraints { (make) in
                make?.top.equalTo()(-offy)
            }
            
            
            let hdView:HomeNavView = self.headView as! HomeNavView;
            
            if hdView.responds(to: #selector(TopHoverViewDelegate.topHoverView(_:rate:)
                ))
            {
                
                hdView.topHoverView(self, rate: 1-offy/minOf)
            }
            
            
            self.headView.setNeedsUpdateConstraints()
            self.headView.updateConstraints()
            self.layoutIfNeeded()
            
        }
    }
    
    func statsHeight() -> CGFloat {
        if (IS_IPHONE_X) {
            return 44;
        }
        return 20;
    }

}

