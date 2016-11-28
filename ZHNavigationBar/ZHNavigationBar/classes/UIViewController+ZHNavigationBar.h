//
//  UIViewController+ZHNavigationBar.h
//  ZHNavigationBar
//
//  Created by walen on 16/11/25.
//  Copyright © 2016年 walen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ZHNavigationBar.h"

@interface UIViewController (ZHNavigationBar)

/**
 导航栏左侧按钮对应leftBarButtonItem
 */
@property (nonatomic, strong) UIView *zh_navigationLeftView;

/**
 导航栏右侧按钮对应rightBarButtonItem
 */
@property (nonatomic, strong) UIView *zh_navigationRightView;

/**
 导航栏标题按钮对应titleView
 */
@property (nonatomic, strong) UIView *zh_navigationTitleView;

/**
 自定义的导航栏，默认会隐藏系统的导航栏
 */
@property (nonatomic, strong) UIView *zh_customTopBar;

@end
