//
//  BookCell.m
//  DouBan
//
//  Created by feng qian on 12/07/10.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "SBookCell.h"
#import "UIImageView+WebCache.h"
#import "RootViewController.h"
@implementation SBookCell
@synthesize bookmodel;
-(void)dealloc
{
    
    [bookmodel release];
}

-(void)getCellView
{

    CGRect rect = CGRectMake(0.0f, 0.0f, 320.0, 72.0f);
    UIView *bgView = [[[UIView alloc] initWithFrame:rect] autorelease];
    
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(11.0, 6.0, 60.0, 60.0)];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(257.0, 25.0, 35.0, 21.0)];
    priceLabel.adjustsFontSizeToFitWidth = YES;
    priceLabel.lineBreakMode = UILineBreakModeTailTruncation;
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.font = [UIFont systemFontOfSize:11.0];
    priceLabel.textAlignment = UITextAlignmentRight;
    priceLabel.text = @"Price";
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(81.0, 23.0, 168.0, 21.0)];
    nameLabel.lineBreakMode = UILineBreakModeTailTruncation;
    nameLabel.text = @"Application Name";
    nameLabel.font = [UIFont boldSystemFontOfSize:17.0];
    nameLabel.textAlignment = UITextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    
    
    publisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(81.0, 8.0, 168.0, 15.0)];
    publisherLabel.lineBreakMode = UILineBreakModeTailTruncation;
    publisherLabel.text = @"Publisher";
    publisherLabel.font = [UIFont systemFontOfSize:11.0];
    publisherLabel.textAlignment = UITextAlignmentLeft;
    publisherLabel.backgroundColor = [UIColor clearColor];
    
   
    numRatingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(157.0, 46.0, 92.0, 15.0)];
    numRatingsLabel.lineBreakMode = UILineBreakModeTailTruncation;
    numRatingsLabel.adjustsFontSizeToFitWidth = YES;
    numRatingsLabel.font = [UIFont systemFontOfSize:11.0];
    numRatingsLabel.text = @"0 Ratings";
    numRatingsLabel.backgroundColor = [UIColor clearColor];
    numRatingsLabel.textAlignment = UITextAlignmentLeft;
    
    starView = [[UIImageView alloc] init];
    starView.frame = CGRectMake(81.0, 46.0, 70.0, 16.0);
    UIImageView* backView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 70.0, 16.0)];
    backView.image = [UIImage imageNamed:@"StartsBackground1.png"];
    backView.contentMode = UIViewContentModeTopLeft;
    UIImageView* foreView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 70.0, 16.0)];
    foreView.image = [UIImage imageNamed:@"StarsForeground1.png"];
    foreView.contentMode = UIViewContentModeTopLeft;
    foreView.clipsToBounds = YES;
    foreView.frame = CGRectMake(0, 0,[bookmodel.avgRating floatValue]/10.0 * 70, 16);
//    NSLog(@"%f",[bookmodel.avgRating floatValue]);
    [starView addSubview:backView];
    [starView addSubview:foreView];
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
    [bgView addSubview:priceLabel];
    
    
    [bgView addSubview:starView];
    [bgView addSubview:nameLabel];
    [bgView addSubview:publisherLabel];
    [bgView addSubview:iconView];

    [self.contentView addSubview:bgView];

}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithBookModel:(BookModel*)sbook
{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.bookmodel = sbook;
        [self getCellView];  
    }
    return self;
}

@end
