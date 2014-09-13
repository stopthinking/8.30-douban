//
//  ShareBookViewController.m
//  DouBan
//
//  Created by xuefeng li on 12-7-12.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "ShareBookViewController.h"
#import <QuartzCore/QuartzCore.h>
@implementation ShareBookViewController

@synthesize shareText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(weiboShare)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [rightBarItem release];
    //self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sharebg.png"]];
    
    shareText = [[NSString alloc] initWithFormat:@"我在豆瓣客户端发现一本不错的书《%@》推荐大家阅读~~~",shareText];
    
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 140)];
    myTextView.text = shareText;
    myTextView.font = [UIFont fontWithName:@"Arial" size:18];
    [myTextView becomeFirstResponder];
    //[myTextView setKeyboardAppearance:YES];
    //设置UITextView 为圆角
    myTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    myTextView.layer.borderWidth =1.0;
    myTextView.layer.cornerRadius =5.0;
    [self.view addSubview:myTextView];
    
}

- (void)weiboShare
{
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/statuses/update.json"];
    ASIFormDataRequest *postTextWeibo = [ASIFormDataRequest requestWithURL:url];
    NSString *authToken = [OAuthLoginController getCurrentToken];
    //NSString *text = myTextView.text;
    NSString *text = myTextView.text;
    NSLog(@"%@", text);
    [postTextWeibo setPostValue:authToken forKey:@"access_token"];
    NSLog(@"22");
    [postTextWeibo setPostValue:text  forKey:@"status"];
    NSLog(@"222");
    [postTextWeibo setPostValue:@"40.034753" forKey:@"lat"];
    [postTextWeibo setPostValue:@"116.311435" forKey:@"long"];
    [postTextWeibo setDelegate:self];
    NSLog(@"2222");
    [postTextWeibo setTag:101];
    NSLog(@"%2222@", text);
    [postTextWeibo startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([request tag] == 101) {
        NSLog(@"post text weibo is %@\r\n发送成功", [request responseString]);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)dealloc
{
    [shareText release];
    [myTextView release];
}



@end
