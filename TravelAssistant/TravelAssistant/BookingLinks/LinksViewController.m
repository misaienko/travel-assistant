
#import "LinksViewController.h"
#import "DisplayViewController.h"

@implementation LinksViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.wantsLayer = YES;
  self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BookingLinks" ofType:@"plist"];
  [self loadBookingLinksFromPlist:plistPath];

  self.linksTableView.delegate = self;
  self.linksTableView.dataSource = self;

  self.linksTableView.rowHeight = 40.0;
  self.linksTableView.intercellSpacing = NSMakeSize(6.0, 6.0);
}

- (void)loadBookingLinksFromPlist:(NSString *)plistPath {
  if (!plistPath) {
    NSLog(@"Error: Unable to find plist file.");
    return;
  }

  NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSArray *bookingLinksData = plistDict[@"BookingsLinks"];
  if (!bookingLinksData) {
    NSLog(@"Error: Unable to load bookings links data.");
    return;
  }

  NSMutableArray *bookingLinksArray = [NSMutableArray array];
  for (NSDictionary *linkData in bookingLinksData) {
    NSString *title = linkData[@"Title"];
    NSString *image = linkData[@"Image"];
    NSString *urlString = linkData[@"URL"];

    NSDictionary *bookingLink = @{@"Title": title, @"Image": image, @"URL": urlString};
    [bookingLinksArray addObject:bookingLink];
  }

  self.bookingLinks = [bookingLinksArray copy];
  NSLog(@"Data loaded successfully. Number of items: %lu", (unsigned long)self.bookingLinks.count);
  [self.linksTableView reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.bookingLinks.count;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"LinkCell" owner:self];
    
    NSDictionary *rowData = self.bookingLinks[row];
    
    NSTextField *titleTextField = [cellView viewWithTag:1];
    NSImageView *imageView = [cellView viewWithTag:2];
    
    if (titleTextField && imageView) {
        titleTextField.stringValue = rowData[@"Title"];
        
        NSString *imageName = rowData[@"Image"];
        NSImage *image = [NSImage imageNamed:imageName];
        if (image) {
            imageView.image = image;
        } else {
        }
    }
    
    return cellView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tableView = notification.object;
    NSInteger selectedRow = tableView.selectedRow;
    
    if (selectedRow != -1) {
        NSDictionary *selectedLink = self.bookingLinks[selectedRow];
        
        [self performSegueWithIdentifier:@"showDisplayViewSegue" sender:selectedLink];
    }
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDisplayViewSegue"]) {
        DisplayViewController *displayVC = segue.destinationController;
        
        if ([sender isKindOfClass:[NSDictionary class]]) {
            NSDictionary *selectedLink = (NSDictionary *)sender;
            NSString *linkURLString = selectedLink[@"URL"];
            displayVC.urlString = [NSURL URLWithString:linkURLString];
        }
    }
}

@end












