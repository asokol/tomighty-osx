//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYQuoteUI.h"
#include <stdlib.h>

@implementation TYQuoteUI 
{
    int currentQuoteIndex;
}


- (void)switchToIdleState
{

}

- (void)switchToPomodoroState
{

}


- (NSString*) randomQuote
{
    NSArray *quotes;
    quotes = [NSArray arrayWithObjects:
              @"Done is better than perfect",
              @"Is the outcome worth the investment?",
              @"Are you stuck? Have a walk.",
              @"Accept that everything is a draft. It helps to get it done.",
              @"Make things as simple as possible, but not simpler.",
              @"Better to do something imperfectly than to do nothing flawlessly.",
              @"A person who never made a mistake, never tried anything new",
              @"Perfection may be spelled Paralysis",
              nil];
    int index = rand() % [quotes count];
    while (index == currentQuoteIndex) {
        index = rand() % [quotes count];
    }
    currentQuoteIndex = index;
    return quotes[currentQuoteIndex];
}

- (void)switchToShortBreakState
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:[self randomQuote]];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert setInformativeText:@"Take a break"];
    [alert runModal];
}

- (void)switchToLongBreakState
{

}

- (void)updateRemainingTime:(int)remainingSeconds
{

}

- (void)updatePomodoroCount:(int)count
{

}

@end
