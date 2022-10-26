#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TikiSdkFlutterPlugin.h"

FOUNDATION_EXPORT double tiki_sdk_flutter_pluginVersionNumber;
FOUNDATION_EXPORT const unsigned char tiki_sdk_flutter_pluginVersionString[];

