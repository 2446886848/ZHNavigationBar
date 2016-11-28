//
//  CustomRightViewController.m
//  ZHNavigationBar
//
//  Created by walen on 16/11/25.
//  Copyright © 2016年 walen. All rights reserved.
//

#import "CustomRightViewController.h"
#import "ZHNavigationBar.h"

@interface CustomRightViewController ()

@end

@implementation CustomRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor redColor];
    [rightButton setTitle:@"返回" forState:UIControlStateNormal];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat buttonW = 60;
    //设置自定义的摆放位置
    rightButton.zh_navigationFrame = CGRectMake(screenW - buttonW, 0, buttonW, 44);
    [rightButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //设置左侧的自定义控件
    self.zh_navigationRightView = rightButton;
    NSLog(@"navivationbar = %@", self.navigationController.navigationBar);
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
