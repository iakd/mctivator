#import "LAMCtivatorBackwardSeekListener.h"

@implementation LAMCtivatorBackwardSeekListener

-(id)initWithSkipTime:(double)t {
    if(self = [super init]) {
        skipTime = t;
    }
    
    return self;
}

-(void)activator:(LAActivator*)activator receiveEvent:(LAEvent*)event {
    id mcViewController = [%c(MPUSystemMediaControlsViewController) customSharedController];
    
    if(mcViewController) {
        [mcViewController nowPlayingController:nil elapsedTimeDidChange:-skipTime];
    } else {
        NSLog(@"MCtivator: Could not find MediaControls");
    }
    
    event.handled = YES;
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
    return @"MCtivator";
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
    return @"Backwardseek";
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
    return @"Backwardseek in current track if supported";
}

-(NSString*)listenerName {
    return @"de.iakdev.mctivator.activator.backwardseek";
}

@end