//
//  TitleCell.m
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "TitleCell.h"

@interface TitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *lineView;

@end
@implementation TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setData:(id)data {
    TitleModel *model = (TitleModel*)data;
    _titleLabel.text = model.title;
    _titleLabel.textColor = [UIColor colorHexString:model.colorValue];
    for (UIView *view in _lineView) {
        view.backgroundColor = _titleLabel.textColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
