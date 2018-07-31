//
//  ViewController.m
//  MVP模式
//
//  Created by gaoguangxiao on 2018/7/25.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>
#define urlDownloadString @"http://global.talk-cloud.net/Updatefiles/SinceWinPc.exe"//30M
typedef void (^MyBlock) (int a);

@interface ViewController ()<NSURLSessionDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressCount;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;


@end

@implementation ViewController
+(void)load{
    //让程序不运行viewDidload
    Method one = class_getInstanceMethod(self.class, @selector(viewDidLoad));
    Method two = class_getInstanceMethod(self.class, @selector(runtime1));
//    BOOL b = class_addMethod(self.class, @selector(runtime1), method_getImplementation(two), method_getTypeEncoding(two));
//    self
//    if (b) {
//        NSLog(@"添加成功");
//        class_replaceMethod(self.class, @selector(viewDidLoad), method_getImplementation(one), method_getTypeEncoding(one));
//    }else{
        method_exchangeImplementations(two,one);
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewdidload");
    //    UIStackView *stackView = [[UIStackView alloc]init];
    //    stackView.frame = self.view.frame;
    //    [self.view addSubview:stackView];
    //
    //    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    view1.backgroundColor = [UIColor redColor];
    //    [stackView addArrangedSubview:view1];
    //
    //    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    view2.backgroundColor = [UIColor orangeColor];
    //    [stackView addArrangedSubview:view2];
    
    // block，是OC的闭包的实现  一个函数【指向函数的指针，该函数执行的外部的上下文变量
    // 可以嵌套，可以定义在方法内部或外部，使代码高聚合
    
    //无参数无返回值
    //    void(^My)(void) = ^ (void) {
    //        NSLog(@"电影");
    //    };
    //
    //    My();
    //    //有参数无返回
    //    void(^block)(NSInteger a) = ^(NSInteger c){
    //        NSLog(@"%ld",c);
    //    };
    //    block(13);
    
    int age = 90;
    
    
//    [self functiona:^(int a) {
//        //        age = 150;
//        NSLog(@"%d",age);
//    }];
//    NSLog(@"2 - %d",age);
    
    NSArray *a = @[@12,@12];
    //1、不可变数组 copy -> 不可变
    //2、不可变数组 mutableCopy -可变
    NSMutableArray *b = [a mutableCopy];//可变数组
    //可变数组 copy 是 不可变
    //可变数组 mutable 可变
    NSMutableArray *c = [NSMutableArray arrayWithArray:a];
    NSMutableArray *d = [c mutableCopy];
    //    [d addObject:@15];
    //    [b addObject:@13];
//    NSLog(@" a:%p/b:%p",a,b);
//    
//    NSLog(@"c:%@,d:%@",c,d);
    
    //    [NSURLConnection alloc]initWithRequest:<#(nonnull NSURLRequest *)#> delegate:<#(nullable id)#> startImmediately:<#(BOOL)#>
    //    NSURLSession
    //    NSURLSessionDownloadTask
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLSessionUploadTask *urlSessionUploadTask;
    NSURLSessionDownloadTask *downloadTask;
    
    //1、学会使用NSURLSessionDownloadTask 下载文件？
    //    下载的细节：下载到沙盒的tmp目录，完成之后就会移除。需要移动到另一个目录
    
    
  
}

-(void)runtime1{
    NSLog(@"runtime1");
}
-(void)runtime2{
    NSLog(@"runtime2");
}

- (IBAction)startDownTask:(id)sender {
    
    
    
//    self.startBtn.enabled = NO;
    [self testDownProgress];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    [self testDown];
    //    [self testDownProgress];
}
-(void)testDown{
    NSLog(@"开始下载");
    
    
    //下载无法监听进度
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlDownloadString]];
    NSURLSessionDownloadTask *downloadTask = [urlSession downloadTaskWithRequest:urlrequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"下载完成");
        //response.suggestedFilename 响应信息中的资源文件名
        
        //获取文件管理器
        
        
        //将临时文件移动到缓存目录下
        //[NSURL fileURLWithPath:cachesPath] 将本地路径转化为URL类型
        //URL如果地址不正确，生成的url对象为空
        
        //文件移动
        //        [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:cacheParh] error:NULL];
    }];
    
    [downloadTask resume];//启动任务
    //    [downloadTask cancel];//关闭任务
    //    [downloadTask suspend];//暂停任务
    
    
}

-(void)testDownProgress{
    
    NSString * cacheParh = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@".zip"];
    NSLog(@"缓存地址:%@",cacheParh);
    
    NSURLSessionConfiguration *urlConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:urlConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlDownloadString]];
    NSURLSessionDownloadTask *downloadTask = [urlSession downloadTaskWithRequest:urlrequest];
    [downloadTask resume];
    
    //    downloadTask.lo
    //NSURLSessiond
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //给progressView赋值进度
    self.progressView.progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    
    self.progressCount.text = [NSString stringWithFormat:@"%.4f %@",self.progressView.progress * 100.0,[NSString stringWithFormat:@"%%"]];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    self.startBtn.enabled = YES;
    self.progressView.progress = 0;
    self.progressCount.text = @"0%";
    
    //下载完成将文件移到其他
    NSLog(@"下载完成");
    NSFileManager * manager = [NSFileManager defaultManager];
//    session.p
    NSString * cacheParh = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"ggx.zip"];
    
    [manager moveItemAtURL:location toURL:[NSURL URLWithString:cacheParh] error:NULL];
}


-(void)functiona:(MyBlock)a{
    a(1);
    //    return 12;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
