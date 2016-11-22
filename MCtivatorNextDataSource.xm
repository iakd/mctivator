#import "MCtivatorNextDataSource.h"

@implementation MCtivatorNextDataSource

static MCtivatorNextDataSource *nextDataSource;

+ (void)load
{
    @autoreleasepool {
        nextDataSource = [[MCtivatorNextDataSource alloc] init];
    }
}

- (id)init {
    if ((self = [super init])) {
        [LASharedActivator registerEventDataSource:self forEventName:@"de.iakdev.mctivator.next"];
    }
    return self;
}

- (void)dealloc {
    [LASharedActivator unregisterEventDataSourceWithEventName:@"de.iakdev.mctivator.next"];
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
    return @"Next track";
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
    return @"MCtivator";
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
    return @"Next track button pressed";
}

@end