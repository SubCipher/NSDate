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


- (NSString *)methodToFormatDate: (NSDate *)dateToFormat
{
    
    //set date format: see:http://unicode.org/reports/tr35/tr35-dates.html#Date_Format_Patterns
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT: +4.0]];
    
    //convert date format into NSString object and read it into NSString var
     _dateFormatString = [dateFormatter stringFromDate:dateToFormat];
    return _dateFormatString;
    
}

- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };

}

- (void)targetMethod:(NSTimer*)theTimer {
    
    _startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@", _startDate);
    
    }

-(IBAction)timerStartedButtonAction:(id)sender{
    
    [self methodToFormatDate:_startDate];
    NSLog(@"%@",_dateFormatString);
    _timerStartedOnLabel.text = _dateFormatString;
}

- (IBAction)startOneOffTimer:sender {
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:[self userInfo]
                                    repeats:NO];

}

- (void)invocationMethod:(NSDate *)date {
    //[self updateTimer];
   
    NSLog(@"Invocation for timer started on %@", date);
}


-(IBAction)invocationMethodButtonAction:(id)sende{
    [self methodToFormatDate:[NSDate date]];
    _invocationMethodLabel.text = _dateFormatString;
    
}


- (IBAction)startRepeatingTimer:sender {
    
    // Cancel a preexisting timer.
    [self.repeatingTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self selector:@selector(targetMethod:)
                                                    userInfo:[self userInfo] repeats:YES];
    
    self.repeatingTimer = timer;

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
    
}

- (IBAction)startUnregisteredTimer:sender {
    
    if (self.unregisteredTimer != nil) {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.unregisteredTimer forMode:NSDefaultRunLoopMode];
        
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
