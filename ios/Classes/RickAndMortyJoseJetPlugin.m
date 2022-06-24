#import "RickAndMortyJoseJetPlugin.h"
#if __has_include(<rick_and_morty_jose_jet/rick_and_morty_jose_jet-Swift.h>)
#import <rick_and_morty_jose_jet/rick_and_morty_jose_jet-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rick_and_morty_jose_jet-Swift.h"
#endif

@implementation RickAndMortyJoseJetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRickAndMortyJoseJetPlugin registerWithRegistrar:registrar];
}
@end
