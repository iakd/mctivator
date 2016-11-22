#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>
#import "MediaRemote.h"
#import <libobjcipc/objcipc.h>

// Should work for most Music apps
%hook MPRemoteCommandCenter
/*
 1 - Pause
 0 - Play
 4 - Next
 5 - Prev
 
 8 - Fastforward start
 9 - Fastforward stop
 
 10 - Fastbackward start
 11 - Fastbackward stop
 */


- (void)_pushMediaRemoteCommand:(unsigned int)cmd withOptions:(id)arg2 completion:(id)arg3 {
    
    NSString* displayId = [[UIApplication sharedApplication] displayIdentifier];
    
    //exclude Spotify
    if(![displayId isEqualToString:@"com.spotify.client"] && ![displayId isEqualToString:@"com.google.ios.youtube"]) {
    
    // IPC Stuff
    NSDictionary *replyForwardskip = [OBJCIPC sendMessageToSpringBoardWithMessageName:@"mctivator.request.comes.from.activator.forwardskip" dictionary:nil];
    NSDictionary *replyBackwardskip = [OBJCIPC sendMessageToSpringBoardWithMessageName:@"mctivator.request.comes.from.activator.backwardskip" dictionary:nil];
    BOOL active = !([replyForwardskip[@"comesFromActivator"] boolValue] || [replyBackwardskip[@"comesFromActivator"] boolValue]);
        
    if(active) {
        LAEvent *event = nil;
    
        if(cmd == 4) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.next" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 5) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.prev" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 8) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.longnext" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 10) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.longprev" mode:[LASharedActivator currentEventMode]];
        }
    
        if(event) {
            [LASharedActivator sendEventToListener:event];
                                          
            if(event.handled) {
                cmd = -1;
            }
        }
    }
    }
    
    %orig;
}
%end


// Spotify
%hook SPTNowPlayingRemoteControlEventController
/*
 101 - Pause
 100 - Play
 104 - Next
 105 - Prev
 
 108 - Fastforward start
 109 - Fastforward stop
 
 106 - Fastbackward start
 107 - Fastbackward stop
 */

-(bool)handleRemoteEventSubType:(unsigned int)cmd {
    // IPC Stuff
    NSDictionary *replyForwardskip = [OBJCIPC sendMessageToSpringBoardWithMessageName:@"mctivator.request.comes.from.activator.forwardskip" dictionary:nil];
    NSDictionary *replyBackwardskip = [OBJCIPC sendMessageToSpringBoardWithMessageName:@"mctivator.request.comes.from.activator.backwardskip" dictionary:nil];
    BOOL active = !([replyForwardskip[@"comesFromActivator"] boolValue] || [replyBackwardskip[@"comesFromActivator"] boolValue]);
    
    if(active) {
        LAEvent *event = nil;
        
        if(cmd == 104) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.next" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 105) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.prev" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 108) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.longnext" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 106) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.longprev" mode:[LASharedActivator currentEventMode]];
        }
        
        if(event) {
            [LASharedActivator sendEventToListener:event];
            
            if(event.handled) {
                return NO;
            }
        }
    }
    
    return %orig;
}
%end

// Youtube
%hook YTWatchController
/*
 101 - Pause
 100 - Play
 104 - Next
 105 - Prev
 
 108 - Fastforward start
 109 - Fastforward stop
 
 106 - Fastbackward start
 107 - Fastbackward stop
 */

-(void)handleRemoteControlEvent:(unsigned int)cmd {
    // IPC Stuff
    NSDictionary *replyForwardskip = [OBJCIPC sendMessageToSpringBoardWithMessageName:@"mctivator.request.comes.from.activator.forwardskip" dictionary:nil];
    NSDictionary *replyBackwardskip = [OBJCIPC sendMessageToSpringBoardWithMessageName:@"mctivator.request.comes.from.activator.backwardskip" dictionary:nil];
    BOOL active = !([replyForwardskip[@"comesFromActivator"] boolValue] || [replyBackwardskip[@"comesFromActivator"] boolValue]);
    
    if(active) {
        LAEvent *event = nil;
        
        if(cmd == 104) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.next" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 105) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.prev" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 108) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.longnext" mode:[LASharedActivator currentEventMode]];
        } else if(cmd == 106) {
            event = [LAEvent eventWithName:@"de.iakdev.mctivator.longprev" mode:[LASharedActivator currentEventMode]];
        }
        
        if(event) {
            [LASharedActivator sendEventToListener:event];
            
            if(event.handled) {
                cmd = -1;
            }
        }
    }
    %orig;
}
%end
