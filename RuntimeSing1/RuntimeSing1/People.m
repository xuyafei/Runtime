//
//  People.m
//  RuntimeSing1
//
//  Created by polycom on 2017/5/24.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "People.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

@implementation People

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if([NSStringFromSelector(sel) isEqualToString:@"sing"]) {
        class_addMethod(self, sel, (IMP)otherSing, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

void otherSing(id self, SEL cmd) {
    NSLog(@"%@ 唱歌啦", ((People *)self).name);
}
@end
