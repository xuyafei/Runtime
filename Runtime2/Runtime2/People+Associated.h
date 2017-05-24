//
//  People+Associated.h
//  Runtime2
//
//  Created by polycom on 2017/5/24.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "People.h"
typedef void (^CodingCallBack)();

@interface People (Associated)

@property (nonatomic, strong) NSNumber *associatedBust;
@property (nonatomic, copy)   CodingCallBack associatedCallBack;

@end
