//
//  xiaoXin_Date.h
//  Calender
//
//  Created by 马克鑫 on 2016/12/5.
//  Copyright © 2016年 qwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xiaoXin_Date : UIView
@property(nonatomic,strong) UIView    *backgroundView;

@property(nonatomic,strong) UIView    *dateView;
@property(nonatomic,strong) UIView    *dateHead;
@property(nonatomic,strong) UIButton  *leftBtn;
@property(nonatomic,strong) UIButton  *rightBtn;
@property(nonatomic,strong) UILabel   *dateLabel;
@property(nonatomic,strong) UILabel   *dateWeek;

@property(nonatomic,strong) UIView    *weeksView;
@property(nonatomic,strong) UIView    *daysBtnView;



@property(nonatomic,strong) NSDate   *nowDate;   //切换的日期


@property(nonatomic,assign) NSInteger mkx_firstDay;

@property(nonatomic,assign) NSInteger mkx_oldYear;

@property(nonatomic,assign) NSInteger mkx_oldMonth;

@property(nonatomic,assign) NSInteger mkx_oldDay;

@property(nonatomic,assign) NSInteger mkx_nowYear;

@property(nonatomic,assign) NSInteger mkx_nowMonth;

@property(nonatomic,assign) NSInteger mkx_nowDay;

@property(nonatomic,copy)void(^btnFuc) (NSString *isDateStr , NSString *isWeekStr);


@end
