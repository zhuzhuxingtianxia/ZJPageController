//
//  ImgModel.m
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ImgModel.h"

@implementation TitleModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"images":ImgModel.class,
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Id":@"id",
             };
    
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    
}

@end

////////////////////////

@implementation ImgModel

@end
