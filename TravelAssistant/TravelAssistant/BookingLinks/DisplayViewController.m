
#import "DisplayViewController.h"

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
    if (self.urlString) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.urlString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView loadRequest:request];
        });
    } else {
        NSLog(@"Error: urlString is nil.");
    }
}

@end
