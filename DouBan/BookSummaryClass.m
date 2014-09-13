//
//  BookSummaryClass.m
//  DouBan
//
//  Created by feng qian on 12/07/11.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "BookSummaryClass.h"

#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "ShareBookViewController.h"
@implementation BookSummaryClass

-(id)initWithBookModel:(BookModel*)book
{
    if(self = [super init])
    {
        bookmodel = [book retain];
        self.title = bookmodel.title;
        bookTitle = bookmodel.title;
    }
    return self;
}
-(void)dealloc
{
    [bookTitle release];
    [scrollView release];
    [sheet release];
    [bookmodel release];
    [super dealloc];
}
#pragma mark - coustom
-(void)getViewWithBook
{
    UIView * bookInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    
    //封面
    UIImageView * bookImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 120, 160)];
    NSURL * imgurl = [NSURL URLWithString:bookmodel.linkImage];
    //    NSData * imgData = [[NSData alloc] initWithContentsOfURL:imgurl];
    [bookImgView setImageWithURL:imgurl];
    [bookInfoView addSubview:bookImgView];
    [bookImgView release];
    //书名
    UILabel * bookTittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 150, 20)];
    bookTittleLabel.backgroundColor = [UIColor clearColor];
    bookTittleLabel.text = bookmodel.title;
    [bookInfoView addSubview:bookTittleLabel];
    [bookTittleLabel release];
    //作者
    UILabel * bookAuthorLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 35, 150, 20)];
    bookAuthorLabel.backgroundColor = [UIColor clearColor];
    bookAuthorLabel.font = [UIFont systemFontOfSize:12];
    bookAuthorLabel.text = [NSString stringWithFormat:@"作者: %@",bookmodel.author];
    [bookInfoView addSubview:bookAuthorLabel];
    [bookAuthorLabel release];
    //出版商
    UILabel * bookPublisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 55, 150, 20)];
    bookPublisherLabel.backgroundColor = [UIColor clearColor];
    bookPublisherLabel.font = [UIFont systemFontOfSize:12];
    bookPublisherLabel.text = [NSString stringWithFormat:@"出版商: %@",bookmodel.publisher];
    [bookInfoView addSubview:bookPublisherLabel];
    [bookPublisherLabel release];
    //出版时间
    UILabel * bookUpdataLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 75, 150, 20)];
    bookUpdataLabel.backgroundColor = [UIColor clearColor];
    bookUpdataLabel.font = [UIFont systemFontOfSize:12];
    bookUpdataLabel.text = [NSString stringWithFormat:@"出版时间: %@",bookmodel.pubdate]; 
    [bookInfoView addSubview:bookUpdataLabel];
    [bookUpdataLabel release];
    //价格
    UILabel * bookPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 95, 150, 20)];
    bookPriceLabel.backgroundColor = [UIColor clearColor];
    bookPriceLabel.font = [UIFont systemFontOfSize:12];
    bookPriceLabel.text = [NSString stringWithFormat:@"价格: %@",bookmodel.price];
    [bookInfoView addSubview:bookPriceLabel];
    [bookPriceLabel release];
    //评分
    UILabel * bookRatingLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 115, 150, 20)];
    bookRatingLabel.backgroundColor = [UIColor clearColor];
    bookRatingLabel.font = [UIFont systemFontOfSize:12];
    bookRatingLabel.text = @"评分:";
    [bookInfoView addSubview:bookRatingLabel];
    [bookRatingLabel release];
    
    //评分星标显示
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(150.0, 140.0, 160.0, 30.0)];
        
    UIImageView* foreView = [[UIImageView alloc] init];
    foreView.image = [UIImage imageNamed:@"StarsForeground.png"];
    foreView.contentMode = UIViewContentModeTopLeft;
    foreView.clipsToBounds = YES;
    foreView.frame = CGRectMake(0, 0,[bookmodel.avgRating floatValue]/10.0 * 160, 30);
    NSLog(@"%f",[bookmodel.avgRating floatValue]);
    [view addSubview:foreView];
    [foreView release];
    [bookInfoView addSubview:view];
    [view release];
    //简介内容
    UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 280, 30)];
    textLabel.font = [UIFont boldSystemFontOfSize:17];
    textLabel.text = @"内容简介";
    textLabel.backgroundColor = [UIColor clearColor];
    
    //显示简介内容
    if(!bookmodel.bookSummary)   
    {
        bookmodel.bookSummary = @" 暂无简介\n   ";
    }
    NSLog(@"%@",bookmodel.bookSummary);
    CGSize size = [bookmodel.bookSummary sizeWithFont:[UIFont fontWithName:@"Arial" size:15] constrainedToSize:CGSizeMake(318, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    UILabel* summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 195, size.width, size.height)];
    summaryLabel.numberOfLines = 0;
    summaryLabel.backgroundColor = [UIColor clearColor];
    summaryLabel.text = bookmodel.bookSummary;
    
    scrollView.contentSize =CGSizeMake(320, 195+size.height+100);
    [scrollView addSubview:summaryLabel];
    [scrollView addSubview:bookInfoView];
    [scrollView addSubview:textLabel];
    
}


-(void)collectBook
{
    if(![SHAREDAPP.collectArray containsObject:bookmodel])
    {
        [SHAREDAPP.collectArray addObject:bookmodel];
        NSLog(@"收藏 %@",SHAREDAPP.collectArray);
    }
   
}
#pragma mark - View lifecycle
-(void)moreSelect
{
    [sheet showFromTabBar:self.tabBarController.tabBar];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self collectBook];
        
    }else if(buttonIndex == 1)
    {
        ShareBookViewController *shareBook = [[ShareBookViewController alloc] init];
        shareBook.shareText = bookTitle;
        if (![OAuthLoginController getCurrentAccount]){
            [OAuthLoginController launchLoginUI];
            [self.navigationController pushViewController:shareBook animated:YES];
            [shareBook release];
            
        }else{
            [self.navigationController pushViewController:shareBook animated:YES];
            [shareBook release];
        }

    }
}

- (void)loadView
{
    [super loadView];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStyleDone target:self action:@selector(moreSelect)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"" destructiveButtonTitle:nil otherButtonTitles:@"收藏本书",@"分享到微博",@"查看书评",@"取消", nil];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    [self.view addSubview:scrollView];
    [self getViewWithBook];
}

@end
