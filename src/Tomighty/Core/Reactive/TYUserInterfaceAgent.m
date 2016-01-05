//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYUserInterfaceAgent.h"
#import "TYTimerContext.h"
#import "TYQuoteUI.h"

@implementation TYUserInterfaceAgent
{
    __strong id <TYAppUI> ui;
    __strong id <TYAppUI> quoteUi;
}

- (id)initWith:(id <TYAppUI>)theAppUI quoteUi:(id<TYAppUI>)theQuoteUI
{
    self = [super init];
    if(self)
    {
        ui = theAppUI;
        quoteUi = theQuoteUI;
    }
    return self;
}

- (void)updateAppUiInResponseToEventsFrom:(id <TYEventBus>)eventBus
{
    [eventBus subscribeTo:POMODORO_START subscriber:^(id eventData) {
        [ui switchToPomodoroState];
    }];
    
    [eventBus subscribeTo:TIMER_STOP subscriber:^(id eventData) {
        [ui switchToIdleState];
    }];
    
    [eventBus subscribeTo:SHORT_BREAK_START subscriber:^(id eventData) {
        [ui switchToShortBreakState];
        [quoteUi switchToShortBreakState];
    }];
    
    [eventBus subscribeTo:LONG_BREAK_START subscriber:^(id eventData) {
        [ui switchToLongBreakState];
        [quoteUi switchToShortBreakState];
    }];
    
    [eventBus subscribeTo:TIMER_TICK subscriber:^(id eventData) {
        id <TYTimerContext> timerContext = eventData;
        [ui updateRemainingTime:[timerContext getRemainingSeconds]];
    }];
    
    [eventBus subscribeTo:POMODORO_COUNT_CHANGE subscriber:^(id eventData) {
        NSNumber *pomodoroCount = eventData;
        [ui updatePomodoroCount:[pomodoroCount intValue]];
    }];
}

@end
