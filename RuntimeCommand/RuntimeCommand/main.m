//
//  main.m
//  RuntimeCommand
//
//  Created by polycom on 2017/5/24.
//  Copyright © 2017年 xuyafei. All rights reserved.
//
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif
#import <Foundation/Foundation.h>

void sayFunction(id self, SEL _cmd, id some) {
    /*Ivar class_getInstanceVariable(Class cls, const char *name)
    **获取类中指定名称实例成员变量的信息
    **入参:类Class，变量名
    **返回:变量信息Ivar
    **实例变量是指变量不是属性.例如某类有个属性为:username 那么它对应的实例变量为_username
    **这个方法可以获取属性的变量,也可以获取私有变量(这点很重要)
    **如果获取的变量为空,那么 ivar_getName和 ivar_getTypeEncoding 获取的值为空,那么[NSString stringWithUTF8String:ivar1Name] 执行崩溃
    **/
    NSLog(@"%@岁的%@说: %@", object_getIvar(self, class_getInstanceVariable([self class], "_age")), [self valueForKey:@"name"], some);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Class People = objc_allocateClassPair([NSObject class], "Person", 0);
        
         /*动态添加变量
         **:类Class，变量名char数组，变量类型大小size_t，变量在内存中的对齐方式，变量的type类型
         **:返回:添加结果，是否成功。
         **:只能给动态创建的类添加变量也就是用 objc_allocateClassPair 创建的类
         **:添加变量只能在函数 objc_allocateClassPair 和 class_getInstanceVariable 之间添加才有效
         */
        class_addIvar(People, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
        class_addIvar(People, "_age", sizeof(int), sizeof(int), @encode(int));
        
         /*动态添加方法
         **入参:类Class，方法名SEL，方法实现IMP，方法返回值各个参数类型等配置字符串
         **其中types参数为"i@:@“，按顺序分别表示：
         **i：返回值类型int，若是v则表示void
         **@：参数id(self)
         **:：SEL(_cmd)
         **@：id(str)
         **返回:添加结果，是否成功。
         */
        SEL s = sel_registerName("say:");
        class_addMethod(People, s, (IMP)sayFunction, "v@:@");
        
        objc_registerClassPair(People);
        
        id peopleInstace = [[People alloc] init];
        
        [peopleInstace setValue:@"苍老师" forKey:@"name"];
        
        Ivar ageIvar = class_getInstanceVariable(People, "_age");
        object_setIvar(peopleInstace, ageIvar, @18);
        
        ((void (*)(id, SEL, id))objc_msgSend)(peopleInstace, s, @"大家好 ");
        
        peopleInstace = nil;
        
        objc_disposeClassPair(People);
    }
    return 0;
}
