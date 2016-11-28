//
//  UIViewController+ZHNavigationBar.m
//  ZHNavigationBar
//
//  Created by walen on 16/11/25.
//  Copyright © 2016年 walen. All rights reserved.
//

#import "UIViewController+ZHNavigationBar.h"
#import <objc/runtime.h>
#import "ZHCustomNavigationBar.h"

@implementation UIViewController (ZHNavigationBar)

- (UIView *)zh_navigationLeftView
{
    return self.navigationItem.leftBarButtonItem.customView;
}

- (void)setZh_navigationLeftView:(UIView *)zh_navigationLeftView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:zh_navigationLeftView];
    [self zh_setupNavigationBar];
}

- (UIView *)zh_navigationRightView
{
    return self.navigationItem.rightBarButtonItem.customView;
}

- (void)setZh_navigationRightView:(UIView *)zh_navigationRightView
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:zh_navigationRightView];
    [self zh_setupNavigationBar];
}

- (UIView *)zh_navigationTitleView
{
    return self.navigationItem.titleView;
}

- (void)setZh_navigationTitleView:(UIView *)zh_navigationTitleView
{
    self.navigationItem.titleView = zh_navigationTitleView;
    [self zh_setupNavigationBar];
}

/**
 当前类是否已经被替换过函数
 */
+ (BOOL)zh_methodSwizzed
{
    return [objc_getAssociatedObject(self, @selector(zh_methodSwizzed)) boolValue];
}

+ (void)setZh_methodSwizzed:(BOOL)zh_methodSwizzed
{
    objc_setAssociatedObject(self, @selector(zh_methodSwizzed), @(zh_methodSwizzed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)zh_customTopBar
{
    return objc_getAssociatedObject(self, @selector(zh_customTopBar));
}

- (void)setZh_customTopBar:(UIView *)zh_customTopBar
{
    objc_setAssociatedObject(self, @selector(zh_customTopBar), zh_customTopBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //添加自定义顶部栏到view
    [self.view addSubview:zh_customTopBar];
    [self zh_setupViewAppearFunc];
}

/**
 利用运行时将当前类的viewWillAppear和viewWillDisappear替换，然后进行相应的自定义导航栏处理
 */
- (void)zh_setupViewAppearFunc
{
    //已经处理过了 不用再次替换函数
    if (self.class.zh_methodSwizzed) {
        return;
    }
    Method navigationedViewWillAppearMethod = class_getInstanceMethod(self.class, @selector(navigation_viewWillAppear:));
    Method navigationedViewWillDisappearMethod = class_getInstanceMethod(self.class, @selector(navigation_viewWillDisappear:));
    
    //处理viewWillAppear
    if (!class_addMethod(self.class, @selector(viewWillAppear:), method_getImplementation(navigationedViewWillAppearMethod), method_getTypeEncoding(navigationedViewWillAppearMethod))) {
        
        //添加不成功，说明当前类有viewWillAppear：函数，因此只需要替换实现地址即可
        method_exchangeImplementations(navigationedViewWillAppearMethod, class_getInstanceMethod(self.class, @selector(viewWillAppear:)));
    }
    else
    {
        //如果添加成功 说明当前类没有viewWillAppear：方法，因此需要把navigation_viewWillAppear：的执行地址指向父类的viewWillAppear：地址
        class_addMethod(self.class, @selector(navigation_viewWillAppear:), class_getMethodImplementation(class_getSuperclass(self.class), @selector(viewWillAppear:)), method_getTypeEncoding(navigationedViewWillAppearMethod));
    }
    
    //处理WillDisappear
    if (!class_addMethod(self.class, @selector(viewWillDisappear:), method_getImplementation(navigationedViewWillDisappearMethod), method_getTypeEncoding(navigationedViewWillDisappearMethod))) {
        
        //添加不成功，说明当前类有WillDisappear：函数，因此只需要替换实现地址即可
        method_exchangeImplementations(navigationedViewWillDisappearMethod, class_getInstanceMethod(self.class, @selector(viewWillDisappear:)));
    }
    else
    {
        //如果添加成功 说明当前类没有WillDisappear：方法，因此需要把navigation_viewWillDisappear：的执行地址指向父类的WillDisappear：地址
        class_addMethod(self.class, @selector(navigation_viewWillDisappear:), class_getMethodImplementation(class_getSuperclass(self.class), @selector(viewWillDisappear:)), method_getTypeEncoding(navigationedViewWillDisappearMethod));
    }
    
    self.class.zh_methodSwizzed = YES;
}

- (void)navigation_viewWillAppear:(BOOL)animated
{
    [self navigation_viewWillAppear:animated];
    if (self.zh_customTopBar) {
        [self.view bringSubviewToFront:self.zh_customTopBar];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)navigation_viewWillDisappear:(BOOL)animated
{
    [self navigation_viewWillDisappear:animated];
    if (self.zh_customTopBar) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

/**
 设置当前导航栏为ZHNavigationBar类以进行frame调整功能
 */
- (void)zh_setupNavigationBar
{
    [ZHCustomNavigationBar zh_manageNavigationBarForViewController:self];
}

@end
