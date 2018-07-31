//
//  StringReversedViewController.m
//  MVP模式
//
//  Created by gaoguangxiao on 2018/7/26.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "StringReversedViewController.h"

@interface StringReversedViewController ()

@end

@implementation StringReversedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *s = @"abcdefg hijklmn opq rst uvw syz";

    //字符串翻转
//    列举字符串
//    NSMutableString *r = [NSMutableString stringWithCapacity:s.length];
//    [s enumerateSubstringsInRange:NSMakeRange(0, s.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
//        NSLog(@"R = %@",r);
//        [r insertString:substring atIndex:0];
//    }];
////    NSString *z =
//    NSLog(@"之前：%@、之后:%@",s,r);
    NSString *t = @"";
    NSString *debugCharacter = [self logdebugForMessager:@{@"token":@"hhdfsafsdfdsgnosgnscpivol",@"clientId":@12390,@"request_type":t} andServiceUrl:@"http://www.baidu.com"];
    NSLog(@"%@",debugCharacter);
}

/**
 将字典转化为字符串输出

 @param dicTionary 字典
 @param url 服务器地址
 @return 返回拼接的字符串
 */
-(NSString *)logdebugForMessager:(NSDictionary *)dicTionary andServiceUrl:(NSString *)url{
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:url];
    [dicTionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //确定 obj类是否是当前类的成员
        if ([obj isKindOfClass:[NSString class]])[mutableString appendString:[(NSString *)obj length] ? [NSString stringWithFormat:@"&%@=%@",key,obj] : @""];
        else if ([obj isKindOfClass:[NSNumber class]])[mutableString appendString:[(NSNumber *)obj integerValue] ? [NSString stringWithFormat:@"&%@=%@",key,obj] : @""];
        else
        NSLog(@"%@-%@-%p",key,obj,&stop);//
    }];
    
//    NSString *s = [NSString alloc]initw
//    [dicTionary enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"%@-%@-%p",key,obj,stop);
//    }];
//    for (NSString *key in dicTionary.allKeys) {
//        if ([dicTionary[key] isKindOfClass:[NSString class]]) {
//            NSString *value = dicTionary[key];
//            if (value.length<1) {
////                [dicTionary removeObjectForKey:key];
//                iscountine = NO;
//            }
//            [mutableString appendFormat:@"%@", [NSString stringWithFormat:@"&%@=%@",key,dicTionary[key]]];
//        }else if([dicTionary[key] isKindOfClass:[NSNumber class]]){
//            [mutableString appendFormat:@"%@", [NSString stringWithFormat:@"&%@=%@",key,dicTionary[key]]];
//        }
//    }
    return mutableString;
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
