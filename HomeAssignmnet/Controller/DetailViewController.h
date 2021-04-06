//
//  DetailViewController.h
//  HomeAssignmnet
//
//  Created by Navjot Singh  on 05/04/21.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSString *webURL;


@end

NS_ASSUME_NONNULL_END
