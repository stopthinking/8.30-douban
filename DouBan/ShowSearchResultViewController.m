//
//  ShowSearchResultViewController.m
//  DouBan
//
//  Created by feng qian on 12/07/11.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "ShowSearchResultViewController.h"
#import "ASIHTTPRequest.h"
#import "SBookCell.h"
#import "BookModel.h"
#import "CONST.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BookSummaryClass.h"
#import "NSString+URLEncoding.h"
@implementation ShowSearchResultViewController
@synthesize contentArray,searchWord;
-(id)initWithSearchWord:(NSString*)string
{
    if(self = [super init])
    {
        contentArray = [[NSMutableArray alloc] init];
        bookSumArray = [[NSMutableArray alloc] init];
        searchWord = [string retain];
        bookSum = [[NSString alloc] init];
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [contentArray release];
    [bookSumArray release];
    [myTableView release];
    [searchWord release];
}
#pragma mark - custom
-(UIView*)getViewWithBook:(BookModel*)bookmodel
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 320.0, 72.0f);
    UIView *bgView = [[UIView alloc] initWithFrame:rect];
    
    UIImageView* iconView = [[UIImageView alloc] initWithFrame:CGRectMake(11.0, 6.0, 60.0, 60.0)];
    
    UILabel* priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(257.0, 25.0, 35.0, 21.0)];
    priceLabel.adjustsFontSizeToFitWidth = YES;
    priceLabel.lineBreakMode = UILineBreakModeTailTruncation;
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.font = [UIFont systemFontOfSize:11.0];
    priceLabel.textAlignment = UITextAlignmentRight;
    priceLabel.text = @"Price";
    
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(81.0, 23.0, 168.0, 21.0)];
    nameLabel.lineBreakMode = UILineBreakModeTailTruncation;
    nameLabel.text = @"Application Name";
    nameLabel.font = [UIFont boldSystemFontOfSize:17.0];
    nameLabel.textAlignment = UITextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    
    
    UILabel* publisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(81.0, 8.0, 168.0, 15.0)];
    publisherLabel.lineBreakMode = UILineBreakModeTailTruncation;
    publisherLabel.text = @"Publisher";
    publisherLabel.font = [UIFont systemFontOfSize:11.0];
    publisherLabel.textAlignment = UITextAlignmentLeft;
    publisherLabel.backgroundColor = [UIColor clearColor];
    
    
    UILabel* numRatingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(157.0, 46.0, 92.0, 15.0)];
    numRatingsLabel.lineBreakMode = UILineBreakModeTailTruncation;
    numRatingsLabel.adjustsFontSizeToFitWidth = YES;
    numRatingsLabel.font = [UIFont systemFontOfSize:11.0];
    numRatingsLabel.text = @"0 Ratings";
    numRatingsLabel.backgroundColor = [UIColor clearColor];
    numRatingsLabel.textAlignment = UITextAlignmentLeft;
    
    UIImageView* ratingView = [[UIImageView alloc] init];
    ratingView.frame = CGRectMake(81.0, 46.0, 70.0, 16.0);
    UIImageView* backView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 70.0, 16.0)];
    backView.image = [UIImage imageNamed:@"StartsBackground1.png"];
    backView.contentMode = UIViewContentModeTopLeft;
    UIImageView* foreView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 70.0, 16.0)];
    foreView.image = [UIImage imageNamed:@"StarsForeground1.png"];
    foreView.contentMode = UIViewContentModeTopLeft;
    foreView.clipsToBounds = YES;
    foreView.frame = CGRectMake(0, 0,[bookmodel.avgRating floatValue]/10.0 * 70, 16);
