//
//  ViewController.m
//  GCDPractice
//
//  Created by 李根 on 16/6/11.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"后台线程?");
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"主线程?");
    });
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"一次就好");
    });
    
    dispatch_once(&onceToken, ^{
        NSLog(@"二次就好"); //  不会执行
    });
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
       NSLog(@"延时两秒了吗");
    });
    
    dispatch_queue_t urls_queue = dispatch_queue_create("dfs", NULL);
    dispatch_async(urls_queue, ^{
        NSLog(@"自定义线程");
    });
    */
    
    /*
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"group-01- %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 8; i++) {
            NSLog(@"group-02- %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"group-03- %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成: %@", [NSThread currentThread]);
    });
    */
    
    
    /*
//    @autoreleasepool {
//    }
        __block NSArray *arr = nil;
        dispatch_queue_t queue = dispatch_queue_create("test", NULL);
    dispatch_sync(queue, ^{
        arr = @[@"fds", @"jjj"];
        NSLog(@"%@", arr);
        
    });
//        dispatch_async(queue, ^{
//        });
    NSLog(@"___%@", arr);
    */
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

















