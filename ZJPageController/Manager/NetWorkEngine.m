//
//  NetWorkEngine.m
//  ZJMoviePlay
//
//  Created by Jion on 16/7/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "NetWorkEngine.h"

@implementation NetWorkEngine

//模拟请求
+(void)simulation_PostWithURL:(NSString *)url parameters:(NSDictionary*)params response:(void(^)(id json))result{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:nil];
        if (!path) {
            NSLog(@"没有找到模拟文件");
            result(nil);
            return ;
        }
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (data && json==nil) {
            NSLog(@"Json格式错误");
            result(nil);
            return;
        }
        result(json);
        
    });
    
}

static NSString *getJsonStringByDictionary(NSDictionary *dictionary,NSStringEncoding encoding){
    if(!dictionary)return nil;
    if(!encoding)return nil;
    NSData *JSONData = getJSONDataFromObject(dictionary);
    return [[NSString alloc] initWithData:JSONData encoding:encoding];
}

static NSData *getJSONDataFromObject(id obj){
    if(!obj)return nil;
    
    if([NSJSONSerialization isValidJSONObject:obj]){
        
        NSError *error = nil;
        
        return [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
        
    }
    
    return nil;
}


@end
