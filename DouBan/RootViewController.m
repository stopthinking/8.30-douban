

#import "RootViewController.h"
#import "ASIHTTPRequest.h"
#import "SBookCell.h"
#import "BookModel.h"
#import "CONST.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BookSummaryClass.h"
@implementation RootViewController
@synthesize contentArray;
-(id)init
{
    NSLog(@"init");
    if(self = [super init])
    {
        contentArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [contentArray release];
    [myScrollView release];
    [myTableView release];
}
#pragma mark - coustom
-(UIView*)getViewWithBook:(BookModel*)bookmodel
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 320.0, 72.0f);
    UIView *bgView = [[[UIView alloc] initWithFrame:rect] autorelease];
    
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
    NSLog(@"%f",[bookmodel.avgRating floatValue]);
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

-(void)createScrollView
{
    myScrollView.contentSize = CGSizeMake(320*[contentArray count], 72);
    for(int i = 0; i<[contentArray count]; i++)
    {
        BookModel* book = [contentArray objectAtIndex:i];
        UIView* view = [self getViewWithBook:book];
        view.frame = CGRectMake(i*320, 0, 320, 72);
        [myScrollView addSubview:view];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(ScrollStartScroll:) userInfo:nil repeats:YES];
    
    
    
    //提高定时器的优先级
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

-(void)ScrollStartScroll:(NSTimer*)timer
{
    if(myScrollView.contentOffset.x < 320*([contentArray count]-1))
    {
        CGPoint point = CGPointMake(myScrollView.contentOffset.x+2, 0);
        myScrollView.contentOffset = point;
    }else
    {
        CGPoint point = CGPointMake(0, 0);
        myScrollView.contentOffset = point;
    }
}
-(void)ceatetableView
{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 460-44-49-100) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];
    [self.view addSubview:myTableView];
}
-(void)createLabel
{
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 72, 320, 30)];
    label.text = @"热门推荐";
    label.hidden = YES;
    label.font = [UIFont boldSystemFontOfSize:17];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}
-(void)jsonValue:(NSDictionary*)arg withRequestTag:(NSInteger)tag
{
    NSDictionary* dict = [arg retain];
   
    
    //书名
    NSString* bookTitle = [[dict objectForKey:@"title"] objectForKey:@"$t"];
    //作者
    NSString* bookAuthor = [[[[dict objectForKey:@"author"] objectAtIndex:0] objectForKey:@"name"] objectForKey:@"$t"];
    //概述
    NSString* bookSummary = [[dict objectForKey:@"summary"] objectForKey:@"$t"];
    //封面
    NSArray* bookImageArray = [dict objectForKey:@"link"];
    NSString* bookImage = nil;
    for(NSDictionary* rel in bookImageArray)
    {
        if([[rel objectForKey:@"@rel"] isEqualToString:@"image"])
        {
            bookImage = [rel objectForKey:@"@href"];
        }
    }
    //书的价格，出版社，更新日期
    NSArray* bookInfo = [dict objectForKey:@"db:attribute"];
    NSString* bookPrice = nil;
    NSString* bookPublisher = nil;
    NSString* bookPubdate = nil;
    for(NSDictionary* name in bookInfo)
    {
        if([[name objectForKey:@"@name"] isEqualToString:@"price"])
        {
            bookPrice = [name objectForKey:@"$t"];
        }else if([[name objectForKey:@"@name"] isEqualToString:@"publisher"])
        {
            bookPublisher = [name objectForKey:@"$t"];
        }else if([[name objectForKey:@"@name"] isEqualToString:@"pubdate"])
        {
            bookPubdate = [name objectForKey:@"$t"];
        }
    }
    //书ID
    NSString* bookID = [[dict objectForKey:@"id"] objectForKey:@"$t"];
    //书评分
    NSString* bookRating = [[dict objectForKey:@"gd:rating"] objectForKey:@"@average"];
    
    BookModel* book = [[BookModel alloc] init];
    book.title = bookTitle;
    book.author = bookAuthor;
    book.bookSummary = bookSummary;
    book.price = bookPrice;
    book.publisher = bookPublisher;
    book.pubdate = bookPubdate;
    book.bookID = bookID;
    book.avgRating = bookRating;
    book.linkImage = bookImage;
    [contentArray addObject:book];
    
    if([contentArray count] == 8)
    {
        [self ceatetableView]; 
        [self createScrollView];
        label.hidden = NO;
    }
    
    [book release];
}

//下载
-(void)downloadFromBookID
{
    NSLog(@"downloadFromBookID");
    NSArray* array = [[NSArray alloc] initWithObjects:@"2023013",@"1817628",@"1852108",@"2150985",@"6532566",@"3084682",@"2352593",@"3318054", nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString* stringURL = [NSString stringWithFormat:TUIJIAN,[array objectAtIndex:i]];
        NSURL* url = [NSURL URLWithString:stringURL];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        request.delegate = self;
        request.tag = 100+i;
        
        [request startAsynchronous];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSData* data = [request responseData];
//    NSLog(@"%@",data);
    NSDictionary* dict = [data JSONValue];
    [self jsonValue:dict  withRequestTag:request.tag];
}

#pragma mark - View lifecycle
-(void)loadView
{
    [super loadView];
    self.title = @"豆瓣推荐";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];

    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadtableData:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
}
-(void)reloadtableData:(id)sender
{

    for(id view in myScrollView.subviews)
    {
        [view removeFromSuperview];
    }
    [timer invalidate];
    [contentArray removeAllObjects];
    [self downloadFromBookID];
    [myTableView reloadData];
        
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
  
    myScrollView.pagingEnabled = YES;
    
    [self.view addSubview:myScrollView];
    
    [self createLabel];
    [self downloadFromBookID];
    
    
}
#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contentArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"myCell";
    BookModel* book = [contentArray objectAtIndex:indexPath.row];
    SBookCell* cell = [[SBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID WithBookModel:book];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BookSummaryClass* booksummary = [[BookSummaryClass alloc] initWithBookModel:[contentArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:booksummary animated:YES];
//为什么有它就崩掉？？？？
//    [booksummary release];
}
@end
