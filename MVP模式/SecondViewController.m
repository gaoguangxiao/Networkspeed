//
//  SecondViewController.m
//  MVP模式
//
//  Created by gaoguangxiao on 2018/7/25.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "SecondViewController.h"

#import <CoreText/CoreText.h> //导入CoreText框架
@interface SecondViewController ()
{
//    dispatch_source_t gcdTimer;
    
    NSMutableArray *labels;
    NSMutableArray *numArr;
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UILabel *printText;

@property(nonatomic,strong)CADisplayLink *displayLink;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,strong)dispatch_source_t gcdTimer;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //CADisplayLink
    /**
     self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updaTimer)];
    //    display.duration 每帧的时间间隔
    
    //nsrunloop简介
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    NSLog(@"viewDidload:%@",NSStringFromClass(self.class));
    */
    //创建GCD定时器
    /*
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    self.gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.gcdTimer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 1.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.gcdTimer, ^{
        //子线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self updaTimer];
        });
//        [self updaTimer]; //
        NSLog(@"当前线程：%@",[NSThread currentThread]);
    });
    dispatch_resume(self.gcdTimer);
    */
    
//    1、实现打印机效果
//    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(printCharacter)];
//    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
////    dispatch_suspend(<#dispatch_object_t  _Nonnull object#>)
    
    
}
- (void)buttonClick:(id)sender {
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    vi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vi];
    
    //2、了解 CATextLayer吗？
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = vi.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [vi.layer addSublayer:textLayer];
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:12];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        
        printf( "Family: %s \n", [familyName UTF8String] );
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
    
    NSString *str = @"在创建CADisplayLink的时候，我们需要指定一个RunLoop和RunLoopMode，通常RunLoop我们都是选择使用主线程的RunLoop，因为所有UI更新的操作都必须放到主线程来完成，而在模式的选择就可以用NSDefaultRunLoopMode，但是不能保证动画平滑的运行，所以就可以用NSRunLoopCommonModes来替代。但是要小心，因为如果动画在一个高帧率情况下运行，会导致一些别的类似于定时器的任务或者类似于滑动的其他iOS动画会暂停，直到动画结束";
    
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:str];
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor whiteColor].CGColor,
                              (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                              };
    [string setAttributes:attribs range:NSMakeRange(0, str.length)];
    
    dataArr = [NSMutableArray arrayWithObjects:(__bridge id _Nonnull)(fontRef),attribs,string,str,textLayer, nil];
    numArr = [NSMutableArray array];
    
    for (int i = 0; i < str.length; i++) {
        [numArr addObject:[NSNumber numberWithInt:i]];
        [self performSelector:@selector(changeToBlack) withObject:nil afterDelay:0.1 * i];
    }
    CFRelease(fontRef);
    
}

- (void)changeToBlack {
    CTFontRef fontRef = (__bridge CTFontRef)(dataArr[0]);
    NSMutableAttributedString *string = dataArr[2];
    NSNumber *num = [numArr firstObject];
    int y = [num intValue];
    
    NSDictionary *attribs = dataArr[1];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(y, 1)];//将指定的字符串属性修改黑色
    
    if (numArr.count > 1) {
        [numArr removeObjectAtIndex:0];
    }
    CATextLayer *textLayer = [dataArr lastObject];
    textLayer.string = string;
}

-(void)printCharacter{
    NSString *allText = @"在创建CADisplayLink的时候，我们需要指定一个RunLoop和RunLoopMode，通常RunLoop我们都是选择使用主线程的RunLoop，因为所有UI更新的操作都必须放到主线程来完成，而在模式的选择就可以用NSDefaultRunLoopMode，但是不能保证动画平滑的运行，所以就可以用NSRunLoopCommonModes来替代。但是要小心，因为如果动画在一个高帧率情况下运行，会导致一些别的类似于定时器的任务或者类似于滑动的其他iOS动画会暂停，直到动画结束";
//    NSArray *allTextArr = allText c
    NSString *lastText = _printText.text;
    
//    for (<#initialization#>; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
//    NSString *text = [NSString stringWithFormat:@"%@",lastText.allText.length];
    
//    _printText.text = text;
}

-(void)updaTimer{
    CGFloat r = arc4random()%255/255.0;
    CGFloat g = arc4random()%255/255.0;
    CGFloat b = arc4random()%255/255.0;
    self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    
//    NSLog(@"%@")
//    NSLog(@"更新啦");
}
- (IBAction)timeControl:(UIButton *)sender {
    
    [self buttonClick:sender];
//    self.gcdTimer.
//    dispatch_resume(self.gcdTimer);
    
//    dispatch_suspend(self.gcdTimer);//暂停 gcd定时器
    
    /*
    BOOL b = self.displayLink.isPaused;
//    NSLog(@"%@",self.displayLink);
//    CFTimeInterval
    NSLog(@"%f--%f",self.displayLink.timestamp,self.displayLink.duration);
    if (b) {
        [self.displayLink setPaused:NO];
        [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        [self.displayLink setPaused:YES];
        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
     */
}
- (IBAction)stopPlay:(id)sender {
    [self.displayLink invalidate];//销毁,
    
    self.displayLink = nil;
    
    //给空对象发消息试试
//    [self.displayLink setPaused:YES];
    
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
