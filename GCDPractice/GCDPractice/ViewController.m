//
//  ViewController.m
//  GCDPractice
//
//  Created by 李根 on 16/6/11.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong)UIImageView *imageView;

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
    
    //  dispatch_apply是同步函数, 会阻塞当前线程直到所有循环迭代完成, 当提交到并发线程时, 执行顺序是不固定的
//    size_t num = 3;
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    
//    dispatch_apply(10, queue, ^(size_t index) {
//        NSLog(@"%zu",index);
//    });
//    NSLog(@"done");

    
//    [self testdispatch_apply];
    
//    [self combineImage];
    
}

#pragma mark    - 定时器
- (IBAction)buttonTap:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    
    //  创建一个定时器源
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    /**
     *  GCD定时器
     *
     *  @param DISPATCH_SOURCE_TYPE_TIMER 类型: 定时器
     *  @param 0                          句柄
     *  @param 0                          mask传0
     *  @param           队列 (注意: dispatch_source_t本质上是OC对象, 表示源)
     *
     *  @return
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //  严谨起见, 时间间隔需要用单位int64_t, 做乘法以后单位就变了
    //  下面这句代码表示回调函数间隔是多少
    int64_t interval = (int64_t)(1.0 * NSEC_PER_SEC);
    
    //  如何设置开始事件, GCD给我们了一个设置时间的方法
    //  参1: dispatch_time_t when 传一个事件, delta是增量
    //  从现在起0秒后开始
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
    
    
    dispatch_source_set_timer(timer, start, interval, 0);
    
    __block int count = 60;
    
    //  3. 设置回调(即每次间隔要做什么事)
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"---------%@", [NSThread currentThread]);
        //  如果希望做五次就停掉
        count--;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (count == 0) {
                dispatch_source_cancel(timer);
                [button setTitle:@"点击倒计时!" forState:UIControlStateNormal];
                button.enabled = YES;
            }
            else {
                [button setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
                [button setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateDisabled];
            }
        });
    });
    dispatch_resume(timer);
    
}

#pragma mark    - 合成图片
- (void)combineImage {
    
    //  创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //  创建组
    dispatch_group_t group = dispatch_group_create();
    
    
    __block UIImage *image1;
    __block UIImage *image2;
    //  用组队列下载图片
    dispatch_group_async(group, queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://7xjanq.com1.z0.glb.clouddn.com/6478.jpg"]];
        image1 = [UIImage imageWithData:data];
        NSLog(@"download image1: %@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://7xjanq.com1.z0.glb.clouddn.com/6478.jpg"]];
        image2 = [UIImage imageWithData:data];
        NSLog(@"download image2: %@", [NSThread currentThread]);
    });
    
    dispatch_group_notify(group, queue, ^{
        CGFloat imageW = self.imageView.bounds.size.width;
        CGFloat imageH = self.imageView.bounds.size.height;
        
        //  开启图形上下文
        UIGraphicsBeginImageContext(self.imageView.bounds.size);
        
        //  画图
        [image1 drawInRect:CGRectMake(0, 0, 0.5 * imageW, imageH)];
        [image2 drawInRect:CGRectMake(0.5 * imageW, 0, 0.5 * imageW, imageH)];
        
        //  取出图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        //  关闭图形上下文
        UIGraphicsEndImageContext();
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            NSLog(@"combine image: %@", [NSThread currentThread]);
        });
    });
}

- (UIImageView *)imageView {
    if (!_imageView) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
            [self.view addSubview:_imageView];
            _imageView.center = self.view.center;
            
            NSLog(@"create imageView: %@", [NSThread currentThread]);
            
        });
    }
    return _imageView;
}

#pragma mark    - 剪切文件从一个文件夹到另一个文件夹
-(void)testdispatch_apply
{
    // 将图片剪切到另一个文件夹里
    NSString *from = @"/Users/Ammar/Pictures/壁纸";
    NSString *to = @"/Users/Ammar/Pictures/to";
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *subPaths = [manager subpathsAtPath:from];
    
    // 快速迭代
    dispatch_apply(subPaths.count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        NSLog(@"%@ - %zd", [NSThread currentThread], index);
        NSString *subPath = subPaths[index];
        NSString *fromPath = [from stringByAppendingPathComponent:subPath];
        NSString *toPath = [to stringByAppendingPathComponent:subPath];
        
        // 剪切
        [manager moveItemAtPath:fromPath toPath:toPath error:nil];
        NSLog(@"%@---%zd", [NSThread currentThread], index);
    });
    
    //作用是把指定次数指定的block添加到queue中, 第一个参数是迭代次数，第二个是所在的队列，第三个是当前索引，dispatch_apply可以利用多核的优势，所以输出的index顺序不是一定的
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        NSLog(@"dispatch_apply %zd",index);
    });
    /*输出结果 无序的
     2016-02-15 10:15:21.229 多线程[4346:48391] dispatch_apply 0
     2016-02-15 10:15:21.229 多线程[4346:48784] dispatch_apply 1
     2016-02-15 10:15:21.230 多线程[4346:48830] dispatch_apply 2
     2016-02-15 10:15:21.230 多线程[4346:48391] dispatch_apply 4
     2016-02-15 10:15:21.230 多线程[4346:48829] dispatch_apply 3
     2016-02-15 10:15:21.231 多线程[4346:48391] dispatch_apply 6
     2016-02-15 10:15:21.231 多线程[4346:48391] dispatch_apply 9
     2016-02-15 10:15:21.230 多线程[4346:48784] dispatch_apply 5
     2016-02-15 10:15:21.231 多线程[4346:48829] dispatch_apply 8
     2016-02-15 10:15:21.231 多线程[4346:48830] dispatch_apply 7
     */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

















