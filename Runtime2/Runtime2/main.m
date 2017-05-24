//
//  main.m
//  Runtime2
//
//  Created by polycom on 2017/5/24.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        People *cangTeacher = [[People alloc] init];
        cangTeacher.name = @"苍井空";
        cangTeacher.age = 18;
        [cangTeacher setValue:@"老师" forKey:@"occupation"];
        
        NSDictionary *propertyResultDic = [cangTeacher allProperties];
        for(NSString *propertyName in propertyResultDic.allKeys) {
            NSLog(@"propertyName:%@, propertyValue:%@", propertyName, propertyResultDic[propertyName]);
        }
        
        NSDictionary *ivarResultDic = [cangTeacher allIvars];
        for(NSString *ivarName in ivarResultDic.allKeys) {
            NSLog(@"ivarName:%@, ivarValue:%@", ivarName, ivarResultDic[ivarName]);
        }
        
        NSDictionary *methodResultDic = [cangTeacher allMethods];
        for(NSString *methodName in methodResultDic.allKeys) {
            NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodResultDic[methodName]);
        }
    }
    return 0;
}
