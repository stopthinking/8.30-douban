//
//  SearchViewController.m
//  DouBan
//
//  Created by xuefeng li on 12-7-9.
//  Copyright (c) 2012年 nyist. All rights reserved.
//

#import "SearchViewController.h"
#import "zbar.h"
#import "ZBarReaderController.h"
#import "ZBarReaderViewController.h"
@implementation SearchViewController

-(id)init
{
    if(self = [super init])
    {
    
    }
    return self;
}
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"navbar3.png"] forBarMetrics: UIBarMetricsDefault];
        
    } 
    
    self.title = @"豆瓣搜书";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg6.png"]];
    
    UIImageView *imageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"douread.png"]];
    imageView.frame = CGRectMake(100, 50, 100, 26);
    [self.view addSubview:imageView];
    [imageView release];
    
    UITextField *searchText = [[UITextField alloc] initWithFrame:CGRectMake(20, 90, 280, 30)];
    searchText.placeholder = @"书名，作者";
    searchText.borderStyle = UITextBorderStyleLine;
    searchText.tag = 100;
    [self.view addSubview:searchText];
    [searchText release];
    
    UIButton *isbnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //searchBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookseach.png"]];
    [isbnBtn setImage:[UIImage imageNamed:@"scan_isbn2.png"] forState:UIControlStateNormal];
    isbnBtn.frame = CGRectMake(40, 130, 50, 50);
    [isbnBtn addTarget:self action:@selector(isbnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:isbnBtn];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //searchBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookseach.png"]];
    [searchBtn setImage:[UIImage imageNamed:@"search2.png"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(220, 130, 40, 50);
    searchBtn.tag = 101;
    [searchBtn addTarget:self action:@selector(searchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
}

//二维码扫描

- (void)isbnBtnPressed:(id)sender
{
    UITextField *searchText = (UITextField*)[self.view viewWithTag:100];
    searchWord = searchText.text;
    
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentModalViewController: reader
                            animated: YES];
    [reader release];
    
    
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    NSLog(@"called er wei ma scan");
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    //    resultText.text = symbol.data;
    //    
    UITextField *searchText = (UITextField*)[self.view viewWithTag:100];
    searchText.text = symbol.data;
    
    searchText.text = @"9787101003048";
    searchWord = searchText.text;
    
    
    //    // EXAMPLE: do something useful with the barcode image
    //    resultImage.image =
    //    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
}



- (void)searchBtnPressed:(id)sender
{
    UITextField *searchText = (UITextField*)[self.view viewWithTag:100];
    searchWord = searchText.text;
    NSLog(@"%@", searchWord);
    if (searchWord != nil && searchWord != @"" ) {
        ShowSearchResultViewController *ssrvc = [[ShowSearchResultViewController alloc] initWithSearchWord:searchWord];
//        ssrvc.delegate = self;
        [self.navigationController pushViewController:ssrvc animated:YES];
//        [ssrvc release];
    }
}

- (NSString*)getSearchWord
{
    return searchWord;
}

//点击屏幕开始事件，收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextField *searchTextField = (UITextField*)[self.view viewWithTag:100];
    [searchTextField resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];
    
    CGRect rect = self.view.frame;
    if(rect.origin.y != 0){
        self.view.frame = CGRectMake(rect.origin.x, rect.origin.y+90, rect.size.width, rect.size.height); 
    }
    
    [UIView commitAnimations];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
