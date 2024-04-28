
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmergencyViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate, NSSearchFieldDelegate>

@property (strong) IBOutlet NSScrollView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *dataArray;
@property (strong) IBOutlet NSSearchField *searchItem;

@end

NS_ASSUME_NONNULL_END
