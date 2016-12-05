//
//  ViewController.m
//  Calender
//
//  Created by 马克鑫 on 2016/12/5.
//  Copyright © 2016年 qwe. All rights reserved.
//

#import "ViewController.h"
#import "xiaoXin_Date.h"

@interface ViewController ()
{
    UIButton *calenderBtn;
    
    UILabel  *selectDate;
    UILabel  *selectWeek;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    calenderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calenderBtn.frame = CGRectMake(10, 30, self.view.frame.size.width-30, 30);
    calenderBtn.backgroundColor = [UIColor redColor];
    [calenderBtn setTitle:@"日历" forState:UIControlStateNormal];
    [calenderBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calenderBtn];
    
    
    selectDate = [[UILabel alloc]initWithFrame:CGRectMake(0, calenderBtn.frame.origin.y+calenderBtn.frame.size.height+10, self.view.frame.size.width, 15)];
    selectDate.font = [UIFont systemFontOfSize:13.0f];
    selectDate.textAlignment = NSTextAlignmentCenter;
    selectDate.textColor = [UIColor redColor];
    [self.view addSubview:selectDate];
    
    selectWeek = [[UILabel alloc]initWithFrame:CGRectMake(0, selectDate.frame.origin.y+selectDate.frame.size.height+10, self.view.frame.size.width, 15)];
    selectWeek.font = [UIFont systemFontOfSize:13.0f];
    selectWeek.textAlignment = NSTextAlignmentCenter;
    selectWeek.textColor = [UIColor redColor];
    [self.view addSubview:selectWeek];

}
-(void)btnAction
{
    xiaoXin_Date *mkx  = [[xiaoXin_Date alloc]init];
    mkx.btnFuc=^(NSString *isDateStr , NSString *isWeekStr)
    {
        selectDate.text = isDateStr;
        selectWeek.text = isWeekStr;
        
    };
    [self.view addSubview:mkx];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
