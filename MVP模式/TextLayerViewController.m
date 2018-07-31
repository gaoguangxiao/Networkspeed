//
//  TextLayerViewController.m
//  MVP模式
//
//  Created by gaoguangxiao on 2018/7/26.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "TextLayerViewController.h"

#import <CoreText/CoreText.h>

#define U_S @"在创建CADisplayLink的时候，我们需要指定一个RunLoop和RunLoopMode，通常RunLoop我们都是选择使用主线程的RunLoop，因为所有UI更新的操作都必须放到主线程来完成，而在模式的选择就可以用NSDefaultRunLoopMode，但是不能保证动画平滑的运行，所以就可以用NSRunLoopCommonModes来替代。但是要小心，因为如果动画在一个高帧率情况下运行，会导致一些别的类似于定时器的任务或者类似于滑动的其他iOS动画会暂停，直到动画结束"
@interface TextLayerViewController ()
{
    
}
@end

@implementation TextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CATextLayer *textLayer = [[CATextLayer alloc]init];
    textLayer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200);
    textLayer.alignmentMode=kCAAlignmentCenter;
    textLayer.fontSize=20;
    textLayer.wrapped=YES;//是否换行
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    UIFont *font = [UIFont systemFontOfSize:30];
    
    CFStringRef stringRef = (__bridge CFStringRef)(font.fontName);
    
    CTFontRef fontRef = CTFontCreateWithName(stringRef, 35, NULL);
    textLayer.font = fontRef;

    NSMutableAttributedString *a_S = [[NSMutableAttributedString alloc]initWithString:U_S];
    [a_S setAttributes:@{(__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor whiteColor].CGColor} range:NSMakeRange(0, U_S.length)];
    
    textLayer.string = a_S;
    [self.view.layer addSublayer:textLayer];
    
    for (NSInteger i = 0; i < a_S.length; i++) {
        
        [self performSelector:@selector(askWorker:) withObject:@[[NSNumber numberWithInteger:i],textLayer,a_S] afterDelay:0.1 * i];
    }
    
}

-(void) askWorker:(NSArray *)args{
    [self changeCharacterColorAtIndex:[(NSNumber *)args[0] integerValue] forTextLayer:args[1] AndForS:args[2]];
}
-(void)changeCharacterColorAtIndex:(NSInteger)index forTextLayer:(CATextLayer *)textLayer AndForS:(NSMutableAttributedString *)s{
    
//    NSLog(@"%@",[NSThread currentThread]);
    NSDictionary *attKeys = @{(__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor redColor].CGColor};
    
    [s setAttributes:attKeys range:NSMakeRange(index, 1)];

    textLayer.string = s;
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
