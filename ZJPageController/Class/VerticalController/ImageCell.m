//
//  ImageCell.m
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(id)data {
    ImgModel *model = (ImgModel*)data;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.photo] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
