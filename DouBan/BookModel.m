//
//  BookModel.m
//  DouBan
//
//  Created by feng qian on 12/07/10.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel
@synthesize title,author,publisher,price,pubdate,linkImage,bookID,bookSummary,avgRating,numRatings;

-(void)dealloc
{
    [title release];
    [publisher release];
    [linkImage release];
    [price release];
    [author release];
    [pubdate release];
    [bookID release];
    [bookSummary release];
    [avgRating release];
}
@end
