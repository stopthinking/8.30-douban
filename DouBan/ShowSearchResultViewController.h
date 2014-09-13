//
//  ShowSearchResultViewController.h
//  DouBan
//
//  Created by feng qian on 12/07/11.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface ShowSearchResultViewController : UIViewController
<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView* myTableView;
    NSMutableArray* contentArray;
    NSString* searchWord;
    
    NSString* bookSum;//用来保存书的简介
    NSMutableArray* bookSumArray;//用来存放书简介的数组
    
    NSInteger startIndex;
    
    BOOL isLoading;
    BOOL isArrayCreate;
}
@property(nonatomic,retain)NSMutableArray* contentArray;
@property(nonatomic,retain)NSString* searchWord;
-(id)initWithSearchWord:(NSString*)string;

@end
