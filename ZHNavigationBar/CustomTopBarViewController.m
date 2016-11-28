//
//  CustomTopBarViewController.m
//  ZHNavigationBar
//
//  Created by walen on 16/11/25.
//  Copyright © 2016年 walen. All rights reserved.
//

#import "CustomTopBarViewController.h"
#import "ZHNavigationBar.h"

@interface CustomTopBarViewController ()

@end

@implementation CustomTopBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 64)];
    view.backgroundColor = [UIColor redColor];
    self.zh_customTopBar = view;
    
    //添加button是为了测试自定义的顶部条view不会被挡住
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"被遮挡的按钮" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(0, 50, 200, 40);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"original viewWillAppear:%@", self);
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
