
//
//  ZHCustomNavigationBar.m
//  ZHNavigationBar
//
//  Created by walen on 16/11/28.
//  Copyright © 2016年 walen. All rights reserved.
//

#import "ZHCustomNavigationBar.h"
#import "UIView+ZHNavigationBar.h"
#import <objc/runtime.h>

static NSString *kNavigationBarPrefix = @"ZHNavigationBar_";
static NSString *kNavigationBarOriginClass = @"ZHNavigationBarOriginClass";

@interface UINavigationBar (ZHNavigationBar)

/**
 当前类作用的控制器
 */
@property (class, nonatomic, strong, readonly) NSHashTable<UIViewController *> *zh_hookedViewControllers;

@end

@implementation UINavigationBar (ZHNavigationBar)

+ (NSHashTable<UIViewController *> *)zh_hookedViewControllers
{
    NSHashTable *hashTable = objc_getAssociatedObject(self, @selector(zh_hookedViewControllers));
    if (!hashTable) {
        hashTable = [NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(self, @selector(zh_hookedViewControllers), hashTable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return hashTable;
}

@end

@implementation ZHCustomNavigationBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UINavigationItem *navigationItem = [self topItem];
    UIView *leftview  = [[navigationItem leftBarButtonItem] customView];
    UIView *rightView = [[navigationItem rightBarButtonItem] customView];
    
    if (!CGRectIsEmpty(leftview.zh_navigationFrame)) {
        leftview.frame = leftview.zh_navigationFrame;
    }
    if (!CGRectIsEmpty(rightView.zh_navigationFrame)) {
        rightView.frame = rightView.zh_navigationFrame;
    }
    if (!CGRectIsEmpty(navigationItem.titleView.zh_navigationFrame)) {
        navigationItem.titleView.frame = navigationItem.titleView.zh_navigationFrame;
    }
}

- (Class)class
{
    return objc_getAssociatedObject(self, &kNavigationBarOriginClass);
}

+ (Class)zh_createClassForSuperClass:(Class)superClass
{
    NSString *superClassName = NSStringFromClass(superClass);
    NSString *createdClassName = [kNavigationBarPrefix stringByAppendingString:superClassName];
    Class createdClass = NSClassFromString(createdClassName);
    
    //如果存在 则直接返回已经存在的类
    if (createdClass) {
        return createdClass;
    }
    
    //获取当前类的layoutSubviews函数信息
    Method selfLayoutSubviewsMethod = class_getInstanceMethod(self, @selector(layoutSubviews));
    IMP selfLayoutSubviewsImp = method_getImplementation(selfLayoutSubviewsMethod);
    const char* selfLayoutSubviewsTypes = method_getTypeEncoding(selfLayoutSubviewsMethod);
    
    //获取当前类的class函数信息
    Method selfClassMethod = class_getInstanceMethod(self, @selector(class));
    IMP selfClassImp = method_getImplementation(selfClassMethod);
    const char* selfClassTypes = method_getTypeEncoding(selfClassMethod);
    
    //注册一个新类
    createdClass = objc_allocateClassPair(superClass, createdClassName.UTF8String, 0);
    
    //增加layoutSubviews函数
    class_addMethod(createdClass, @selector(layoutSubviews), selfLayoutSubviewsImp, selfLayoutSubviewsTypes);
    
    //增加class函数
    class_addMethod(createdClass, @selector(class), selfClassImp, selfClassTypes);
    
    objc_registerClassPair(createdClass);
    
    return createdClass;
}

/**
 处理一个控制器 定制它的NavigationBar
 */
+ (void)zh_manageNavigationBarForViewController:(UIViewController *)vc;
{
    NSParameterAssert(vc != nil);
    
    UINavigationBar *navigationBar = vc.navigationController.navigationBar;
    //获取需要生成的类
    Class navigationBarClass = object_getClass(navigationBar);
    NSString *navigationBarClassName = NSStringFromClass(navigationBarClass);
    
    //如果当前对象已经是重新生成的类的对象
    if ([navigationBarClassName hasPrefix:kNavigationBarPrefix]) {
        [navigationBarClass.zh_hookedViewControllers addObject:vc];
        return;
    }
    
    Class createdClass = [self zh_createClassForSuperClass:navigationBarClass];
    //设置当前对象的原始类
    objc_setAssociatedObject(navigationBar, &kNavigationBarOriginClass, navigationBarClass, OBJC_ASSOCIATION_ASSIGN);
    
    object_setClass(navigationBar, createdClass);
    [createdClass.zh_hookedViewControllers addObject:vc];
}

@end
