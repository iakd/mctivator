#import "LAMCtivatorForwardSeekListener.h"
#import "LAMCtivatorBackwardSeekListener.h"
#import "LAMCtivatorForwardSkipListener.h"
#import "LAMCtivatorBackwardSkipListener.h"

#define tweakPreferencePath @"/var/mobile/Library/Preferences/de.iakdev.mctivatorprefs.plist"

static CGFloat skipTime = 10;


static void loadPrefs() {
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:tweakPreferencePath];
    skipTime = [settings objectForKey:@"time"] ? [[settings objectForKey:@"time"] doubleValue] : 10;
}


%ctor {
    // Prefs
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("de.iakdev.mctivator/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
    
    // Activator
    [[LAActivator sharedInstance] registerListener:[[LAMCtivatorForwardSeekListener alloc] initWithSkipTime:(double)skipTime] forName:@"de.iakdev.mctivator.activator.forwardseek"];
    [[LAActivator sharedInstance] registerListener:[[LAMCtivatorBackwardSeekListener alloc] initWithSkipTime:(double)skipTime] forName:@"de.iakdev.mctivator.activator.backwardseek"];
    [[LAActivator sharedInstance] registerListener:[[LAMCtivatorForwardSkipListener alloc] init] forName:@"de.iakdev.mctivator.activator.forwardskip"];
    [[LAActivator sharedInstance] registerListener:[[LAMCtivatorBackwardSkipListener alloc] init] forName:@"de.iakdev.mctivator.activator.backwardskip"];
}


/*
%hook MPUTransportControlMediaRemoteController


1 - Pause
0 - Play
4 - Next
5 - Prev

8 - Fastforward start
9 - Fastforward stop

10 - Fastbackward start
11 - Fastbackward stop

-(void)handlePushingMediaRemoteCommand:(unsigned int)cmd {
    NSLog(@"DBG -- handlePushingMediaRemoteCommand %i", cmd);
    
    LAEvent *event = nil;
    
    if(cmd == 4) {
        event = [LAEvent eventWithName:@"de.iakdev.mctivator.next" mode:[LASharedActivator currentEventMode]];
        [LASharedActivator sendEventToListener:event];
    } else if(cmd == 5) {
        event = [LAEvent eventWithName:@"de.iakdev.mctivator.prev" mode:[LASharedActivator currentEventMode]];
        [LASharedActivator sendEventToListener:event];
    } else if(cmd == 8) {
        event = [LAEvent eventWithName:@"de.iakdev.mctivator.longnext" mode:[LASharedActivator currentEventMode]];
        [LASharedActivator sendEventToListener:event];
    } else if(cmd == 10) {
        event = [LAEvent eventWithName:@"de.iakdev.mctivator.longprev" mode:[LASharedActivator currentEventMode]];
        [LASharedActivator sendEventToListener:event];
    }
    
    if(!event || !event.handled)
        %orig;
}

%end
 */


%hook MPUSystemMediaControlsViewController

static id sharedController = nil;
static double elapsedTime = 0;

%new
+(id)customSharedController {
    return sharedController;
}

-(id)init {
    if(!sharedController) {
        sharedController = %orig;
        return sharedController;
    }
    
    return %orig;
}

-(id)initWithNibName:(id)arg1 bundle:(id)arg2 {
    if(!sharedController) {
        sharedController = %orig;
        return sharedController;
    }
    
    return %orig;
}

-(id)initWithStyle:(int)arg1 {
    if(!sharedController) {
        sharedController = %orig;
        return sharedController;
    }
    
    return %orig;
}

-(void)nowPlayingController:(id)arg1 elapsedTimeDidChange:(double)arg2 {
    if(arg1) {
        %orig;
        elapsedTime = arg2;
        return;
    }

    elapsedTime += arg2;

    %orig(arg1, elapsedTime);
    [self _commitCurrentScrubberValue];
}

%end