#import "MCtivatorPrevDataSource.h"

@implementation MCtivatorPrevDataSource

static MCtivatorPrevDataSource *prevDataSource;

+ (void)load
{
    @autoreleasepool {
        prevDataSource = [[MCtivatorPrevDataSource alloc] init];
    }
}

- (id)init {
    if ((self = [super init])) {
        [LASharedActivator registerEventDataSource:self forEventName:@"de.iakdev.mctivator.prev"];
    }
    return self;
}

- (void)dealloc {
    [LASharedActivator unregisterEventDataSourceWithEventName:@"de.iakdev.mctivator.prev"];
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
    return @"Previous track";
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
    return @"MCtivator";
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
    return @"Previous track button pressed";
}

@end