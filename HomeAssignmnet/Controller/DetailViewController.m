//
//  DetailViewController.m
//  HomeAssignmnet
//
//  Created by Navjot Singh  on 05/04/21.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.webView.navigationDelegate = self;
	//	self.webURL = @"http://www.google.com";
	
	NSURL *url = [NSURL URLWithString: self.webURL];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:request];
	[self.activityIndicator startAnimating];
	[self.activityIndicator setHidesWhenStopped:true];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
	[self.activityIndicator stopAnimating];
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
	[self.activityIndicator stopAnimating];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
