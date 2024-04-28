
#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisplayViewController : NSViewController

@property (strong) IBOutlet WKWebView *webView;
@property (nonatomic, strong) NSURL *urlString;

@end

NS_ASSUME_NONNULL_END













