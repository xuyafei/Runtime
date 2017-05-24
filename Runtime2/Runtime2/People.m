//
//  People.m
//  Runtime2
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

- (NSDictionary *)allProperties {
    unsigned int count = 0;
    
    /*获取属性列表(只获取属性不获取变量)
    **入参:类Class，int变量指针
    **返回:属性信息objc_property_t列表
    **获取所有属性
    **获取的属性名和你代码写的一样,获取出来的属性名不自动添加下划线
    **不能获取Category添加的属性。
    */
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for(NSUInteger i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [self valueForKey:name];
        
        if(propertyName) {
            resultDict[name] = propertyValue;
        } else {
            resultDict[name] = @"字典的key对应的value不能为nil!";
        }
    }
    free(properties);
    
    return resultDict;
}

- (NSDictionary *)allIvars {
    unsigned int count = 0;
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    /*获取变量列表
    **入参:类Class，int变量指针
    **返回:变量信息Ivar列表
    **获取所有私有变量和属性对应的变量
    **获取的私有变量的名和定义的名一样
    **获取的属性的名前面都添加了下划线
    **不能获取Category添加的变量（动态绑定的变量）
    */
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (NSUInteger i = 0; i < count; i++) {
        const char *varName = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:varName];
        id varValue = [self valueForKey:name];
        
        if(varValue) {
            resultDict[name] = varValue;
        } else {
            resultDict[name] = @"字典的key对应的value不能为nil!";
        }
    }
    free(ivars);
    
    return resultDict;
}

- (NSDictionary *)allMethods {
    unsigned int count = 0;
    
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    /*获取方法列表
    **入参:类Class，int变量指针
    **返回:方法信息Method列表
    **获取所有实例方法,不包含静态方法
    **不获取父类的方法
    **隐式的get set 方法也能获取到
    **可以获取分类和动态添加的方法。
    */
    Method *methods = class_copyMethodList([self class], &count);
    
    for(NSUInteger i = 0; i < count; i++) {
        SEL methodSEL = method_getName(methods[i]);
        const char *methodName = sel_getName(methodSEL);
        NSString *name = [NSString stringWithUTF8String:methodName];
        
        int arguments = method_getNumberOfArguments(methods[i]);
        resultDict[name] = @(arguments-2);
    }
    free(methods);
    
    return resultDict;
}
@end
