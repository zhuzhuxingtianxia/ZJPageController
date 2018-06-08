//
//  UIView+Appertain.m
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "UIView+Appertain.h"
#import <objc/runtime.h>
@implementation NSObject (Appertain)
-(void)setIdentifier:(NSString *)identifier {
    objc_setAssociatedObject(self, @selector(identifier), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)identifier {
    return objc_getAssociatedObject(self, @selector(identifier));
}

-(void)setHeightCell:(CGFloat)heightCell {
    objc_setAssociatedObject(self, @selector(heightCell), [NSNumber numberWithFloat:heightCell], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CGFloat)heightCell{
    return [objc_getAssociatedObject(self, @selector(heightCell)) floatValue];
}

@end

@implementation UIView (Appertain)

-(void)setData:(id)data {
    objc_setAssociatedObject(self, @selector(data), data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)data {
    return objc_getAssociatedObject(self, @selector(data));
}

-(void)setIndexPathValue:(NSIndexPath *)indexPathValue{
    objc_setAssociatedObject(self, @selector(indexPathValue), indexPathValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSIndexPath*)indexPathValue{
    return objc_getAssociatedObject(self, @selector(indexPathValue));
}

-(void)setCellType:(NSInteger)cellType{
    objc_setAssociatedObject(self, @selector(cellType), [NSNumber numberWithInteger:cellType], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSInteger)cellType{
    return [objc_getAssociatedObject(self, @selector(cellType)) integerValue];
}

-(void)setADelegate:(id<CellProtocol>)aDelegate{
    objc_setAssociatedObject(self, @selector(aDelegate), aDelegate, OBJC_ASSOCIATION_ASSIGN);
}
-(id<CellProtocol>)aDelegate{
    id<CellProtocol> obj = objc_getAssociatedObject(self, @selector(aDelegate));
    return obj;
}



@end
