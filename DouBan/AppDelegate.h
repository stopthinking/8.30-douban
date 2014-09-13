//
//  AppDelegate.h
//  DouBan
//
//  Created by xuefeng li on 12-7-9.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SHAREDAPP ((AppDelegate*)[[UIApplication sharedApplication] delegate])
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    //首页推荐书籍收藏
    NSMutableArray* collectArray;
    //网络搜索书籍收藏
    NSMutableArray* searchCollectArray;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)NSMutableArray* collectArray;
@property(nonatomic,retain)NSMutableArray* searchCollectArray;
@end
