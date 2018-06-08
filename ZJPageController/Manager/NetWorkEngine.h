//
//  NetWorkEngine.h
//  ZJMoviePlay
//
//  Created by Jion on 16/7/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkEngine : NSObject

+(void)simulation_PostWithURL:(NSString *)url parameters:(NSDictionary*)params response:(void(^)(id json))result;

@end