//    NSLog(@"%f",[bookmodel.avgRating floatValue]);
    [ratingView addSubview:backView];
    [ratingView addSubview:foreView];
    [backView release];
    [foreView release];
    
    
    [iconView setImageWithURL:[NSURL URLWithString:bookmodel.linkImage] placeholderImage:[UIImage imageNamed:@"DefaultBook.png"]];
    
    publisherLabel.text = bookmodel.publisher;
    
    nameLabel.text = bookmodel.title;
    numRatingsLabel.text = [NSString stringWithFormat:@"%d Ratings",bookmodel.numRatings];
    
    if(bookmodel.price == nil)
    {
        priceLabel.text = @"暂无";
    }else{
        priceLabel.text = [NSString stringWithFormat:@"%@",bookmodel.price];
    }
    //    [bgView addSubview:priceLabel];
    
    
    [bgView addSubview:ratingView];
    [bgView addSubview:nameLabel];
    [bgView addSubview:publisherLabel];
    [bgView addSubview:iconView];
    
    [ratingView release];
    [nameLabel release];
    [publisherLabel release];
    [iconView release];
    
    return bgView;
    
}
-(void)ceatetableView
{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];
    [self.view addSubview:myTableView];
}
-(void)downloadSummaryWithID:(NSString*)id  
{
    NSString * urlString = [NSString stringWithFormat:@"http://api.douban.com/book/subject/%@?apikey=0e8af6973401e9652ba0e3c59c05bc2f&alt=json",id];
    NSURL* url = [NSURL URLWithString:urlString];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.tag = [id intValue];
    request.delegate = self;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [request startAsynchronous];
}

-(void)jsonValue:(NSDictionary*)arg 
{
    NSDictionary* dict = [arg retain];
    NSArray* entryArray =  [dict objectForKey:@"entry"];
    
    for(int i = 0; i<[entryArray count]; i++)
    {
        BookModel* book = [[BookModel alloc] init];
        
        NSDictionary* subdict = [entryArray objectAtIndex:i];
        
        NSArray* keyArray = [subdict allKeys];
        for(NSString* key in keyArray)
        {
            if([key isEqualToString:@"title"])
            {
                book.title = [[subdict objectForKey:@"title"] objectForKey:@"$t"];  
            }else if([key isEqualToString:@"author"])
            {
                NSArray* nameArray = [subdict objectForKey:@"author"];
                for(NSDictionary* d in nameArray)
                {
                    for(NSString* ss in [d allKeys])
                    {
                        if([ss isEqualToString:@"name"])
                        {
                            book.author = [[d objectForKey:@"name"] objectForKey:@"$t"];
                        }
                    }
                }
            }else if([key isEqualToString:@"link"])
            {
                NSArray* linkArray = [subdict objectForKey:@"link"];
                for(NSDictionary* d in linkArray)
                {
                    for(NSString* ss in [d allKeys])
                    {
                        NSString* name = [d objectForKey:ss];
                        if([name isEqualToString:@"image"])
                        {
                            book.linkImage = [d objectForKey:@"@href"];
//                            NSLog(@"book.linkImage %@",book.linkImage);
                        }
                    }
                }

            }else if([key isEqualToString:@"db:attribute"])
            {
                NSArray* attributeArray = [subdict objectForKey:@"db:attribute"];
                for(NSDictionary* d in attributeArray)
                {
                    NSString* name = [d objectForKey:@"@name"];
                    if([name isEqualToString:@"publisher"])
                    {
                        book.publisher  = [d objectForKey:@"$t"];
                        
                    }else if([name isEqualToString:@"price"])
                    {
                        book.price = [d objectForKey:@"$t"];
                        
                    }else if([name isEqualToString:@"pubdate"])
                    {
                        book.pubdate = [d objectForKey:@"$t"];
                    }
                }

            }else if([key isEqualToString:@"gd:rating"])
            {
                book.avgRating = [[subdict objectForKey:@"gd:rating"] objectForKey:@"@average"];
                
            }else if([key isEqualToString:@"id"])
            {
                NSInteger length = [[[subdict objectForKey:@"id"]objectForKey:@"$t"] length];
                book.bookID =[[[subdict objectForKey:@"id"] objectForKey:@"$t"] substringFromIndex:length - 7];
                //通过ID获取书的简介
                [self downloadSummaryWithID:book.bookID];
            }
        }
        [contentArray addObject:book];
        [book release];
    }
    
    if([contentArray count] > 0)
    {
        if(isArrayCreate == NO)
        { 
            isArrayCreate = YES;
            [self ceatetableView]; 
        }
        [myTableView reloadData];
    }
    isLoading = NO;
   
}
-(void)downloadFromURL
{

    NSString* search = [searchWord urlEncodeString];

    NSString *urlString = [NSString stringWithFormat:@"http://api.douban.com/book/subjects?q=%@&start-index=%d&max-results=%d&apikey=0e8af6973401e9652ba0e3c59c05bc2f&alt=json", search, startIndex, 10];
    
//    NSLog(@"searchWord %@",search);
   //    NSString* stringURL = [NSString stringWithFormat:SOUSHUURL,searchWord];
    NSURL* url = [NSURL URLWithString:urlString];
//    NSLog(@"url %@",url);
   
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   
}
//加载更多
-(void)downloadFromURLs
{
    
    NSString* search = [searchWord urlEncodeString];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.douban.com/book/subjects?q=%@&start-index=%d&max-results=%d&apikey=0e8af6973401e9652ba0e3c59c05bc2f&alt=json", search, startIndex, 10];
    startIndex += 10;
    //    NSLog(@"searchWord %@",search);
    //    NSString* stringURL = [NSString stringWithFormat:SOUSHUURL,searchWord];
    NSURL* url = [NSURL URLWithString:urlString];
    //    NSLog(@"url %@",url);
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"requestFinished");
    if(request.tag > 200)
    {
        NSData* sdata = [request responseData];
        NSDictionary* sdict = [sdata JSONValue];
        NSString* key = [NSString stringWithFormat:@"%d",request.tag];
        bookSum = [[sdict objectForKey:@"summary"] objectForKey:@"$t"];
        NSDictionary* dd = [NSDictionary dictionaryWithObjectsAndKeys:bookSum,key, nil];
//        NSLog(@"bookSum %@",bookSum);
        [bookSumArray addObject:dd];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSData* data = [request responseData];
//        NSLog(@"%@",data);
    NSDictionary* dict = [data JSONValue];
    [self jsonValue:dict];
}

