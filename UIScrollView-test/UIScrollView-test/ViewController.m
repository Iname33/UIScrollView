//
//  ViewController.m
//  UIScrollView-test
//
//  Created by 伍承标 on 2017/11/12.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "ViewController.h"
#define Kcount 5
#define Kwidth [UIScreen mainScreen].bounds.size.width
#define Kheight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIPageControl* pc;
@property (weak, nonatomic) UIScrollView* sv;
@property (strong, nonatomic) NSTimer* timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView* sv = [[UIScrollView alloc]init];
    sv.delegate = self;
    self.sv = sv;
    [self.view addSubview:sv];
    // x点中心居中  y点不需要
    /*
     CGPoint cen = sv.center;
     cen.x = self.view.center.x;
     sv.center = cen;
     */
    CGFloat width = 300;
    CGFloat height = 130;
    CGFloat x = (Kwidth - width) / 2;
    CGFloat y = 64;
    sv.frame = CGRectMake(x,y ,width ,height );
    
    // 添加图片
    for (int i = 0; i<Kcount; i++) {
        UIImageView* iv = [[UIImageView alloc]init];
        // 获取图片的名称
        NSString* imgName = [NSString stringWithFormat:@"img_%02d",i+1];
        iv.image = [UIImage imageNamed:imgName];
        // 设置frame
        CGFloat ivW = 300;
        CGFloat ivH = 130;
        CGFloat ivX = i*width;
        CGFloat ivY = 0;
        iv.frame = CGRectMake(ivX, ivY, ivW, ivH);
        [sv addSubview:iv];
    }
    // 包含尺寸
    sv.contentSize = CGSizeMake(Kcount*width, 0);
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    
    // 添加页面控制
    UIPageControl* pc = [[UIPageControl alloc]init];
    CGFloat pcW = 150;
    CGFloat pcH = 37;
    CGFloat pcX = (Kwidth - pcW) / 2;
    // 获取一个控件的最大y轴
    CGFloat pcY = CGRectGetMaxY(sv.frame) - 30;
    pc.frame = CGRectMake(pcX, pcY, pcW, pcH);
    // 设置点数
    pc.numberOfPages = Kcount;
    [self.view addSubview:pc];
    // 设置点颜色
    pc.currentPageIndicatorTintColor = [UIColor redColor];
    pc.pageIndicatorTintColor = [UIColor blackColor];
    self.pc = pc;
    
    [self runTimer];
    
}
-(void)createTimer{
    if(self.pc.currentPage == 4){
        self.pc.currentPage = 0;
    }else{
        self.pc.currentPage++;
    }
    
    //
    //    [self.sv setContentOffset:CGPointMake(self.pc.currentPage*self.sv.frame.size.width, 0) animated:YES];
    // 添加动画效果一般两种情况:自带animated
    // [UIView animated];
    // 添加动画效果
    [UIView animateWithDuration:1.0 animations:^{
        self.sv.contentOffset = CGPointMake(self.pc.currentPage*self.sv.frame.size.width, 0);
    }];
}



// 当坐标改变时，自动调用
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // contentOffset:获取当前左上角的点
//    NSLog(@"%lf",scrollView.contentOffset.x);
//}
// 停止滑动时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index =  scrollView.contentOffset.x/scrollView.frame.size.width;
    
    self.pc.currentPage = index;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}
-(void)runTimer{
    // 定循环时间
    NSTimer* timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(createTimer) userInfo:nil repeats:YES];
    // 启动
    NSRunLoop* runLoop = [NSRunLoop mainRunLoop];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self runTimer];
}











@end

