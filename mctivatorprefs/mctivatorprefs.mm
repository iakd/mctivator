#import <Preferences/Preferences.h>
#include <spawn.h>

#define tweakPreferencePath @"/var/mobile/Library/Preferences/de.iakdev.mctivatorprefs.plist"

@interface mctivatorprefsListController: PSListController {
}
@end

@implementation mctivatorprefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"mctivatorprefs" target:self] retain];
	}
	return _specifiers;
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
    NSDictionary *tweakSettings = [NSDictionary dictionaryWithContentsOfFile:tweakPreferencePath];
    if (!tweakSettings[specifier.properties[@"key"]]) {
        return specifier.properties[@"default"];
    }
    return tweakSettings[specifier.properties[@"key"]];
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:tweakPreferencePath]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    [defaults writeToFile:tweakPreferencePath atomically:YES];
    //NSDictionary *tweakSettings = [NSDictionary dictionaryWithContentsOfFile:tweakPreferencePath];
    CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
    if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}

-(void)respring {
    pid_t pid;
    const char* args[] = {"killall", "-9", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

-(void)composeEmailDev {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:iakdev@gmx.de?subject=MCtivator"]];
}
@end

// vim:ft=objc
