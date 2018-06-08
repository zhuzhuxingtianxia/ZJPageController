//
//  ImgModel.m
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ImgModel.h"
#import <SDWebImage/SDWebImageManager.h>

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


-(CGFloat)heightCell {
    
    return 34.0;
}

@end

////////////////////////

@implementation ImgModel

- (void)mj_keyValuesDidFinishConvertingToObject {
    self.heightCell = 100.0;
    __weak typeof(self) weakSlef = self;
    //缺点：无论cell是否在可视范围内，图片资源都会下载
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:self.photo] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (image) {
            CGFloat cellH = ([UIScreen mainScreen].bounds.size.width - 10) * (image.size.height / image.size.width);
            NSLog(@"cellH = %.2f",cellH);
            weakSlef.heightCell = cellH;
            if (weakSlef.block) {
                weakSlef.block();
            }
            
        }
        
    }];
}


@end
