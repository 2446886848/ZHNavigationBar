//
//  UINavigationBar+Appearance.m
//  ZHNavigationBar
//
//  Created by walen on 16/11/28.
//  Copyright © 2016年 walen. All rights reserved.
//

#import "UINavigationBar+Appearance.h"

@implementation UINavigationBar (Appearance)

/**
 设置背景色为透明
 */
- (void)zh_backgroundClear
{
    void(^setBlock)() = ^{
        //获取一个透明的图片
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(5, 5), NO, [UIScreen mainScreen].scale);
        UIImage *clearImage = UIGraphicsGetImageFromCurrentImageContext();
        [self setBackgroundImage:clearImage forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:clearImage];
    };
    if ([NSThread isMainThread]) {
        setBlock();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), setBlock);
    }
}

- (void)zh_setBackIndicatorImage:(UIImage *)backIndicatorImage
{
    NSParameterAssert(backIndicatorImage);
    //修改导航栏返回按钮的图标
    [self setBackIndicatorImage:backIndicatorImage];
    [self setBackIndicatorTransitionMaskImage:backIndicatorImage];
}

@end
