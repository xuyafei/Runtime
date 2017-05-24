//
//  People.h
//  Runtime2
//
//  Created by polycom on 2017/5/24.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject {
    NSString *_occupation;
    NSString *_nationality;
}

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSUInteger age;

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

@end
