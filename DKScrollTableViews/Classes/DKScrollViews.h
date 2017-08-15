//
//  DKScrollViews.h
//  DKScrollViews
//
//  Created by liudukun on 2017/8/11.
//  Copyright © 2017年 liudukun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DKTopBar : UIView

@property (nonatomic,strong) UIView *line;

@property (nonatomic) CGFloat lineHeight;

@property (nonatomic,strong) NSArray *items;

@property (nonatomic,strong) UIButton *selectedItem;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic) CGFloat marginItem;

- (void)addItem:(UIButton *)item;

@end



@interface DKScrollViews : UIView


@property (nonatomic,strong) DKTopBar *topBar;

@property (nonatomic,strong) NSArray *contentViews;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic) CGFloat topBarHeight;


- (void)addItem:(UIButton *)item contentView:(UIView *)contentView;

@end
