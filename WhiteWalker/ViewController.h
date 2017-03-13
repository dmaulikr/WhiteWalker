//
//  ViewController.h
//  WhiteWalker
//
//  Created by Amon on 2017/3/8.
//  Copyright © 2017年 GodPlace. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (weak) IBOutlet NSComboBox *timeBox;
@property (weak) IBOutlet NSButton *actionButton;

@property (weak) IBOutlet NSButton *stopButton;
@property (weak) IBOutlet NSTextField *timeTextField;
@property (weak) IBOutlet NSTextField *inputLabel;
@property (weak) IBOutlet NSTextField *suffixLabel;

@end

