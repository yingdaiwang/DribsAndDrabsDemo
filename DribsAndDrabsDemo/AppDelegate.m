//
//  AppDelegate.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "NotePadViewController.h"
#import "ShareViewController.h"
#import "SetUpViewController.h"
#import "CalendarViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    NotePadViewController *noteView = [[NotePadViewController alloc]init];
    UITabBarItem *item0 = [[UITabBarItem alloc] initWithTitle:@"记事" image:[UIImage imageNamed:@"img_mainicon_1"] tag:0];
    UINavigationController *noteNav = [[UINavigationController alloc]initWithRootViewController:noteView];
    noteNav.tabBarItem = item0;
    
    
    CalendarViewController *calendarView = [[CalendarViewController alloc]init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"日历" image:[UIImage imageNamed:@"img_mainicon_2"] tag:1];
    UINavigationController *calendarNav = [[UINavigationController alloc]initWithRootViewController:calendarView];
    calendarNav.tabBarItem = item1;
    
    ShareViewController *shareView = [[ShareViewController alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"分享" image:[UIImage imageNamed:@"img_mainicon_3_new"] tag:2];
    UINavigationController *shareNav = [[UINavigationController alloc]initWithRootViewController:shareView];
    shareNav.tabBarItem = item2;
    
    SetUpViewController *setUpView = [[SetUpViewController alloc] init];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"img_mainicon_4"] tag:3];
    UINavigationController *setUpNav = [[UINavigationController alloc]initWithRootViewController:setUpView];
    setUpNav.tabBarItem = item3;
    
    UITabBarController *myTabBarController = [[UITabBarController alloc]init];
    myTabBarController.viewControllers = [NSArray arrayWithObjects:noteNav,calendarNav,shareNav,setUpNav, nil];
    
    self.window.rootViewController = myTabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
