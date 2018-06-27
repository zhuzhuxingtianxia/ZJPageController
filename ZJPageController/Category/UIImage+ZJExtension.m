//
//  UIImage+ZJExtension.m
//  ZJPageController
//
//  Created by ZZJ on 2018/6/27.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "UIImage+ZJExtension.h"

@implementation UIImage (ZJExtension)

//图片修改大小
- (UIImage*)imageWithScaledToSize:(CGSize)newSize{
    //opaque yes不透明的 no透明
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
