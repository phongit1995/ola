#import "NativeOlaAppLock.h"
#import <LocalAuthentication/LocalAuthentication.h>

static NSString *OlaAppLockOutcomeForError(NSError *error)
{
  if (error == nil) return @"failed";
  switch (error.code) {
    case LAErrorUserCancel:
    case LAErrorSystemCancel:
    case LAErrorAppCancel:
    case LAErrorUserFallback:
      return @"cancel";
    case LAErrorBiometryLockout:
      return @"lockout";
    case LAErrorBiometryNotAvailable:
    case LAErrorBiometryNotEnrolled:
    case LAErrorPasscodeNotSet:
      return @"unavailable";
    default:
      return @"failed";
  }
}

@implementation NativeOlaAppLock

+ (NSString *)moduleName
{
  return @"OlaAppLock";
}

- (void)biometryType:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject
{
  LAContext *context = [LAContext new];
  NSError *error = nil;
  BOOL available = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                        error:&error];
  if (!available) {
    resolve(@"");
    return;
  }
  switch (context.biometryType) {
    case LABiometryTypeFaceID:
      resolve(@"faceId");
      break;
    case LABiometryTypeTouchID:
      resolve(@"touchId");
      break;
    default:
      resolve(@"biometric");
      break;
  }
}

- (void)authenticate:(NSString *)title
            subtitle:(NSString *)subtitle
         cancelLabel:(NSString *)cancelLabel
             resolve:(RCTPromiseResolveBlock)resolve
              reject:(RCTPromiseRejectBlock)reject
{
  LAContext *context = [LAContext new];
  context.localizedCancelTitle = cancelLabel.length > 0 ? cancelLabel : nil;
  context.localizedFallbackTitle = @"";
  NSError *error = nil;
  if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
    resolve(error != nil && error.code == LAErrorBiometryLockout ? @"lockout" : @"unavailable");
    return;
  }
  NSString *reason = title.length > 0 ? title : @"Ola";
  [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
          localizedReason:reason
                    reply:^(BOOL success, NSError *_Nullable evalError) {
                      resolve(success ? @"success" : OlaAppLockOutcomeForError(evalError));
                    }];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeOlaAppLockSpecJSI>(params);
}

@end
