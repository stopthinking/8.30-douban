//
//  CommentViewController.m
//  DouBan
//
//  Created by xuefeng li on 12-7-9.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "CommentViewController.h"
#import "EBookViewController.h"
@implementation CommentViewController

-(id)init
{
    if(self = [super init])
    {
        
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
-(void)dealloc
{
    [super dealloc];
    [imageView0 release];
    [imageView1 release];
    [imageView2 release];
}

-(void)buttonClick:(UIButton*)button
{
    NSLog(@"buttonClick");
    EBookViewController* book = [[EBookViewController alloc] init];
    [self.navigationController pushViewController:book animated:YES];
}

-(void)createButtonWithFrame:(CGRect)frame tag:(NSInteger)tag
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"book%d.png",tag-100+1]] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)createImageView
{
    imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 139)];
    imageView0.image = [UIImage imageNamed:@"BookShelfCell.png"];
    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 139, 320, 139)];
    imageView1.image = [UIImage imageNamed:@"BookShelfCell.png"];
    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 139*2, 320, 139)];
    imageView2.image = [UIImage imageNamed:@"BookShelfCell.png"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"书架";
    [self createImageView];
    [self.view addSubview:imageView0];
    [self.view addSubview:imageView1];
    [self.view addSubview:imageView2];
    
    for(int i=0; i<4; i++)
    {
        if(i<3){
            CGRect rect = CGRectMake(15+i*110, 15, 70, 109);
            [self createButtonWithFrame:rect tag:100+i];
        }
        else{
            CGRect rect = CGRectMake(15, 15+139, 70, 109);
            [self createButtonWithFrame:rect tag:100+i];
        }
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

@end
