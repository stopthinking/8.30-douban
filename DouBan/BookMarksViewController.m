//
//  BookMarksViewController.m
//  DouBan
//
//  Created by xuefeng li on 12-7-9.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "BookMarksViewController.h"
#import "AppDelegate.h"
#import "BookModel.h"
#import "BookSummaryClass.h"

@implementation BookMarksViewController

-(id)init
{
    if(self = [super init])
    {
        self.title = @"我的收藏";
    }
    return self;
}

-(void)reloadViewData
{
    if([SHAREDAPP.collectArray count]>0)
    {
        collctView.delegate = self;
        collctView.dataSource = self;
        [self.view addSubview:collctView];
        [collctView reloadData];

    }
}
#pragma mark - View lifecycle
-(void)dealloc
{
    [collctView release];
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"desk.jpg"]];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(reloadViewData)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    collctView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    collctView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"desk.jpg"]];
//    collctView.backgroundView = (UIView*)[UIImage imageNamed:@"desk.png"];
    if([SHAREDAPP.collectArray count]>0)
    {
        collctView.delegate = self;
        collctView.dataSource = self;
        [self.view addSubview:collctView];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SHAREDAPP.collectArray count]+[SHAREDAPP.searchCollectArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString* cellID = @"cellID";
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        BookModel* book = [SHAREDAPP.collectArray objectAtIndex:indexPath.row];
        cell.textLabel.text = book.title;
   
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
           [SHAREDAPP.collectArray removeObjectAtIndex:indexPath.row];
            
    [collctView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        BookSummaryClass* summaryClass = [[BookSummaryClass alloc] initWithBookModel:[SHAREDAPP.collectArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:summaryClass animated:YES];
}
@end
