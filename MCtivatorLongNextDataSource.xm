#import "MCtivatorLongNextDataSource.h"

@implementation MCtivatorLongNextDataSource

static MCtivatorLongNextDataSource *longNextDataSource;

+ (void)load
{
    @autoreleasepool {
        longNextDataSource = [[MCtivatorLongNextDataSource alloc] init];
    }
}

- (id)init {
    if ((self = [super init])) {
        [LASharedActivator registerEventDataSource:self forEventName:@"de.iakdev.mctivator.longnext"];
    }
    return self;
}

- (void)dealloc {
    [LASharedActivator unregisterEventDataSourceWithEventName:@"de.iakdev.mctivator.longnext"];
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
    return @"Next track long press";
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
    return @"MCtivator";
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
    return @"Next track button long pressed";
}

@end