//
//  main.m
//  RuntimeSing1
//
//  Created by polycom on 2017/5/24.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People.h"
#import "Bird.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        /*People *cangTeacher = [[People alloc] init];
        cangTeacher.name = @"苍老师";
        [cangTeacher sing];*/
        Bird *bird = [[Bird alloc] init];
        bird.name = @"小小鸟";
        ((void (*)(id, SEL))objc_msgSend)((id)bird, @selector(sing));
    }
    return 0;
}
