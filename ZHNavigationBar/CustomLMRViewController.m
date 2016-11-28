//
//  CustomLMRViewController.m
//  ZHNavigationBar
//
//  Created by walen on 16/11/25.
//  Copyright © 2016年 walen. All rights reserved.
//

#import "CustomLMRViewController.h"
#import "ZHNavigationBar.h"

@interface CustomLMRViewController ()

@end

@implementation CustomLMRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor redColor];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    //设置自定义的摆放位置
    leftButton.zh_navigationFrame = CGRectMake(0, 0, 60, 44);
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //设置左侧的自定义控件
    self.zh_navigationLeftView = leftButton;
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor redColor];
    [rightButton setTitle:@"右侧按钮" forState:UIControlStateNormal];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat buttonW = 80;
    //设置自定义的摆放位置
    rightButton.zh_navigationFrame = CGRectMake(screenW - buttonW, 0, buttonW, 44);
    //设置左侧的自定义控件
    self.zh_navigationRightView = rightButton;
    
    UIButton *titleView = [UIButton buttonWithType:UIButtonTypeCustom];
    titleView.backgroundColor = [UIColor redColor];
    [titleView setTitle:@"标题" forState:UIControlStateNormal];
    
    //设置自定义的摆放位置
    titleView.zh_navigationFrame = CGRectMake((screenW - 200) / 2, 0, 200, 44);
    //设置左侧的自定义控件
    self.zh_navigationTitleView = titleView;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
