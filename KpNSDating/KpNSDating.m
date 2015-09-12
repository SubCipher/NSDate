//
//  KpNSDating.m
//  KpNSDating
//
//  Created by MacMan on 9/4/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "KpNSDating.h"

@interface KpNSDating ()

@end

@implementation KpNSDating


- (void)updateTimer
{
    NSDate *startDate = [NSDate date];

    
    //set date format: see:http://unicode.org/reports/tr35/tr35-dates.html#Date_Format_Patterns
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT: +4.0]];
    
    //convert date format into NSString object and read it into NSString var
     //_invocationMethodString = [dateFormatter stringFromDate:date];
    _startOneOffTimerString =[dateFormatter stringFromDate:startDate];
    _timerStartedOnString = [dateFormatter stringFromDate:startDate];
    
    
      //_startRepeatingTimerString = [dateFormatter stringFromDate:_repeatingTimer];
    
}

- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };

}

-(IBAction)timerStartedButtonAction:(id)sender{
    [self updateTimer];
    _timerStartedOnLabel.text = _timerStartedOnString;
}

- (void)targetMethod:(NSTimer*)theTimer {
    [self updateTimer];
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@", startDate);
    
    }

-(IBAction)invocationMethodButtonAction:(id)sende{

    _invocationMethodLabel.text = _invocationMethodString;
    
}


- (IBAction)startOneOffTimer:sender {
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:[self userInfo]
                                    repeats:NO];
    [self updateTimer];
    _startOneOffTimerLabel.text = _startOneOffTimerString ;
}


- (void)invocationMethod:(NSDate *)date {
    [self updateTimer];
   
    NSLog(@"Invocation for timer started on %@", date);
}





- (IBAction)startRepeatingTimer:sender {
    
    // Cancel a preexisting timer.
    [self.repeatingTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self selector:@selector(targetMethod:)
                                                    userInfo:[self userInfo] repeats:YES];
    
    
    self.repeatingTimer = timer;
   [self updateTimer];
    _startRepeatingTimerLabel.text = _startRepeatingTimerString;
}







- (IBAction)createUnregisteredTimer:sender {
    
    NSMethodSignature *methodSignature = [self methodSignatureForSelector:@selector(invocationMethod:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(invocationMethod:)];
    NSDate *startDate = [NSDate date];
    [invocation setArgument:&startDate atIndex:2];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 invocation:invocation repeats:YES];
    self.unregisteredTimer = timer;
    
    _createUnregisteredTimerLabel.text = _createUnregisteredTimerString;
    
}

- (IBAction)startUnregisteredTimer:sender {
    
    if (self.unregisteredTimer != nil) {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.unregisteredTimer forMode:NSDefaultRunLoopMode];
        
        //_startUnregisteredTimerLabel.text = _startUnregisteredTimerString;
    }
}


- (IBAction)startFireDateTimer:sender {
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireDate
                                              interval:0.5
                                                target:self
                                              selector:@selector(countedTimerFireMethod:)
                                              userInfo:[self userInfo]
                                               repeats:YES];
    
    self.timerCount = 1;
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
    //_startFireDateTimerLabel = _startFireDateTimerString;
    
}


- (IBAction)stopRepeatingTimer:sender {
    [self.repeatingTimer invalidate];
    self.repeatingTimer = nil;
}

- (IBAction)stopUnregisteredTimer:sender {
    [self.unregisteredTimer invalidate];
    self.unregisteredTimer = nil;
}

- (void)countedTimerFireMethod:(NSTimer*)theTimer {
    
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@; fire count %lu", startDate, self.timerCount);
    
    self.timerCount++;
    if (self.timerCount > 3) {
        [theTimer invalidate];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
