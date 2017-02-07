//
//  ViewController.m
//  NewXProgect
//
//  Created by 杨静 on 15/8/18.
//  Copyright (c) 2015年 fll. All rights reserved.
//

#import "ViewController.h"


#define WIN_SIZE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIN_SIZE_WIDTH [UIScreen mainScreen].bounds.size.width
#define WIN_SIZE_BOUNDS [UIScreen mainScreen].bounds
@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController
@synthesize scrollView, slideImages;
@synthesize pageControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat height = WIN_SIZE_HEIGHT;
    CGFloat width = WIN_SIZE_WIDTH;
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, width, height*270/1136)];
    self.scrollView.backgroundColor=[UIColor orangeColor];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"1.png"];
    [slideImages addObject:@"2.png"];
    [slideImages addObject:@"3.png"];
    [slideImages addObject:@"4.png"];
    [slideImages addObject:@"5.png"];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(width*312/640,height*(240+88)/1136,96/640*width,10)]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:[UIColor blueColor]];
    [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    pageControl.numberOfPages = [self.slideImages count];
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self.view addSubview:pageControl];
    
    
    NSMutableArray *ccc = [NSMutableArray arrayWithObjects:[UIColor redColor],[UIColor blackColor],[UIColor yellowColor],[UIColor brownColor],[UIColor cyanColor], nil];//测试试//测试//测试///测试
    
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((width * i) + width, 0, width, height*270/1136);
        imageView.backgroundColor = ccc[i];
        [scrollView addSubview:imageView];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    imageView.frame = CGRectMake(0, 0, width, height*270/1136);
    imageView.backgroundColor = [UIColor brownColor];//测试//测试//测试//测试//测试//测试//测试//测试//测试///测试
    [scrollView addSubview:imageView];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake((width * ([slideImages count] + 1)) , 0, width, height*270/1136);
    imageView.backgroundColor = [UIColor redColor];//测试//测试//测试//测试//测试//测试//测试//测试//测试///测试
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(width * ([slideImages count] + 2), height*270/1136)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(width,0, width,height*270/1136) animated:NO];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([slideImages count]+2))/pagewidth)+1;
    page --;
    pageControl.currentPage = page;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([slideImages count]+2)) / pagewidth) + 1;
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width * [slideImages count],0,self.view.frame.size.width,self.view.frame.size.height) animated:NO];
    }
    else if (currentPage==([slideImages count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width,0,self.view.frame.size.width,self.view.frame.size.height) animated:NO];
    }
}
- (void)turnPage
{
    NSInteger page = pageControl.currentPage;
    if (page == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width*(page+1),0,self.view.frame.size.width,self.view.frame.size.height) animated:NO];
    }else {
        [self.scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width*(page+1),0,self.view.frame.size.width,self.view.frame.size.height) animated:YES];
    }
}
- (void)runTimePage
{
    NSInteger page = pageControl.currentPage;
    page++;
    page = page > 4 ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
