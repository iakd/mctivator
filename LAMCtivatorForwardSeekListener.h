#import <libactivator/libactivator.h>

@interface LAMCtivatorForwardSeekListener : NSObject <LAListener> {
    double skipTime;
}

-(id)initWithSkipTime:(double)t;
@end