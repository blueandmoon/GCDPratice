//
//  TestSingle.h
//  GCDPractice
//
//  Created by 李根 on 16/7/7.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import <Foundation/Foundation.h>

//  .h
#define singleton_interface(className) + (instancetype)shared##className;
//  .m  最后一句不要斜线
#define singleton_implementation(className) \
static TestSingle *_instace;    \
\
+ (id)allocWithZone:(struct _NSZone *)zone {    \
    static dispatch_once_t onceToken;   \
    dispatch_once(&onceToken, ^{    \
        _instace = [super allocWithZone:zone];  \
    }); \
    return _instace;    \
}   \
\
+ (instancetype)shared##className { \
    if (_instace == nil) {  \
        _instace = [[className alloc] init];   \
    }   \
    return _instace;    \
}


@interface TestSingle : NSObject

singleton_interface(TestSingle)

- (void)testNslog;

@end
