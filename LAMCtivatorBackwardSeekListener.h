#import <libactivator/libactivator.h>

@interface LAMCtivatorBackwardSeekListener : NSObject <LAListener> {
    double skipTime;
}

-(id)initWithSkipTime:(double)t;
@end