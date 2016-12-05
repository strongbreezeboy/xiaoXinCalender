//
//  xiaoXin_Date.m
//  Calender
//
//  Created by 马克鑫 on 2016/12/5.
//  Copyright © 2016年 qwe. All rights reserved.
//

#import "xiaoXin_Date.h"
#define ww  [UIScreen mainScreen].bounds.size.width
#define hh  [UIScreen mainScreen].bounds.size.height
#define days_WW  ww/7.0


@implementation xiaoXin_Date
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self creatDateView];
    }
    return self;
}

-(void)creatDateView
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //背景
    _backgroundView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    _backgroundView.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [_backgroundView addGestureRecognizer:tap];
    [window addSubview:_backgroundView];
    
    
    
    
    NSDate *date = [NSDate date];
    _nowDate = date;
    _mkx_oldYear = [self year:date];
    _mkx_oldMonth = [self month:date];
    _mkx_oldDay = [self day:date];
    
    _mkx_nowYear = _mkx_oldYear;
    _mkx_nowMonth = _mkx_oldMonth;
    _mkx_nowDay = _mkx_oldDay;
    
    NSInteger weeks = [self monthWithWeeks:date];
    NSInteger dayesHH = days_WW*weeks;
    
    NSString *weekStr = [self btnSelectDate:date];
    
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, hh/2.0-(60+dayesHH)/2.0, ww, 60+dayesHH)];
    _dateView.backgroundColor = [UIColor whiteColor];
    _dateView.userInteractionEnabled = YES;
    [_backgroundView addSubview:_dateView];
    
    
    _dateHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ww, 40)];
    _dateHead.backgroundColor = [UIColor greenColor];
    [_dateView addSubview:_dateHead];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [_leftBtn setTitle:@"上月" forState:UIControlStateNormal];
    _leftBtn.backgroundColor = [UIColor redColor];
    _leftBtn.tag = 10010;
    [_leftBtn addTarget:self action:@selector(monthBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_dateHead addSubview:_leftBtn];
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(ww-40, 0, 40, 40);
    [_rightBtn setTitle:@"下月" forState:UIControlStateNormal];
    _rightBtn.backgroundColor =[UIColor redColor];
    _rightBtn.tag = 10011;
    [_rightBtn addTarget:self action:@selector(monthBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_dateHead addSubview:_rightBtn];
    
    //显示当前年月
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leftBtn.frame.origin.x+_leftBtn.frame.size.width, 0, ww-_leftBtn.frame.size.width*2, 20)];
    _dateLabel.textColor = [UIColor redColor];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.text = [NSString stringWithFormat:@"%ld-%ld",_mkx_oldYear,_mkx_oldMonth];
    [_dateHead addSubview:_dateLabel];
    
    //显示当前星期
    _dateWeek = [[UILabel alloc]initWithFrame:CGRectMake(_dateLabel.frame.origin.x, _dateLabel.frame.origin.y+_dateLabel.frame.size.height, _dateLabel.frame.size.width, 20)];
    _dateWeek.textColor = [UIColor redColor];
    _dateWeek.font = [UIFont systemFontOfSize:13.0f];
    _dateWeek.textAlignment = NSTextAlignmentCenter;
    _dateWeek.text = weekStr;
    [_dateHead addSubview:_dateWeek];
    
    NSArray *arr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    _weeksView = [[UIView alloc]initWithFrame:CGRectMake(0, _dateHead.frame.origin.y+_dateHead.frame.size.height, ww, 20)];
    _weeksView.backgroundColor = [UIColor cyanColor];
    [_dateView addSubview:_weeksView];
    for (int i = 0; i<arr.count; i++)
    {
        UILabel *weekName = [[UILabel alloc]initWithFrame:CGRectMake(i*days_WW, 0, days_WW, 20)];
        weekName.text = [NSString stringWithFormat:@"%@",[arr objectAtIndex:i]];
        weekName.font = [UIFont systemFontOfSize:13.0f];
        weekName.textAlignment = NSTextAlignmentCenter;
        [_weeksView addSubview:weekName];
    }
    
    
    _daysBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, _weeksView.frame.origin.y+_weeksView.frame.size.height, ww, dayesHH)];
    [_dateView addSubview:_daysBtnView];
    [self creatBtns];
}



#pragma mark - 隐藏视图
-(void)tapView
{
    [_backgroundView removeFromSuperview];
}


