
#import "ViewController.h"
#import "HomeViewController.h"
#import "BookViewController.h"
#import "SearchViewController.h"
#import "RankViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self CreatTableBarController];
}

-(void)CreatTableBarController{
    HomeViewController* home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    UIImage* HomeImage = [UIImage imageNamed:@"home.png"];
    UITabBarItem* item1= [[UITabBarItem alloc] initWithTitle:@"主页" image:HomeImage tag:1];
    UINavigationController* homeNav= [[UINavigationController alloc] initWithRootViewController:home];
    homeNav.tabBarItem=item1;
    [home release];
    [item1 release];
    
    
    SearchViewController* search = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    UIImage* searchImage = [UIImage imageNamed:@"search.png"];
    UINavigationController* searchNav = [[UINavigationController alloc] initWithRootViewController:search];
    UITabBarItem* item2= [[UITabBarItem alloc] initWithTitle:@"查找" image:searchImage tag:2];
    searchNav.tabBarItem=item2;
    [search release];
    [item2 release];
    
    
    BookViewController* book= [[BookViewController alloc] initWithNibName:@"BookViewController" bundle:nil];
    UIImage* bookImage = [UIImage imageNamed:@"shoucang.png"];
    UINavigationController* bookNav = [[UINavigationController alloc]initWithRootViewController:book];
    UITabBarItem* item3= [[UITabBarItem alloc] initWithTitle:@"书架" image:bookImage tag:3];
    bookNav.tabBarItem=item3;
    [book release];
    [item3 release];
    
    RankViewController* rank= [[RankViewController alloc] initWithNibName:@"RankViewController" bundle:nil];
    UIImage* rankImage = [UIImage imageNamed:@"scan.png"];
    UINavigationController* rankNav = [[UINavigationController alloc]initWithRootViewController:rank];
    UITabBarItem* item4= [[UITabBarItem alloc] initWithTitle:@"排行" image:rankImage tag:4];
    rankNav.tabBarItem=item4;
    [rank release];
    [item4 release];
    
    UITabBarController* tabBar= [[UITabBarController alloc] init];
    tabBar.viewControllers= [NSArray arrayWithObjects:homeNav,searchNav,bookNav,rankNav,nil];
    [self presentModalViewController:tabBar animated:YES];
    [homeNav release];
    [searchNav release];
    [bookNav release];
    [rankNav release];
    
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
