//
//  HomeViewController.m
//  TravelAssistant
//
//  Created by Admin on 24/03/2024.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.wantsLayer = YES;
        self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
    // Set round corners for the button
        self.inspirationButton.wantsLayer = YES;
        self.inspirationButton.layer.cornerRadius = 50.0; // Adjust the value as needed for desired roundness
}

@end
