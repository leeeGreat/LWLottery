//
//  IMTableViewCell.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "IMTableViewCell.h"
#import "IMCellModel.h"
#import "IMArrowCellModel.h"
#import "IMSwitchCellModel.h"
#import "IMLabelCellModel.h"

@interface IMTableViewCell()

@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UILabel *imlabel;

@end

@implementation IMTableViewCell

- (UILabel *)imlabel{
    if (_imlabel == nil) {
        _imlabel = [[UILabel alloc] init];
        _imlabel.bounds = CGRectMake(0, 0, 200, 30);
        _imlabel.backgroundColor = [UIColor grayColor];
    }
    return  _imlabel;
}

- (UIImageView *)arrowImageView{
    if(_arrowImageView ==nil){
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowImageView;
}

- (UISwitch *)switchView{
    if(_switchView == nil){
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(StatusDidChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)StatusDidChanged{
    [[NSUserDefaults standardUserDefaults] setBool:self.switchView.isOn forKey:self.model.title];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(IMCellModel *)model{
    _model = model;
    
    //设置数据
    self.imageView.image = model.image;
    self.textLabel.text = model.title;
    self.detailTextLabel.text = model.subtitle;
    //设置辅助图标（由于加载频率太高，但是只需要执行一次，所以做成懒加载方式）
    if ([self.model isKindOfClass:[IMArrowCellModel class]]) {
        self.accessoryView = self.arrowImageView;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else if([self.model isKindOfClass:[IMSwitchCellModel class]]){
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //数据的读取（只有拿到了model之后才能取出其中的title，然后才能取出之前存储的数据）
        self.switchView.on = [[NSUserDefaults standardUserDefaults] boolForKey:self.model.title];
        
        //可以在这里根据swichView的状态进行各种设置的初始化（在各自的控制器里不知道如何取出swichView的状态(已经找到办法啦，😄)）
//        NSLog(@"%@----%d",self.model.title,self.switchView.isOn);
        
    }else if([self.model isKindOfClass:[IMLabelCellModel class]]){
        self.accessoryView = self.imlabel;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else{
        self.accessoryView = nil;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