#pragma mark - 上下  月 的按钮方法
-(void)monthBtn:(UIButton *)btn
{
    switch (btn.tag)
    {
        case 10010:
        {
            NSLog(@"上一个月");
            _nowDate = [self lastMonthDate:_nowDate];
            NSInteger weeks = [self monthWithWeeks:_nowDate];
            NSInteger dayesHH = days_WW*weeks;
            _dateView.frame = CGRectMake(0, hh/2.0-(60+dayesHH)/2.0, ww, 60+dayesHH);
            _daysBtnView.frame = CGRectMake(0, _weeksView.frame.origin.y+_weeksView.frame.size.height, ww, dayesHH);
            _mkx_nowYear = [self year:_nowDate];
            _mkx_nowMonth = [self month:_nowDate];
            _mkx_nowDay = [self day:_nowDate];
            _dateLabel.text = [NSString stringWithFormat:@"%ld-%ld",_mkx_nowYear,_mkx_nowMonth];
            
            [self creatBtns];
        }
            break;
        case 10011:
        {
            NSLog(@"下一个月");
            _nowDate = [self nextMonthDate:_nowDate];
            NSInteger weeks = [self monthWithWeeks:_nowDate];
            NSInteger dayesHH = days_WW*weeks;
            _dateView.frame = CGRectMake(0, hh/2.0-(60+dayesHH)/2.0, ww, 60+dayesHH);
            _daysBtnView.frame = CGRectMake(0, _weeksView.frame.origin.y+_weeksView.frame.size.height, ww, dayesHH);
            _mkx_nowYear = [self year:_nowDate];
            _mkx_nowMonth = [self month:_nowDate];
            _mkx_nowDay = [self day:_nowDate];
            _dateLabel.text = [NSString stringWithFormat:@"%ld-%ld",_mkx_nowYear,_mkx_nowMonth];
            [self creatBtns];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 创建时间按钮
-(void)creatBtns
{
    for (UIButton *btn in [_daysBtnView subviews])
    {
        [btn removeFromSuperview];
    }
    _mkx_nowYear = [self year:_nowDate];
    _mkx_nowMonth = [self month:_nowDate];
    _mkx_nowDay = [self day:_nowDate];
    NSMutableArray *dateArray = [NSMutableArray arrayWithCapacity:0];
    
    //获取前一个月的天数(前面的数据)
    NSDate *tempDate = [self lastMonthDate:_nowDate];
    NSInteger days = [self monthOfDays:tempDate];
    
    
    //当前月的第一天所在的位置
    NSInteger week = [self monthFirstDayIsWeek:_nowDate];
    NSInteger index = 7 - week ;
    _mkx_firstDay = index;
    for (int i = (int)index ; i>0; i--)
    {
        NSString *num = [NSString stringWithFormat:@"%ld",days - i +1];
        [dateArray addObject:num];
    }
    NSInteger Nowdays = [self monthOfDays:_nowDate];
    for (int i = 0 ; i<Nowdays; i++)
    {
        NSString *num = [NSString stringWithFormat:@"%d",i+1];
        [dateArray addObject:num];
    }
    for (int i = 0 ; i<dateArray.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i-(i/7)*7)*days_WW, i/7*days_WW, days_WW, days_WW);
        [btn setTitle:[NSString stringWithFormat:@"%@",[dateArray objectAtIndex:i]] forState:UIControlStateNormal];
        if (i<index)
        {
            btn.backgroundColor = [UIColor greenColor];
        }
        else
        {
            if (_mkx_nowYear == _mkx_oldYear)
            {
                if (_mkx_nowMonth == _mkx_oldMonth)
                {
                    if (i-index+1 == _mkx_oldDay)
                    {
                        btn.backgroundColor = [UIColor purpleColor];
                    }
                    else
                    {
                        btn.backgroundColor = [UIColor orangeColor];
                    }
                }
                else
                {
                    btn.backgroundColor = [UIColor orangeColor];
                }
            }
            else
            {
                btn.backgroundColor = [UIColor orangeColor];
            }
            btn.tag = i;
            [btn addTarget:self action:@selector(DaybtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
        [_daysBtnView addSubview:btn];
    }
    
    
}


#pragma mark - 日期按钮的方法
-(void)DaybtnAction:(UIButton *)btn
{
    
    NSString *day = [NSString stringWithFormat:@"%ld-%ld-%ld",_mkx_nowYear,_mkx_nowMonth,btn.tag-_mkx_firstDay+1];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * btnDate = [dateFormatter dateFromString:day];
    NSString * weekName = [self btnSelectDate:btnDate];
    
    self.btnFuc(day,weekName);
    
    for (UIButton *Abtn in [_daysBtnView subviews])
    {
        if (Abtn.tag == btn.tag)
        {
            Abtn.backgroundColor = [UIColor blueColor];
        }
        else
        {
            if (Abtn.tag < _mkx_firstDay)
            {
                Abtn.backgroundColor = [UIColor greenColor];
            }
            else if (Abtn.tag >= _mkx_firstDay+1)
            {
                if (_mkx_nowYear == _mkx_oldYear)
                {
                    if (_mkx_nowMonth == _mkx_oldMonth)
                    {
                        if (Abtn.tag-_mkx_firstDay+1 == _mkx_oldDay)
                        {
                            Abtn.backgroundColor = [UIColor purpleColor];
                        }
                        else
                        {
                            Abtn.backgroundColor = [UIColor orangeColor];
                        }
                        
                    }
                    else
                    {
                        Abtn.backgroundColor = [UIColor orangeColor];
                    }
                }
            }
            else
            {
                Abtn.backgroundColor = [UIColor orangeColor];
            }
        }
    }
    
}









#pragma mark - 获取当前年
-(NSInteger)year:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    NSDateComponents *dateComponent = [calender components:NSCalendarUnitYear fromDate:date];
    return [dateComponent year];
}

#pragma mark - 获取当前月
-(NSInteger)month:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    
    NSDateComponents *dateComponent = [calender components:NSCalendarUnitMonth fromDate:date];
    return [dateComponent month];
}

#pragma mark - 获取当前日
-(NSInteger)day:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    NSDateComponents *dateComponent = [calender components:NSCalendarUnitDay fromDate:date];
    return [dateComponent day];
}

#pragma mark - 当前时
-(NSInteger)hours:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    NSDateComponents *dateComponent = [calender components:NSCalendarUnitHour fromDate:date];
    return [dateComponent hour];
}

