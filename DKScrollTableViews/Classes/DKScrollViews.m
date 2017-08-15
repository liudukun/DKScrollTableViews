//
//  DKScrollViews.m
//  DKScrollViews
//
//  Created by liudukun on self.lineHeight017/self.marginItem/11.
//  Copyright © self.lineHeight017年 liudukun. All rights reserved.
//

#import "DKScrollViews.h"

@implementation DKTopBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.line];
    }
    return self;
}

- (void)addItem:(UIButton *)item{
    CGSize size = [item.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:item.titleLabel.font}];
    UIButton *lastItem = self.items.lastObject;
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.items];
    [arrM addObject:item];
    self.items = arrM;
    item.tag = [self.items indexOfObject:item];

    item.frame = CGRectMake(CGRectGetMaxX(lastItem.frame) + self.marginItem, 0, size.width*1.2, self.frame.size.height - self.lineHeight);
    [self.scrollView addSubview:item];
    if (lastItem == self.items.firstObject) {
        self.line.frame = CGRectMake(self.marginItem, self.frame.size.height - self.lineHeight, lastItem.frame.size.width + 2 * self.marginItem, self.lineHeight);
        self.selectedItem = lastItem;
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(item.frame), self.frame.size.height);
}

- (UIView *)line{
    if (_line) {
        return _line;
    }
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, self.lineHeight)];
    _line.backgroundColor = [UIColor redColor];
    return _line;
}

- (CGFloat)lineHeight{
    if (_lineHeight) {
        return _lineHeight;
    }
    return 3;
}

- (UIScrollView *)scrollView{
    if (_scrollView) {
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = NO;
    return _scrollView;
}

@end

@interface DKScrollViews()<UIScrollViewDelegate>

@end

@implementation DKScrollViews

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.topBar];
    }
    return self;
}

- (void)addItem:(UIButton *)item contentView:(UIView *)contentView{
    [self.topBar addItem:item];
    [item addTarget:self action:@selector(actionItem:) forControlEvents:UIControlEventTouchUpInside];
    UIView *lastContentView = self.contentViews.lastObject;
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.contentViews];
    [arrM addObject:contentView];
    self.contentViews = arrM;
    contentView.frame = CGRectMake(CGRectGetMaxX(lastContentView.frame), 0, self.frame.size.width, self.frame.size.height);
    [self.scrollView addSubview:contentView];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(contentView.frame), self.frame.size.height);
}

- (void)actionItem:(UIButton *)item{
    if (self.topBar.selectedItem == item) {
        return;
    }
    
    CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    aniScale.fromValue = [NSNumber numberWithFloat:0.8];
    aniScale.toValue = [NSNumber numberWithFloat:1.1];
    aniScale.duration = 0.3;
    aniScale.removedOnCompletion = NO;
    aniScale.repeatCount = 1;
    aniScale.fillMode = kCAFillModeForwards;  //防止动画结束后回到原位
    [item.layer addAnimation:aniScale forKey:@"ani"];
    
    aniScale.fromValue = [NSNumber numberWithFloat:1.1];
    aniScale.toValue = [NSNumber numberWithFloat:1];
    [self.topBar.selectedItem.layer addAnimation:aniScale forKey:@"ani_b"];
    
    self.topBar.selectedItem.selected = NO;
    item.selected = YES;
    self.topBar.selectedItem = item;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width * item.tag, 0);
        self.topBar.line.center = CGPointMake(item.center.x, self.topBar.line.center.y);
        if (item.center.x > self.frame.size.width/2 && item.center.x + self.frame.size.width /2 < self.topBar.scrollView.contentSize.width) {
            self.topBar.scrollView.contentOffset = CGPointMake(item.center.x - self.frame.size.width/2, 0);
        }
        if (item.center.x < self.frame.size.width /2) {
            self.topBar.scrollView.contentOffset = CGPointMake(0, 0);
        }
        if (item.center.x + self.frame.size.width /2 > self.topBar.scrollView.contentSize.width) {
            self.topBar.scrollView.contentOffset = CGPointMake(self.topBar.scrollView.contentSize.width - self.frame.size.width, 0);
        }
    }];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger tag = self.scrollView.contentOffset.x / self.frame.size.width;
    UIButton *item = self.topBar.items[tag];
    [self actionItem:item];
}

- (UIScrollView *)scrollView{
    if (_scrollView) {
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.topBarHeight, self.frame.size.width, self.frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    return _scrollView;
}

- (DKTopBar *)topBar{
    if (_topBar) {
        return _topBar;
    }
    _topBar = [[DKTopBar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.topBarHeight)];
    return _topBar;
}

- (CGFloat)topBarHeight{
    if (_topBarHeight) {
        return _topBarHeight;
    }
    return 45;
}


@end
