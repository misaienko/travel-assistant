
#import "EmergencyViewController.h"
#import <Cocoa/Cocoa.h>

@interface EmergencyViewController ()

@property (strong, nonatomic) NSArray<NSDictionary *> *filteredDataArray;

@end

@implementation EmergencyViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.wantsLayer = YES;
  self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"EmergencyContacts" ofType:@"plist"];
  NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSArray *dataArray = plistDict[@"EmergencyContacts"];

  if (dataArray) {
    self.dataArray = dataArray;
    self.filteredDataArray = dataArray;
    NSLog(@"Data loaded successfully. Number of items: %lu", (unsigned long)self.dataArray.count);
  } else {
    NSLog(@"Failed to load data from the property list. The 'EmergencyContacts' key was not found.");
  }

  NSTableView *tableView = [self.tableView documentView];

  tableView.dataSource = self;
  tableView.delegate = self;

  self.searchItem.delegate = self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  return self.filteredDataArray.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  NSDictionary *rowData = self.filteredDataArray[row];

  NSString *identifier = tableColumn.identifier;

  NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];

  if ([identifier isEqualToString:@"Country"]) {
    cellView.textField.stringValue = rowData[@"Country"] ?: @"";
  } else if ([identifier isEqualToString:@"Ambulance"]) {
    cellView.textField.stringValue = [NSString stringWithFormat:@"%@", rowData[@"Ambulance"] ?: @""];
  } else if ([identifier isEqualToString:@"Police"]) {
    cellView.textField.stringValue = [NSString stringWithFormat:@"%@", rowData[@"Police"] ?: @""];
  }

  return cellView;
}

- (void)controlTextDidChange:(NSNotification *)obj {
  NSSearchField *searchField = obj.object;
  NSString *searchText = searchField.stringValue;

  if (searchText.length == 0) {
    self.filteredDataArray = self.dataArray;
  } else {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Country CONTAINS[cd] %@", searchText];
    self.filteredDataArray = [self.dataArray filteredArrayUsingPredicate:predicate];
  }

  NSTableView *tableView = [self.tableView documentView];
  [tableView reloadData];
}

@end

