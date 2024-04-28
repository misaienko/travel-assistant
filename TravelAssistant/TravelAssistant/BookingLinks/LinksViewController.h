
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinksViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (strong) IBOutlet NSTableView *linksTableView;
@property (nonatomic, strong) NSArray *bookingLinks;

@end

NS_ASSUME_NONNULL_END
