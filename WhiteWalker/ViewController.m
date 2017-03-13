//
//  ViewController.m
//  WhiteWalker
//
//  Created by Amon on 2017/3/8.
//  Copyright © 2017年 GodPlace. All rights reserved.
//

#import "ViewController.h"
#import "ToolsUtil.h"

@interface ViewController () <NSUserNotificationCenterDelegate, NSComboBoxDelegate, NSTextFieldDelegate>

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
 
    _timeBox.delegate = self;
    _timeTextField.delegate = self;
    
    NSInteger selectIndex = 0;
    NSDictionary *appConfigDict = [ToolsUtil getAppConfig];
    if (appConfigDict && appConfigDict[@"timeIndex"]) {
        selectIndex = [appConfigDict[@"timeIndex"] integerValue];
        _timeTextField.integerValue = [appConfigDict[@"timeInterval"] integerValue];
    }
    [_timeBox selectItemAtIndex:selectIndex];
    
    if (selectIndex == _dataArr.count - 1) {
        _inputLabel.hidden = NO;
        _timeTextField.hidden = NO;
        _suffixLabel.hidden = NO;
    } else {
        _inputLabel.hidden = YES;
        _timeTextField.hidden = YES;
        _suffixLabel.hidden = YES;
    }
}



- (IBAction)tapButton:(id)sender {
    NSInteger interval = [_dataArr[_timeBox.indexOfSelectedItem] integerValue];
    NSLog(@">>>>>>>>%li  %li", _timeBox.indexOfSelectedItem, interval);
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                              target:self
                                            selector:@selector(remind)
                                            userInfo:nil
                                             repeats:NO];
    
    NSDictionary *appDict = [ToolsUtil getAppConfig];
    [appDict setValue:[NSNumber numberWithInteger:_timeBox.indexOfSelectedItem] forKey:@"timeIndex"];
    if (_timeBox.indexOfSelectedItem == _dataArr.count - 1) {
        [appDict setValue:[NSNumber numberWithInteger:_timeTextField.integerValue] forKey:@"timeInterval"];
    } else {
        [appDict setValue:_dataArr[_timeBox.indexOfSelectedItem] forKey:@"timeInterval"];
    }
    
    [ToolsUtil saveAppConfigToNSUserDefaults:appDict];
}
- (IBAction)tapStopButton:(id)sender {
    [_timer invalidate];
}

- (void)remind
{
    NSInteger interval = [_dataArr[_timeBox.indexOfSelectedItem] integerValue];
    NSLog(@">>>>>>>>%li  %li", _timeBox.indexOfSelectedItem, interval);
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:self.userNtf];
}

#pragma mark - delegate
- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    NSLog(@">>>>>>>>>");
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    [center removeDeliveredNotification:notification];
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    // 自定义时间
    if (_timeBox.indexOfSelectedItem == _dataArr.count - 1) {
        _timeTextField.hidden = NO;
        _inputLabel.hidden = NO;
        _suffixLabel.hidden = NO;
    } else {
        _timeTextField.hidden = YES;
        _inputLabel.hidden = YES;
        _suffixLabel.hidden = YES;
    }
}

//- (BOOL)textShouldBeginEditing:(NSText *)textObject
//{
//    return YES;
//}

- (void)controlTextDidChange:(NSNotification *)obj
{
    if ([obj object] == _timeTextField) {
        BOOL isNumber = [self checkIsNumber:_timeTextField.stringValue];
        if (!isNumber) {
            NSBeep();
        }
    }
}

- (BOOL)checkIsNumber:(NSString *)textString
{
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}


#pragma mark - getter/setter

- (NSUserNotification *)userNtf
{
    if (!_userNtf) {
        _userNtf = [[NSUserNotification alloc] init];
        _userNtf.title = NSLocalizedString(@"alert_title", nil);
        _userNtf.subtitle = @"";
        _userNtf.deliveryDate = [NSDate dateWithTimeIntervalSinceNow:0];
        _userNtf.soundName = NSUserNotificationDefaultSoundName;
//        _userNtf.actionButtonTitle = @"知道了";
//        _userNtf.hasActionButton = YES;
        [_userNtf setValue:@YES forKey:@"_showsButtons"];
    }
    return _userNtf;
}


@end
