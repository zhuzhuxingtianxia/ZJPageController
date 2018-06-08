//
//  ImgModel.h
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import "UIView+Appertain.h"
@class ImgModel;
@interface TitleModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString  *colorValue;

@property(nonatomic,strong)NSArray<ImgModel*> *images;

@end

@interface ImgModel : NSObject
@property (nonatomic,copy)NSString *photo;

//
@property(nonatomic,copy)dispatch_block_t  block;
@end