#pragma mark - 当前分
-(NSInteger)minute:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    
    NSDateComponents *dateComponent = [calender components:NSCalendarUnitMinute fromDate:date];
    return [dateComponent minute];
}


#pragma mark - 当前月返回的天数
-(NSInteger)monthOfDays:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    NSInteger days = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    return days;
}


#pragma mark - 当前月份的第一天 是周几
-(NSInteger)monthFirstDayIsWeek:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    [calender setFirstWeekday:1];
    NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comps setDay:1];
    NSDate *newDate =  [calender dateFromComponents:comps];
    NSInteger week = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:newDate];
    return 8 - week;
}


#pragma mark - 一个月有几周
-(NSInteger)monthWithWeeks:(NSDate *)date
{
    NSInteger weeks = 0;
    NSInteger weekday = [self monthFirstDayIsWeek:date];
    NSInteger oneWeek_day = 7-(7 - weekday);
    NSInteger monthdays = [self monthOfDays:date];
    NSInteger remaining = monthdays - oneWeek_day;
    weeks = weeks + remaining/7+1;
    remaining % 7 > 0 ? weeks+=1 :weeks;
    return weeks;
}

#pragma mark - 上个月
-(NSDate *)lastMonthDate:(NSDate *)date
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    NSDateComponents *components = [calender components:(NSCalendarUnitWeekday | NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
    if ([components month] == 1) {
        [components setMonth:12];
        [components setYear:[components year] - 1];
    } else {
        [components setMonth:[components month] - 1];
    }
    NSDate *lastMonth = [calender dateFromComponents:components];
    return lastMonth;
}



#pragma mark -下个月
-(NSDate *)nextMonthDate:(NSDate *)date
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    
    NSDateComponents *components = [calender components:(NSCalendarUnitWeekday|NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
    if ([components month] == 12) {
        [components setMonth:1];
        [components setYear:[components year] + 1];
    } else {
        [components setMonth:[components month] + 1];
    }
    NSDate *lastMonth = [calender dateFromComponents:components];
    return lastMonth;
}



#pragma mark - 返回选择的日期 为 星期几
-(NSString *)btnSelectDate:(NSDate *)date
{
    NSArray *array = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSString *dateName = [NSString string];
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    [calender setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //设置时区，设置为 GMT+8，即北京时间(+8)
    [calender setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSDate *newDate =  [calender dateFromComponents:comps];
    NSInteger week = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:newDate];
    dateName = [NSString stringWithFormat:@"%@",[array objectAtIndex:7-(8-week)]];
    return dateName;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
