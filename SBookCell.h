//
//  BookCell.h
//  DouBan
//
//  Created by feng qian on 12/07/10.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@interface SBookCell : UITableViewCell
{
    UIImageView* iconView;
    UILabel* publisherLabel;
    UILabel* nameLabel;
    
    UIView* starView;
    UILabel* priceLabel;
    UILabel* numRatingsLabel;
    BookModel* bookmodel;//首页
    
}
@property(nonatomic,retain)BookModel* bookmodel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithBookModel:(BookModel*)sbook;
@end
