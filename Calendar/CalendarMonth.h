//
//  CalendarMonth.h
//  CalendarTest
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarLogic;

@interface CalendarMonth : UIView
{
    CalendarLogic *aLogicNum;
    NSArray *dayNotesArray;

}

@property (nonatomic, strong) CalendarLogic *calendarLogic;
@property (nonatomic, strong) NSArray *datesIndex;
@property (nonatomic, strong) NSArray *buttonsIndex;

@property (nonatomic) NSInteger numberOfDaysInWeek;
@property (nonatomic) NSInteger selectedButton;
@property (nonatomic, strong) NSDate *selectedDate;

- (id)initWithFrame:(CGRect)frame logic:(CalendarLogic *)aLogic;

- (void)selectButtonForDate:(NSDate *)aDate;

@end
