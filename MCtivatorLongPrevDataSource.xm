#import "MCtivatorLongPrevDataSource.h"

@implementation MCtivatorLongPrevDataSource

static MCtivatorLongPrevDataSource *longPrevDataSource;

+ (void)load
{
    @autoreleasepool {
        longPrevDataSource = [[MCtivatorLongPrevDataSource alloc] init];
    }
}

- (id)init {
    if ((self = [super init])) {
        [LASharedActivator registerEventDataSource:self forEventName:@"de.iakdev.mctivator.longprev"];
    }
    return self;
}

- (void)dealloc {
    [LASharedActivator unregisterEventDataSourceWithEventName:@"de.iakdev.mctivator.longprev"];
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
    return @"Previous track long press";
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
    return @"MCtivator";
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
    return @"Previous track button long pressed";
}

@end