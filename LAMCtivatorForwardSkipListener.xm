#import "LAMCtivatorForwardSkipListener.h"


@implementation LAMCtivatorForwardSkipListener

-(id)init {
    if(self = [super init]) {
        comesFromActivator = NO;
        
        [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"mctivator.request.comes.from.activator.forwardskip"  handler:^NSDictionary *(NSDictionary *message) {
            BOOL comesFromActivatorCopy = comesFromActivator;
            comesFromActivator = NO;
            return @{@"comesFromActivator" : [NSNumber numberWithBool:comesFromActivatorCopy]};
        }];
    }
    
    return self;
}

-(void)activator:(LAActivator*)activator receiveEvent:(LAEvent*)event {
    comesFromActivator = YES;
    MRMediaRemoteSendCommand(kMRNextTrack, 0);
    event.handled = YES;
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
    return @"MCtivator";
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
    return @"Forwardskip";
}

-(NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
    return @"Forwardskip current track";
}

-(NSString*)listenerName {
    return @"de.iakdev.mctivator.activator.forwardskip";
}

@end