//
//  TYTitlePageTabBar.m
//  TYSlidePageScrollViewDemo
//
//  Created by SunYong on 15/7/16.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYTitlePageTabBar.h"

@interface TYTitlePageTabBar ()
@property (nonatomic, strong) NSArray *btnArray;
@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, weak) UIView *horIndicator;
@end

@implementation TYTitlePageTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _textFont = [UIFont systemFontOfSize:16];
        _selectedTextFont = [UIFont systemFontOfSize:16];
        _textColor = [UIColor darkTextColor];
        _selectedTextColor = [UIColor blackColor];
        _horIndicatorColor = [UIColor colorWithRed:68/255 green:68/255 blue:68/255 alpha:1];
        _horIndicatorHeight = 2;
        
        [self addHorIndicatorView];
    }
    return self;
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray
{
    return [self initWithTitleArray:titleArray imageNameArray:nil];
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray imageNameArray:(NSArray *)imageNameArray
{
    if (self = [super init]) {
        _titleArray = titleArray;
        _imageArray = imageNameArray;
        [self addTitleBtnArray];
    }
    return self;
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor {
    _selectedTextColor = selectedTextColor;
    [self addTitleBtnArray];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self addTitleBtnArray];
}

- (void)setHorIndicatorColor:(UIColor *)horIndicatorColor {
    _horIndicatorColor = horIndicatorColor;
    [self addHorIndicatorView];
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    [self addTitleBtnArray];
}

#pragma mark - add subView

- (void)addHorIndicatorView
{
    if (_horIndicator) {
        _horIndicator.backgroundColor = _horIndicatorColor;
        return;
    }
    UIView *horIndicator = [[UIView alloc]init];
    horIndicator.backgroundColor = _horIndicatorColor;
    [self addSubview:horIndicator];
    _horIndicator = horIndicator;
}

- (void)addTitleBtnArray
{
    if (_btnArray) {
        [self removeTitleBtnArray];
    }
    
    NSMutableArray *btnArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
    for (NSInteger index = 0; index < _titleArray.count; ++index) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.titleLabel.font = _textFont;
        [button setTitle:_titleArray[index] forState:UIControlStateNormal];
        [button setTitleColor:_textColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        if (index < _imageArray.count) {
            NSString *imageName = _imageArray[index];
            if (imageName.length > 0) {
                [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            }
        }
        
        [button addTarget:self action:@selector(tabButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [btnArray addObject:button];
        if (index == 0) {
            [self selectButton:button];
        }
    }
    _btnArray = [btnArray copy];
}

#pragma mark - private menthod

- (void)removeTitleBtnArray
{
    [_btnArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _btnArray = nil;
}

- (void)selectButton:(UIButton *)button
{
    if (_selectBtn) {
        _selectBtn.selected = NO;
        if (_selectedTextFont) {
            
            _selectBtn.titleLabel.font = _textFont;
             
        }
    }
    _selectBtn = button;
    
    CGRect frame = _horIndicator.frame;
    frame.origin.x = CGRectGetMinX(_selectBtn.frame) + _horIndicatorSpacing;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
         _horIndicator.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
    _selectBtn.selected = YES;
    if (_selectedTextFont) {
        _selectBtn.titleLabel.font = _selectedTextFont;
        
    }
}

#pragma mark - action method
// clicked
- (void)tabButtonClicked:(UIButton *)button
{
    
    //防止重新点击
    if (_selectBtn == button) {
        return;
    }
    [self selectButton:button];
    
    // need ourself call this method
    [self clickedPageTabBarAtIndex:button.tag];
}

#pragma mark - override method
// override
- (void)switchToPageIndex:(NSInteger)index
{
    if (index >= 0 && index < _btnArray.count) {
        [self selectButton:_btnArray[index]];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnWidth = (CGRectGetWidth(self.frame)-_edgeInset.left-_edgeInset.right + _titleSpacing)/_btnArray.count - _titleSpacing;
    CGFloat viewHeight = CGRectGetHeight(self.frame)-_edgeInset.top-_edgeInset.bottom;
    
    [_btnArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.frame = CGRectMake(idx*(btnWidth+_titleSpacing)+_edgeInset.left, _edgeInset.top, btnWidth, viewHeight);
    }];
    
    NSInteger curIndex = 0;
    if (_selectBtn) {
        curIndex = [_btnArray indexOfObject:_selectBtn];
    }
    
    _horIndicator.frame = CGRectMake(curIndex*(btnWidth+_titleSpacing)+_edgeInset.left + _horIndicatorSpacing, CGRectGetHeight(self.frame) - _horIndicatorHeight, btnWidth - _horIndicatorSpacing * 2, _horIndicatorHeight);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
