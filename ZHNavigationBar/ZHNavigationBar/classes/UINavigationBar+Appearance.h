//
//  UINavigationBar+Appearance.h
//  ZHNavigationBar
//
//  Created by walen on 16/11/28.
//  Copyright © 2016年 walen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Appearance)

/**
 设置背景色为透明
 */
- (void)zh_backgroundClear;

/**
 自定义返回按钮的图片

 @param backIndicatorImage 返回按钮的图片
 */
- (void)zh_setBackIndicatorImage:(UIImage *)backIndicatorImage;

@end
