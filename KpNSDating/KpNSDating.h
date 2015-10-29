//
//  KpNSDating.h
//  KpNSDating
//
//  Created by MacMan on 9/4/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KpNSDating : UIViewController
// The repeating timer is a weak property.
@property (weak) NSTimer *repeatingTimer;
@property (strong) NSTimer *unregisteredTimer;
@property NSUInteger timerCount;

@property (strong,nonatomic) NSString *dateFormatString;
@property (strong,nonatomic) NSDateFormatter *dateformatter;
@property (strong,nonatomic) NSString *timeString;
@property (strong,nonatomic) NSDate *startDate;



- (void)targetMethod:(NSTimer *) theTimer;
- (void)invocationMethod:(NSDate *) date;
- (void)countedTimerFireMethod:(NSTimer*) theTimer;

- (NSString *)methodToFormatDate: (NSDate *) dateToFormat;


@property(strong,nonatomic)NSString *startOneOffTimerString;
@property (strong, nonatomic) IBOutlet UILabel *startOneOffTimerLabel;
- (IBAction)startOneOffTimer:sender;


@property(strong,nonatomic)NSString *startRepeatingTimerString;
@property (strong, nonatomic) IBOutlet UILabel *startRepeatingTimerLabel;
- (IBAction)startRepeatingTimer:sender;


@property(strong,nonatomic)NSString *stopRepeatingTimerString;
@property (strong, nonatomic) IBOutlet UILabel *stopRepeatingTimerLabel;
- (IBAction)stopRepeatingTimer:sender;

@property(strong,nonatomic)NSString *createUnregisteredTimerString;
@property (strong, nonatomic) IBOutlet UILabel *createUnregisteredTimerLabel;
- (IBAction)createUnregisteredTimer:sender;


@property(strong,nonatomic)NSString *startUnregisteredTimerString;
@property (strong, nonatomic) IBOutlet UILabel *startUnregisteredTimerLabel;
- (IBAction)startUnregisteredTimer:sender;


@property(strong,nonatomic)NSString *stopUnregisteredTimerString;
@property (strong, nonatomic) IBOutlet UILabel *stopUnregisteredTimerLabel;
- (IBAction)stopUnregisteredTimer:sender;

@property(strong,nonatomic)NSString *startFireDateTimerString;
@property (strong, nonatomic) IBOutlet UILabel *startFireDateTimerLabel;
- (IBAction)startFireDateTimer:sender;


@property(weak,nonatomic)NSString *timerStartedOnString;
@property (weak, nonatomic) IBOutlet UILabel *timerStartedOnLabel;
- (IBAction)timerStartedButtonAction:(id)sender;




@property(weak,nonatomic)NSString *invocationMethodString;
@property (weak, nonatomic) IBOutlet UILabel *invocationMethodLabel;
- (IBAction)invocationMethodButtonAction:(id)sender;



- (NSDictionary *)userInfo;

@property (strong,atomic)NSString *keys;


@end
