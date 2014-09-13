//
//  EBookViewController.h
//  EBook
//
//  Created by qianfeng on 12-2-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBookViewController : UIViewController 
{
	int _curPage;//用来记录当前显示的内容处于第几页
    UILabel* _contentLabel;//用来显示内容的label
    NSString* _fileContent;//整个文件内容
    NSArray* _rangesArray;//保存分割后的range
    
    BOOL isShow;
    BOOL isDark;
    
    UIView* view;
}
/*
 分割函数，用来分割_fileContent
 font：label用什么字体显示
 size：最大不能超过的size，应该比view的高要高一些
 lbk：label的折行方式
 
 返回分割好的range数组
 */

-(NSArray*)rangesWithFont:(UIFont*)font 
		constrainedToSize:(CGSize)size
            lineBreakMode:(UILineBreakMode)lbk;


//根据要显示的页码，过得对应的要显示的内容
-(NSString*)contentStringByPage:(int)page;


@end

