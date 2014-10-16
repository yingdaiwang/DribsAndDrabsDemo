//
//  CalendarLogic.h
//  CalendarTest
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalendarLogic;

@protocol CalendarLogicDelegate

- (void)calendarLogic:(CalendarLogic *)aLogic dateSelected:(NSDate *)aDate;
- (void)calendarLogic:(CalendarLogic *)aLogic monthChangeDirection:(NSInteger)aDirection;

@end

@interface CalendarLogic : NSObject

@property (nonatomic, assign) id <CalendarLogicDelegate> calendarLogicDelegate;
@property (nonatomic, strong) NSDate *referenceDate;

- (id)initWithDelegate:(id <CalendarLogicDelegate>)aDelegate referenceDate:(NSDate *)aDate;

+ (NSDate *)dateForToday;

+ (NSDate *)dateForWeekday:(NSInteger)aWeekday 
					onWeek:(NSInteger)aWeek 
				   ofMonth:(NSInteger)aMonth 
					ofYear:(NSInteger)aYear;

+ (NSDate *)dateForWeekday:(NSInteger)aWeekday 
                    onWeek:(NSInteger)aWeek 
             referenceDate:(NSDate *)aReferenceDate;

- (NSInteger)indexOfCalendarDate:(NSDate *)aDate;

- (NSInteger)distanceOfDateFromCurrentMonth:(NSDate *)aDate;

//上个月
- (void)selectPreviousMonth;

//下个月
- (void)selectNextMonth;

@end
