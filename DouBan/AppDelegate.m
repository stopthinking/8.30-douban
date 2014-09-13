//
//  AppDelegate.m
//  DouBan
//
//  Created by xuefeng li on 12-7-9.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "SearchViewController.h"
//#import "ZBarViewController.h"
#import "BookMarksViewController.h"
#import "CommentViewController.h"

@implementation AppDelegate

@synthesize window = _window,collectArray,searchCollectArray;

- (void)dealloc
{
    [_window release];
    [collectArray release];
    [searchCollectArray release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    collectArray = [[NSMutableArray alloc] initWithCapacity:0];
    searchCollectArray = [[NSMutableArray alloc] init];
    //1,首页，推荐内容
    RootViewController *rvc = [[RootViewController alloc] init];
    UINavigationController *nav1 = [[[UINavigationController alloc] initWithRootViewController:rvc] autorelease];
    [rvc release];
    UITabBarItem *homeBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home.png"] tag:1];
    nav1.tabBarItem = homeBarItem;
    
    //2,豆瓣搜书
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    UINavigationController *nav2 = [[[UINavigationController alloc] initWithRootViewController:searchViewController] autorelease];
    [searchViewController release];
    UITabBarItem *searchBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"search.png"] tag:2];
    nav2.tabBarItem = searchBarItem;
    [searchBarItem release];
    
    //3,二维码扫描
//    ZBarViewController *zBarViewController = [[ZBarViewController alloc] init];
//    UINavigationController *nav3 = [[[UINavigationController alloc] initWithRootViewController:zBarViewController] autorelease];
//    [zBarViewController release];
//    UITabBarItem *zBarItem = [[UITabBarItem alloc] initWithTitle:@"二维码扫描" image:[UIImage imageNamed:@"scan.png"] tag:3];
//    nav3.tabBarItem = zBarItem;
//    [zBarItem release];
    
    //本地收藏
    BookMarksViewController * bookMarksViewController = [[[BookMarksViewController alloc] init] autorelease];
    UINavigationController * nav4 = [[[UINavigationController alloc] initWithRootViewController:bookMarksViewController] autorelease];
    [nav4.tabBarItem initWithTitle:@"收藏" image:[UIImage imageNamed:@"shoucang.png"] tag:4];
    
    
    //评论：
    CommentViewController *commentViewController = [[[CommentViewController alloc] init] autorelease];
    UINavigationController *nav5 = [[[UINavigationController alloc] initWithRootViewController:commentViewController]autorelease];
    [nav5.tabBarItem initWithTitle:@"书架" image:[UIImage imageNamed:@"comment.png"] tag:5];
    
    NSArray *arrayTabs = [NSArray arrayWithObjects:nav1, nav2, nav4, nav5, nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = arrayTabs;
    tabBarController.selectedIndex = 1;
    
    self.window.rootViewController = tabBarController;
    [tabBarController release];
    
    
    
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
