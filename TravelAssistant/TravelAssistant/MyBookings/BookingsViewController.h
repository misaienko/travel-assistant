//
//  BookingsViewController.h
//  TravelAssistant
//
//  Created by Admin on 24/03/2024.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookingsViewController : NSViewController

@property (weak) IBOutlet NSButton *uploadFile;

- (IBAction)uploadFilePressed:(id)sender;


@end

NS_ASSUME_NONNULL_END
