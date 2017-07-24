//
//  PlayInstructionController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/18.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "PlayInstructionController.h"

@interface PlayInstructionController ()

@end

@implementation PlayInstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = @"玩法说明";
    NSString *str = @"杀号,杀二码,杀三码,杀六码,杀十码杀号定义为不会出现的号码,需要排除掉的号码,杀二码,杀三码,杀六码,杀十码意思是排除两个三个,六个十个不会出现的号码;\n胆码:独担,双胆,三胆\n胆码定义为会开出的号码,独担,双胆,三胆表示会开出的号码为一个,两个,三个.\n蓝球杀五码,蓝球定三胆,蓝球定五胆,蓝球杀号\n蓝球杀五码是排除五个号码,蓝球定三胆为三个中可能会出一个,蓝球定五胆为五个中可能会出一个,蓝球杀号定义把不会出的蓝球排除掉.\n个位杀二码,十位杀二码,百位杀二码,千位杀二码,万位杀二码\n比如福彩3D开奖号码为3,5,7,那么个位为7,十位为5,百位为3.比如排列五开奖号码为1,3,5,7,8,9.万位是1,千位是3.\n个位杀二码的意思是把个位上不会出现的号码排除掉.\n第一位杀二码,第二位杀二码,第三位杀二码,第四位杀二码,第五位杀二码,第六位杀二码,第七位杀二码\n比如七星彩开奖号码为1,3,5,7,8,9,0,2,那么第一位是1,第二为是3,第七位是2.\n第一位杀二码的意思是把第一位上不会出现的号码排除掉.\n后区杀三码,后区定六码\n后区定三码定义为把后区三个号码排除掉,后区定六码定义为可能会出现一个或者两个后区号码\n";
    
    self.instructionTextView.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
