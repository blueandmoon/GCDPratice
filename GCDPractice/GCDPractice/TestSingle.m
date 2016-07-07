//
//  TestSingle.m
//  GCDPractice
//
//  Created by 李根 on 16/7/7.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "TestSingle.h"

@implementation TestSingle

singleton_implementation(TestSingle)

- (void)testNslog {
    NSLog(@"单例一行代码实现啦, 啦啦啦啦啦");
}

//static TestSingle *_instace;
//
//+ (id)allocWithZone:(struct _NSZone *)zone {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instace = [super allocWithZone:zone];
//    });
//    return _instace;
//}
//
//+ (instancetype)sharedTestSingle {
//    if (_instace == nil) {
//        _instace = [[TestSingle alloc] init];
//    }
//    return _instace;
//}


@end
