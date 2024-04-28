//
//  BookingsViewController.m
//  TravelAssistant
//
//  Created by Admin on 24/03/2024.
//

#import "BookingsViewController.h"
#import <Cocoa/Cocoa.h>

@interface BookingsViewController ()

@end

@implementation BookingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
    self.uploadFile.wantsLayer = YES;
    self.uploadFile.layer.cornerRadius = 50.0;
}

- (IBAction)uploadFilePressed:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.allowedFileTypes = @[(NSString *)kUTTypePDF];
    
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
//            NSURL *selectedFileURL = panel.URL;
        }
    }];
}


@end


