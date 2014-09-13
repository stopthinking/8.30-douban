//
//  EBookViewController.m
//  EBook
//
//  Created by qianfeng on 12-2-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EBookViewController.h"

@implementation EBookViewController

-(void)loadView
{
    [super loadView];
    
    self.title = @"龙门帮风云";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"21.png"]];
}
//非全屏
-(void)prepareArray
{
    CGFloat width=self.view.frame.size.width;
	CGFloat height=self.view.frame.size.height-49;
	
	CGSize maxSize=CGSizeMake(width, height*2);
	
	_rangesArray=
	[[self rangesWithFont:_contentLabel.font
        constrainedToSize:maxSize
            lineBreakMode:_contentLabel.lineBreakMode] retain];
    
	NSString* contentString=
	[self contentStringByPage:_curPage];
	
	_contentLabel.text=contentString;
}

-(void)createView
{
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    view.backgroundColor = [UIColor darkGrayColor];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
	label.numberOfLines=0;
	label.backgroundColor=[UIColor clearColor];
	label.textColor=[UIColor yellowColor];
	
	UIFont* font=[UIFont fontWithName:@"Arial" 
								 size:20];
	label.font=font;
	label.lineBreakMode=UILineBreakModeWordWrap;
	_contentLabel=label;
    [view addSubview:label];
	[self.view addSubview:view];
 
}

-(void)modelchange
{
    if(isDark)
    {
        isDark = NO;
        self.navigationItem.rightBarButtonItem.title = @"夜间模式";
        view.backgroundColor = [UIColor clearColor];
    }else
    {
        isDark  = YES;
        self.navigationItem.rightBarButtonItem.title = @"白天模式";
        view.backgroundColor = [UIColor darkGrayColor];
    }

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    
	//read file
	
	
	NSBundle* bundle=[NSBundle mainBundle];
	NSLog(@"%@", [bundle bundlePath]);
	 
	
	NSString* path=[[NSBundle mainBundle]
					pathForResource:@"1"
					ofType:@"txt"];
	
	NSError* error=nil;
	
	_fileContent=[[NSString 
			stringWithContentsOfFile:path 
			encoding:NSUTF8StringEncoding
				error:&error] retain];
	if(error!=nil)
	{
		NSLog(@"%@", error);
		exit(-1);
	}
	//有Bar时
    
    [self prepareArray];

    
  
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"夜间模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelchange)];

    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
}


-(void)dealloc
{
    [_fileContent release];
	[_rangesArray release];
   
	[super dealloc];
}

-(NSArray*)rangesWithFont:(UIFont*)font 
		constrainedToSize:(CGSize)size
            lineBreakMode:(UILineBreakMode)lbk
{
	NSMutableArray* ma=[NSMutableArray 
						arrayWithCapacity:0];
	NSRange tryRange=NSMakeRange(0, 0);
	CGSize trySize;
	NSString* tryString;
	NSString* str=_fileContent;
	
//	CGFloat height=self.view.frame.size.height;
    CGFloat height = self.view.frame.size.height - 49-44-5;
	BOOL flag;
	
	while (tryRange.location+tryRange.length<
		   [str length])
	{
		flag=NO;
		tryRange.length++;
		tryString=[str substringWithRange:tryRange];
		
		trySize=[tryString
				 sizeWithFont:font
				 constrainedToSize:size
				 lineBreakMode:lbk];
		if (trySize.height>height) {
			flag=YES;
			tryRange.length--;
			[ma addObject:
			 [NSValue valueWithRange:tryRange]];
			NSLog(@"%@", NSStringFromRange(tryRange));
			tryRange.location+=tryRange.length;
			tryRange.length=0;
		}
		
	}
	if (!flag) {
		[ma addObject:
		 [NSValue valueWithRange:tryRange]];
		NSLog(@"%@", NSStringFromRange(tryRange));
	}
	
	return [NSArray arrayWithArray:ma];
	
}


-(NSString*)contentStringByPage:(int)page
{
	NSValue* val=[_rangesArray objectAtIndex:page];
	NSRange range=[val rangeValue];
	return [_fileContent substringWithRange:range];
}
-(void)prevPage
{
	if (0==_curPage) {
		return;
	}
	
	_curPage--;
	NSString* str=[self contentStringByPage:_curPage];
	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
    [UIView setAnimationDuration:0.5f];
	_contentLabel.text=str;
    [UIView commitAnimations];
}
-(void)nextPage
{
	if (_curPage==_rangesArray.count-1) {
		return;
	}
	_curPage++;
	
	NSString* str=[self contentStringByPage:_curPage];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:view cache:YES];
    [UIView setAnimationDuration:0.5f];
	_contentLabel.text=str;
    [UIView commitAnimations];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];

    if([touch tapCount] == 2)
    {
       if(isShow)
       {
//           isShow = NO;
//           self.navigationController.navigationBar.hidden = YES;
//           self.tabBarController.tabBar.hidden = YES;
//           return;
       }else
       {
//           isShow = YES;
//           self.navigationController.navigationBar.hidden = NO;
//           self.tabBarController.tabBar.hidden = NO;
//           return;
       }
    }else if([touch tapCount] == 1)
    {
        if(point.x > 160)
        {
            [self nextPage];
        }else
        {
            [self prevPage];
        }
    }
    
}

@end
