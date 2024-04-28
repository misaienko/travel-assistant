//
//  ViewController.m
//  TravelAssistant
//
//  Created by Admin on 25/01/2024.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Create an NSColor with the desired background color (e.g., black)
        NSColor *backgroundColor = [NSColor blackColor];

        // Set the background color of your view
        [self.view setWantsLayer:YES];
        [self.view.layer setBackgroundColor:[backgroundColor CGColor]];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
