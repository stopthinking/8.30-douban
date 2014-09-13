//
//  ShareBookViewController.h
//  DouBan
//
//  Created by xuefeng li on 12-7-12.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthLoginController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface ShareBookViewController : UIViewController
<ASIHTTPRequestDelegate>
{
    NSString *shareText;
    UITextView *myTextView;
}

@property (nonatomic, retain) NSString *shareText;

@end
