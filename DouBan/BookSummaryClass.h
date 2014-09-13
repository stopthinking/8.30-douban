//
//  BookSummaryClass.h
//  DouBan
//
//  Created by feng qian on 12/07/11.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"
@interface BookSummaryClass : UIViewController
<UIActionSheetDelegate>
{
    UIScrollView* scrollView;
    BookModel* bookmodel;
    NSString* bookTitle;
    UIActionSheet* sheet;
}
-(id)initWithBookModel:(BookModel*)book;

@end
