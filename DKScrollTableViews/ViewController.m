//
//  ViewController.m
//  DKScrollTableViews
//
//  Created by liudukun on 2017/8/11.
//  Copyright © 2017年 liudukun. All rights reserved.
//

#import "ViewController.h"
#import "DKScrollViews.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DKScrollViews * view = [[DKScrollViews alloc]initWithFrame:self.view.bounds];
    view.topBar.marginItem = 4;
    view.topBar.lineHeight = 3;
    view.topBarHeight = 45;
    for (int i =0; i<20; i++) {
        UIButton *item = [[UIButton alloc]initWithFrame:CGRectZero];
        [item setTitle:@"答复啊啊啦" forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:15.f];
        UIView *cview = [UIView new];
        cview.backgroundColor = [UIColor colorWithWhite:i/20.0 alpha:1];
        [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [view addItem:item contentView:cview];
    }

    [self.view addSubview:view];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
