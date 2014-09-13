//
//  CONST.h
//  ReadBookApp
//
//  Created by feng qian on 12/07/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.


//豆瓣书评
#define SHUPINURL     @"http://api.douban.com/people/61362064/reviews?&apikey=0e8af6973401e9652ba0e3c59c05bc2f&alt=json"
//豆瓣搜书  %@ 代表书名
#define SOUSHUURL     @"http://api.douban.com/book/subjects?q=%@&start-index=1&max-results=20&apikey=0e8af6973401e9652ba0e3c59c05bc2f&alt=json"
//豆瓣推荐你  %@ = bookID
#define TUIJIAN       @"http://api.douban.com/book/subject/%@?apikey=0e8af6973401e9652ba0e3c59c05bc2f&alt=json"
//推荐bookID数组
#define BOOKIDARRAY   [[NSArray alloc] initWithObjects:@"2023013",@"1817628",@"1852108",@"2150985",@"6532566",@"3084682",@"2352593",@"3318054", nil]