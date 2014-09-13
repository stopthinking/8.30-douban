//
//  BookModel.h
//  DouBan
//
//  Created by feng qian on 12/07/10.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookModel : UITableView
{
    NSString* title;                   //书名
    NSString* author;                   //作者
    NSString* publisher;                //出版社
    NSString* price;                    //价格
    NSString* pubdate;                  //出版时间
    NSString* linkImage;                //封面
    NSString* bookID;                   //书ID
    NSString* bookSummary;              //书简介
    NSString* avgRating;                //平均评分
    float numRatings;
}
@property(nonatomic,retain)NSString* title;
@property(nonatomic,retain)NSString* author;
@property(nonatomic,retain)NSString* publisher;
@property(nonatomic,retain)NSString* price;
@property(nonatomic,retain)NSString* pubdate;
@property(nonatomic,retain)NSString* linkImage;
@property(nonatomic,retain)NSString* bookID;
@property(nonatomic,retain)NSString* bookSummary;
@property(nonatomic,retain)NSString* avgRating;
@property(nonatomic,assign)float numRatings;
@end
