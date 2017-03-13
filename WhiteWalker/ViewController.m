//
//  ViewController.m
//  WhiteWalker
//
//  Created by Amon on 2017/3/8.
//  Copyright © 2017年 GodPlace. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSUserNotificationCenterDelegate>

@property NSArray *dataArr;

@property NSTimer *timer;

@property (nonatomic, strong) NSUserNotification *userNtf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [self configureData];
    [self initUI];
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)configureData
{
    _dataArr = @[ @5, @10, @45, @60, @75, @90, @0 ];
}

- (void)initUI
{
    self.title = @"WhiteWalker";
}



- (IBAction)tapButton:(id)sender {
    NSInteger interval = [_dataArr[_timeBox.indexOfSelectedItem] integerValue];
    NSLog(@">>>>>>>>%li  %li", _timeBox.indexOfSelectedItem, interval);
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                              target:self
                                            selector:@selector(remind)
                                            userInfo:nil
                                             repeats:NO];
}
- (IBAction)tapStopButton:(id)sender {
    [_timer invalidate];
}

- (void)remind
{
    NSInteger interval = [_dataArr[_timeBox.indexOfSelectedItem] integerValue];
    NSLog(@">>>>>>>>%li  %li", _timeBox.indexOfSelectedItem, interval);
    
    NSLog(@"###############该醒醒了");
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:self.userNtf];
}

#pragma mark - delegate
- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    NSLog(@">>>>>>>>>");
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    NSLog(@"#####");
    [center removeDeliveredNotification:notification];
}

- (NSUserNotification *)userNtf
{
    if (!_userNtf) {
        _userNtf = [[NSUserNotification alloc] init];
        _userNtf.title = @"该起来活动活动了";
        _userNtf.subtitle = @"";
        _userNtf.deliveryDate = [NSDate dateWithTimeIntervalSinceNow:0];
        _userNtf.soundName = NSUserNotificationDefaultSoundName;
        _userNtf.actionButtonTitle = @"知道了";
        _userNtf.hasActionButton = YES;
        [_userNtf setValue:@YES forKey:@"_showsButtons"];
    }
    return _userNtf;
}


@end
