
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface HomeViewController : UIViewController
<ASIHTTPRequestDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView* scrollView;
    UITableView* tableviwe;
    UILabel* label;
    NSTimer* timer;
    NSMutableArray* contentArray;
}
@end
