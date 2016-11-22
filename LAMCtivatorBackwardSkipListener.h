#import <libactivator/libactivator.h>
#import "MediaRemote.h"
#import <libobjcipc/objcipc.h>

@interface LAMCtivatorBackwardSkipListener : NSObject <LAListener> {
    BOOL comesFromActivator;
}
@end