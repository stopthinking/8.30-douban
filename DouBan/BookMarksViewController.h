//
//  BookMarksViewController.h
//  DouBan
//
//  Created by xuefeng li on 12-7-9.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarksViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* collctView;
}
@end
