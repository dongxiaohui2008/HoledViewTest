//
//  ViewController.m
//  HoledViewTest
//
//  Created by Colin on 15/4/7.
//  Copyright (c) 2015年 icephone. All rights reserved.
//

#import "ViewController.h"
#import "YLZHoledView.h"

@interface ViewController () <YLZHoledViewDelegate>

@property (nonatomic, strong) YLZHoledView *holedView;
@property (nonatomic, strong) UIButton *myButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self setupTestUI];
    
    [self performSelector:@selector(addTestHoledView) withObject:self afterDelay:3.0f];
}


- (void)setupTestUI
{
    
    //设置背景图
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background"] ];

    //添加按钮
    self.myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.myButton.frame = CGRectMake(120, 400, 80, 40);
    [self.myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.myButton.layer.borderWidth = 1;
    self.myButton.layer.cornerRadius = 4.0;
    self.myButton.layer.masksToBounds = YES;
    [self.myButton setAdjustsImageWhenHighlighted:NO];
    self.myButton.backgroundColor = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    self.myButton.layer.borderColor = [[UIColor colorWithRed:76/255.0 green:174/255.0 blue:76/255.0 alpha:1] CGColor];
    self.myButton.layer.cornerRadius = 20.0;
    [self.myButton setTitle:@"点我!" forState:UIControlStateNormal];
    [self.myButton addTarget:self
               action:@selector(onButtonTapped:)
     forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.myButton];
}

- (void)onButtonTapped:(UIButton *)sender
{
    NSLog(@"Button Tapped!");
    [self.holedView removeHoles];
    [self.holedView removeFromSuperview];
}

- (void)addTestHoledView
{
    
    //添加遮罩指示
    self.holedView = [[YLZHoledView alloc]initWithFrame:self.view.frame];
    self.holedView.holeViewDelegate = self;
    [self.view addSubview:_holedView];
    
    
    // 按钮 - 圆角矩形
    [self.holedView addHoleRoundedRectOnRect:_myButton.frame withCornerRadius:_myButton.frame.size.width/2];
    [self.holedView addFocusView:_myButton];
    
    // 圆形
    [self.holedView addHoleCircleCenteredOnPosition:CGPointMake(190, 110) andDiameter:130];
    
    // 文字说明
    [self.holedView addHCustomView:[self viewForDemo] onRect:CGRectMake(20.0f, 250.0f, 200.0f, 50.0f)];

}

#pragma marl - helper

- (UIView *)viewForDemo
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 250.0F, 200.0f, 50.0f)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.borderWidth = 1.0f;
    label.layer.cornerRadius = 10.0f;
    [label setTextColor:[UIColor whiteColor]];
    label.text = @"点击按钮, 退出遮罩层.";
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:18.0f];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)holedView:(YLZHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index
{
    NSLog(@"%s %ld", __PRETTY_FUNCTION__,(long)index);
}

@end
