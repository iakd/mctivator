#import <libactivator/libactivator.h>
#import "MediaRemote.h"
#import <libobjcipc/objcipc.h>

@interface LAMCtivatorForwardSkipListener : NSObject <LAListener> {
    BOOL comesFromActivator;
}
@end