//
//  PCSMainTabBarController.m
//  PCSNetDisk
//
//  Created by wangzz on 13-3-7.
//  Copyright (c) 2013年 hisunsray. All rights reserved.
//

#import "PCSMainTabBarController.h"
#import "PCSNetDiskViewController.h"
#import "PCSOfflineViewController.h"
#import "PCSUploadViewController.h"
#import "PCSMoreViewController.h"
#import "PCSFileInfoItem.h"

@interface PCSMainTabBarController ()

@end

@implementation PCSMainTabBarController
@synthesize netDiskNavController;
@synthesize uploadNavController;
@synthesize offlineNavController;
@synthesize moreNavController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    PCS_FUNC_SAFELY_RELEASE(netDiskNavController);
    PCS_FUNC_SAFELY_RELEASE(uploadNavController);
    PCS_FUNC_SAFELY_RELEASE(offlineNavController);
    PCS_FUNC_SAFELY_RELEASE(moreNavController);
    //
	// 腾讯MobWIN提示：开发者必须调用
	//
	[adBanner stopRequest];
	[adBanner removeFromSuperview];

    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self createTabBarControllers];
    [self addADBanner];
}

- (void)addADBanner
{
    adBanner = [[MobWinBannerView alloc] initMobWinBannerSizeIdentifier:MobWINBannerSizeIdentifier320x25];
	adBanner.rootViewController = self;
    adBanner.frame = CGRectMake(0, 406+(iPhone5?88:0), 320, 10);
	[adBanner setAdUnitID:PCS_STRING_MOBWIN_UNIT_ID];
	[self.view addSubview:adBanner];
    
    //
	// 腾讯MobWIN提示：开发者可选调用
	// 获取MobWinBannerViewDelegate回调消息
	//
    adBanner.delegate = self;
    //
	// 腾讯MobWIN提示：开发者可选调用
	//
	adBanner.adGpsMode = NO;
	// adBanner.adTextColor = [UIColor whiteColor];
	// adBanner.adSubtextColor = [UIColor colorWithRed:255.0/255.0 green:162.0/255.0 blue:0.0/255.0 alpha:1];
	// adBanner.adBackgroundColor = [UIColor colorWithRed:2.0/255.0 green:12.0/255.0 blue:15.0/255.0 alpha:1];
	//
	
	//
	// 腾讯MobWIN提示：开发者必须调用
	//
	// 发起广告请求方法
	//
	[adBanner startRequest];
	[adBanner release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTabBarControllers
{
    PCSNetDiskViewController *netDiskViewController = [[PCSNetDiskViewController alloc] init];
    netDiskViewController.path = PCS_STRING_DEFAULT_PATH;
    netDiskNavController = [[UINavigationController alloc]initWithRootViewController:netDiskViewController];
    netDiskNavController.tabBarItem.title = @"";
    PCS_FUNC_SAFELY_RELEASE(netDiskViewController);
    
    UIViewController *uploadViewController = [[PCSUploadViewController alloc] init];
    uploadNavController = [[UINavigationController alloc] initWithRootViewController:uploadViewController];
    uploadNavController.tabBarItem.title = @"";
    PCS_FUNC_SAFELY_RELEASE(uploadViewController);
    
    UIViewController *offlineViewController = [[PCSOfflineViewController alloc] init] ;
    offlineNavController = [[UINavigationController alloc] initWithRootViewController:offlineViewController];
    offlineNavController.tabBarItem.title = @"";
    PCS_FUNC_SAFELY_RELEASE(offlineViewController);
    
    UIViewController *moreViewController = [[PCSMoreViewController alloc] init];
    moreNavController = [[UINavigationController alloc] initWithRootViewController:moreViewController];
    moreNavController.tabBarItem.title = @"";
    PCS_FUNC_SAFELY_RELEASE(moreViewController);
    
    if ([self.tabBarItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)])
    {
        self.tabBar.backgroundImage = [[UIImage imageNamed:@"tab_background"] stretchableImageWithLeftCapWidth:6 topCapHeight:24];
        UIEdgeInsets imgSet =  UIEdgeInsetsMake(5, 0, -9, 0);
        [netDiskNavController.tabBarItem setImageInsets:imgSet];
        [netDiskNavController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_netdisked"]
                             withFinishedUnselectedImage:[UIImage imageNamed:@"tab_netdisk"]];
        
        [uploadNavController.tabBarItem setImageInsets:imgSet];
        [uploadNavController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_uploaded"]
                          withFinishedUnselectedImage:[UIImage imageNamed:@"tab_upload"]];
        
        [offlineNavController.tabBarItem setImageInsets:imgSet];
        [offlineNavController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_offlined"]
                           withFinishedUnselectedImage:[UIImage imageNamed:@"tab_offline"]];
        
        [moreNavController.tabBarItem setImageInsets:imgSet];
        [moreNavController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_mored"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tab_more"]];
    } else {
        netDiskViewController.tabBarItem.image = [UIImage imageNamed:@"tab_netdisk"];
        uploadNavController.tabBarItem.image = [UIImage imageNamed:@"tab_upload"];
        offlineNavController.tabBarItem.image = [UIImage imageNamed:@"tab_offline"];
        moreNavController.tabBarItem.image = [UIImage imageNamed:@"tab_more"];
    }

    NSArray   *controllers = [NSArray arrayWithObjects:
                              netDiskNavController,uploadNavController,offlineNavController,moreNavController, nil];
    
    self.viewControllers = controllers;
}

#pragma mark - MobBanner View Delegate
- (void)bannerViewDidReceived {
    PCSLog(@"MobWIN %s", __FUNCTION__);
}

- (void)bannerViewFailToReceived {
    PCSLog(@"MobWIN %s", __FUNCTION__);
}

- (void)bannerViewDidPresentScreen {
    PCSLog(@"MobWIN %s", __FUNCTION__);
}

- (void)bannerViewDidDismissScreen {
    PCSLog(@"MobWIN %s", __FUNCTION__);
}

- (void)bannerViewWillLeaveApplication {
    PCSLog(@"MobWIN %s", __FUNCTION__);
}


@end
