//
//  ZHCustomNavigationBar.h
//  ZHNavigationBar
//
//  Created by walen on 16/11/28.
//  Copyright © 2016年 walen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHCustomNavigationBar : UINavigationBar

/**
 处理一个控制器 定制它的NavigationBar
 
 @param vc 需要处理的控制器
 */
+ (void)zh_manageNavigationBarForViewController:(UIViewController *)vc;

@end
