//
//  CalendarLogic.m
//  CalendarTest
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CalendarLogic.h"

@implementation CalendarLogic

@synthesize calendarLogicDelegate;
@synthesize referenceDate;

- (void)setReferenceDate:(NSDate *)aDate {
	if (aDate == nil) {
		[calendarLogicDelegate calendarLogic:self dateSelected:nil];
		return;
	}
	
	// Calculate direction of month switches
	NSInteger distance = [self distanceOfDateFromCurrentMonth:aDate];
	
	NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:aDate];	
	referenceDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    
	// Message delegate
	[calendarLogicDelegate calendarLogic:self dateSelected:aDate];
	
	// month switch?
	if (distance != 0) {
		// Changed so tell delegate
		[calendarLogicDelegate calendarLogic:self monthChangeDirection:distance];		
	}
}


#pragma mark Initialization

- (id)initWithDelegate:(id <CalendarLogicDelegate>)aDelegate referenceDate:(NSDate *)aDate {
    if ((self = [super init])) {
        // Initialization code
		self.calendarLogicDelegate = aDelegate;
		
		NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:aDate];	
		referenceDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    }
    return self;
}

#pragma mark Date computations

+ (NSDate *)dateForToday {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];	
	NSDate *todayDate = [calendar dateFromComponents:components];
	
	return todayDate;
}

+ (NSDate *)dateForWeekday:(NSInteger)aWeekday onWeek:(NSInteger)aWeek referenceDate:(NSDate *)aReferenceDate {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:aReferenceDate];
	
	NSInteger aMonth = [components month];
	NSInteger aYear = [components year];
	
	return [self dateForWeekday:(NSInteger)aWeekday 
						 onWeek:(NSInteger)aWeek 
						ofMonth:(NSInteger)aMonth 
						 ofYear:(NSInteger)aYear];
}
+ (NSDate *)dateForWeekday:(NSInteger)aWeekday 
					onWeek:(NSInteger)aWeek 
				   ofMonth:(NSInteger)aMonth 
					ofYear:(NSInteger)aYear 
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	// Select first 'firstWeekDay' in this month
	NSDateComponents *firstStartDayComponents = [[NSDateComponents alloc] init];
	[firstStartDayComponents setMonth:aMonth];
	[firstStartDayComponents setYear:aYear];
	[firstStartDayComponents setWeekday:[calendar firstWeekday]];
	[firstStartDayComponents setWeekdayOrdinal:1];
	NSDate *firstDayDate = [calendar dateFromComponents:firstStartDayComponents];
	
	// Grab just the day part.
	firstStartDayComponents = [calendar components:NSDayCalendarUnit fromDate:firstDayDate];
	NSInteger numberOfDaysInWeek = [calendar maximumRangeOfUnit:NSWeekdayCalendarUnit].length;
	NSInteger firstDay = [firstStartDayComponents day] - numberOfDaysInWeek;
	
	// Correct for day landing on the firstWeekday
	if ((firstDay - 1) == -numberOfDaysInWeek) {
		firstDay = 1;
	}
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setYear:aYear];
	[components setMonth:aMonth];
	[components setDay:(aWeek * numberOfDaysInWeek) + firstDay + (aWeekday - 1)];
	
	return [calendar dateFromComponents:components];
}

- (NSInteger)indexOfCalendarDate:(NSDate *)aDate {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	// Split
	NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit | NSMonthCalendarUnit |NSWeekCalendarUnit | NSYearCalendarUnit fromDate:aDate];
	
	
	// Select this month in this year.
	NSDateComponents *firstDayComponents = [[NSDateComponents alloc] init];
	[firstDayComponents setMonth:[components month]];
	[firstDayComponents setYear:[components year]];
	NSDate *firstDayDate = [calendar dateFromComponents:firstDayComponents];
	
	// Turn into week of a year.
	NSDateComponents *firstWeekComponents = [calendar components:NSWeekCalendarUnit fromDate:firstDayDate];
	NSInteger firstWeek = [firstWeekComponents week];
	if (firstWeek > [components week]) {
		firstWeek = firstWeek - 52;
	}
	NSInteger weekday = [components weekday];
	if (weekday < (NSInteger)[calendar firstWeekday]) {
		weekday = weekday + 7;
	}
	
	return (weekday + (([components week] - firstWeek) * 7)) - [calendar firstWeekday];
}
- (NSInteger)distanceOfDateFromCurrentMonth:(NSDate *)aDate {
	if (aDate == nil) {
		return -1;
	}
	
	NSInteger distance = 0;
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *monthComponents = [calendar components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:referenceDate];
	NSDate *firstDayInMonth = [calendar dateFromComponents:monthComponents];
	[monthComponents setDay:[calendar rangeOfUnit:NSDayCalendarUnit
										   inUnit:NSMonthCalendarUnit
										  forDate:referenceDate].length];
	NSDate *lastDayInMonth = [calendar dateFromComponents:monthComponents];
	
	// Lower
	NSInteger distanceFromFirstDay = [[calendar components:NSDayCalendarUnit fromDate:firstDayInMonth toDate:aDate options:0] day];
	if (distanceFromFirstDay < 0) {
		distance = distanceFromFirstDay;
	}
	
	// Greater
	NSInteger distanceFromLastDay = [[calendar components:NSDayCalendarUnit fromDate:lastDayInMonth toDate:aDate options:0] day];
	if (distanceFromLastDay > 0) {
		distance = distanceFromLastDay;
	}
	
	return distance;
}

- (void)selectPreviousMonth {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setMonth:-1];
	
	referenceDate = [calendar dateByAddingComponents:components toDate:referenceDate options:0];
	[calendarLogicDelegate calendarLogic:self monthChangeDirection:-1];	
}
- (void)selectNextMonth {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setMonth:1];
	
	referenceDate = [calendar dateByAddingComponents:components toDate:referenceDate options:0];
	[calendarLogicDelegate calendarLogic:self monthChangeDirection:1];
}

@end