-(void)reloadtableData:(id)sender
{

    [contentArray removeAllObjects];
    [self downloadFromURL];
    [myTableView reloadData];
    
}

#pragma mark - View lifecycle

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadtableData:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    isLoading = NO;
    isArrayCreate = NO;
    startIndex = 1;
    [super viewDidLoad];
    [self downloadFromURL];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contentArray count]+1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < [contentArray count])
    {
        NSString* cellID = @"myCell";
        BookModel* book = [contentArray objectAtIndex:indexPath.row];
        SBookCell* cell = [[SBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID WithBookModel:book];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
        
    }else if(indexPath.row == [contentArray count])
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moreCell"];
            cell.tag = 100;
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            label.text = @"LodingMore...";
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = UITextAlignmentCenter;
            [cell.contentView addSubview:label];
            [label release];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [contentArray count])
    {
        return 44.0f;
    }
    return 72;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //对书的简介赋值
    
    if(indexPath.row == [contentArray count])
    {    
        if(isLoading)
        {
            return;
            
        }else
        {
            isLoading = YES;
            [self downloadFromURLs];
        }
    }
    else if([contentArray count]>0){
        
        for(int i = 0; i<[contentArray count]; i++)
        {
            BookModel* book = [contentArray objectAtIndex:i];
           
            if([bookSumArray count]>0)
            {
                

                for(int j = 0; j<[bookSumArray count]; j++)
                {
                  
                    NSDictionary* dict = [bookSumArray objectAtIndex:j];
                    
                    if ([dict allKeys].count>0) 
                    {
                        if([book.bookID isEqualToString:[[dict allKeys] objectAtIndex:0]])
                        {
                            book.bookSummary = [dict objectForKey:book.bookID];
                         //   NSLog(@"%@",book.bookSummary);
                        }

                    }                
                }
            }
        }
        BookSummaryClass* booksummary = [[BookSummaryClass alloc] initWithBookModel:[contentArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:booksummary animated:YES];

    }
    
       //为什么有它就崩掉？？？？
    //    [booksummary release];
}

@end
