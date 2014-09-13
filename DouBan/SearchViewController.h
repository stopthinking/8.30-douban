
#import <UIKit/UIKit.h>
#import "ShowSearchResultViewController.h"
#import "zbar.h"
#import "ZBarReaderController.h"
@interface SearchViewController : UIViewController
< UITextFieldDelegate, ZBarReaderDelegate>
{
    NSString *searchWord;
}
@end
