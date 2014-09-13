//
//  RootViewController.h
//  DouBan
//
//  Created by xuefeng li on 12-7-9.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface RootViewController : UIViewController
<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView* myScrollView;
    UITableView* myTableView;
    NSMutableArray* contentArray;
    NSTimer* timer;
    
    UILabel* label;
}
@property(nonatomic,retain)NSMutableArray* contentArray;
@end
