#import "HomeViewController.h"
#import "ASIHTTPRequest.h"
#import "BookModel.h"
#import "CONST.h"
#import "SBJson.h"
#import "SBookCell.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

-(UIView*)getViewwithBook:(BookModel*)bookmodel{

    CGRect rect = CGRectMake(0, 0, 320, 72);
    UIView* bgView = [[[UIView alloc] initWithFrame:rect] autorelease];
    UIImageView* iconView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 6, 60, 60)];
    
    UILabel* priceLabel= [[UILabel alloc] initWithFrame:CGRectMake(257, 25, 35, 21)];
    priceLabel.adjustsFontSizeToFitWidth=YES;
    priceLabel.lineBreakMode=UILineBreakModeHeadTruncation;
    priceLabel.backgroundColor=[UIColor clearColor];
    priceLabel.font=[UIFont systemFontOfSize:11.0];
    priceLabel.textAlignment=UITextAlignmentRight;
    priceLabel.text=@"Price";

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

-(void)creatScrollView{

    scrollView.contentSize=CGSizeMake(320*[contentArray count],72);
    for (int i=0 ; i<[contentArray count]; i++) {
        BookModel* book = [contentArray objectAtIndex:i];
        UIView* view = [self getViewwithBook:book];    
        view.frame=CGRectMake(i*320,0,320,72);
        [scrollView addSubview:view];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(ScrollStrat:) userInfo:nil repeats:YES];
    //提高定时期优先级
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

-(void)ScrollStrat:(NSTimer*)timer{
    if (scrollView.contentOffset.x<320*([contentArray count]-1)) {
        CGPoint point = CGPointMake(scrollView.contentOffset.x+2, 0);
        scrollView.contentOffset=point;
    }else {
        CGPoint point=CGPointMake(0, 0);
        scrollView.contentOffset=point;
    }

}

-(void)CreatTableView{
    tableviwe = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 460-44-49-100) style:UITableViewStylePlain];

    tableviwe.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    tableviwe.delegate=self;
    tableviwe.dataSource=self;
    tableviwe.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];
    [self.view addSubview:tableviwe];
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

#pragma mark JosnParser

-(void)JosnParser:(NSDictionary*)arg withRequestTag:(NSInteger)tag{
    NSDictionary* dict =[arg retain];   
    
    NSString* bookTitle = [[dict objectForKey:@"title"] objectForKey:@"$t"];
    NSString* bookAtuthor=[[dict objectForKey:@"author"] objectForKey:@"$t"];
    NSString* bookSummary = [[dict objectForKey:@"summary"] objectForKey:@"$t"];
    NSArray* bookImageArray=[dict objectForKey:@"link"];   
    NSString* bookImage=nil;
    
    NSArray* bookinfo = [dict objectForKey:@"db:attribute"];
    NSString* bookPrice = nil;
    NSString* bookPublisher = nil;
    NSString* bookPubdate = nil;
    for (NSDictionary* Bookname in bookinfo) {
        if ([[Bookname objectForKey:@"@name"]isEqualToString:@"price"]) {
            bookPrice=[Bookname objectForKey:@"$t"];
        }else if ([[Bookname objectForKey:@"@name"]isEqualToString:@"publisher"]) {
            bookPublisher=[Bookname objectForKey:@"$t"];
        }else if ([[Bookname objectForKey:@"@name"]isEqualToString:@"pubdate"]) {
            bookPubdate=[Bookname objectForKey:@"$t"];
        }
    }
    
    for (NSDictionary* rel in bookImageArray) {
        if ([[rel objectForKey:@"@rel"]isEqualToString:@"image"]) {
            bookImage=[rel objectForKey:@"@href"];
        }
    }
    
    NSString* bookId=[[dict objectForKey:@"id"] objectForKey:@"$t"];
    
    NSString * bookRating = [[dict objectForKey:@"gd:rating"] objectForKey:@"@average"];
    
    
    BookModel* model= [[BookModel alloc] init];
    model.title=bookTitle;
    model.author=bookAtuthor;
    model.bookSummary = bookSummary;
    model.price = bookPrice;
    model.publisher = bookPublisher;
    model.pubdate = bookPubdate;
    model.bookID = bookId;
    model.avgRating = bookRating;
    model.linkImage = bookImage;
    [contentArray addObject:model];
    
    if ([contentArray count]==8) {
        [self CreatTableView];
        [self creatScrollView];
        label.hidden=NO;
    }
    [model release];
}


-(void)downloadFromBokkId{
    NSArray* array = [[NSArray alloc] initWithObjects:@"2023013",@"1817628",@"1852108",@"2150985",@"6532566",@"3084682",@"2352593",@"3318054",nil];
    
    for (int i =0; i<[array count]; i++) {
        NSString* strUrl =[NSString stringWithFormat:TUIJIAN, [array objectAtIndex:i]];
        NSURL* url = [NSURL URLWithString:strUrl];
        ASIHTTPRequest* request=[ASIHTTPRequest requestWithURL:url];
        request.delegate=self;
        request.tag=i;
        [request startAsynchronous];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    }
  
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    NSData* data = [request responseData];
    NSDictionary* dict = [data JSONValue];
    [self jsonValue:dict  withRequestTag:request.tag];
}


#pragma mark ReloadtableView
-(void)loadView{
    [super loadView];
    self.title=@"豆瓣推荐";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadtableData:)];
    self.navigationItem.rightBarButtonItem=item;
    [item release];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
    scrollView.pagingEnabled=YES;
    
    [self.view addSubview:scrollView];
    [self createLabel];
    [self downloadFromBokkId];
}

-(void)reloadtableData:(id)sender{
    for (id view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [timer invalidate];
    [contentArray removeAllObjects];
    [self downloadFromBokkId];
    [tableviwe reloadData];
}

#pragma mark TableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [contentArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellID = @"myCell";
    BookModel* book = [contentArray objectAtIndex:indexPath.row];
    SBookCell* cell = [[SBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID WithBookModel:book];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 72;
}

@end
