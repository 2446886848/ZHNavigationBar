//
//  UIView+ZHNavigationBar.m
//  ZHNavigationBar
//
//  Created by walen on 16/11/25.
//  Copyright © 2016年 walen. All rights reserved.
//

#import "UIView+ZHNavigationBar.h"
#import <objc/runtime.h>

@implementation UIView (ZHNavigationBar)

- (CGRect)zh_navigationFrame
{
    return [objc_getAssociatedObject(self, @selector(zh_navigationFrame)) CGRectValue];
}

- (void)setZh_navigationFrame:(CGRect)zh_navigationFrame
{
    objc_setAssociatedObject(self, @selector(zh_navigationFrame), [NSValue valueWithCGRect:zh_navigationFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
