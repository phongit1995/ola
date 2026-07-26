#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <React/RCTBridgeModule.h>

@interface OlaPhotoSaver : NSObject <RCTBridgeModule>
@end

@implementation OlaPhotoSaver

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

RCT_REMAP_METHOD(saveImageAtPath,
                 saveImageAtPath:(NSString *)path
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  NSURL *fileURL = [path hasPrefix:@"file://"]
    ? [NSURL URLWithString:path]
    : [NSURL fileURLWithPath:path];

  BOOL isDirectory = NO;
  if (fileURL == nil ||
      ![[NSFileManager defaultManager] fileExistsAtPath:fileURL.path
                                            isDirectory:&isDirectory] ||
      isDirectory) {
    reject(@"E_IMAGE_FILE_NOT_FOUND", @"The downloaded image file is unavailable.", nil);
    return;
  }

  void (^saveImage)(void) = ^{
    [[PHPhotoLibrary sharedPhotoLibrary]
      performChanges:^{
        PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
        PHAssetResourceCreationOptions *options = [PHAssetResourceCreationOptions new];
        options.shouldMoveFile = NO;
        [request addResourceWithType:PHAssetResourceTypePhoto
                             fileURL:fileURL
                              options:options];
      }
      completionHandler:^(BOOL success, NSError *error) {
        if (success) {
          resolve(@YES);
          return;
        }

        reject(@"E_PHOTO_SAVE_FAILED",
               error.localizedDescription ?: @"Unable to save the image to Photos.",
               error);
      }];
  };

  void (^handleAuthorization)(PHAuthorizationStatus) = ^(PHAuthorizationStatus status) {
    switch (status) {
      case PHAuthorizationStatusAuthorized:
      case PHAuthorizationStatusLimited:
        saveImage();
        break;
      case PHAuthorizationStatusDenied:
      case PHAuthorizationStatusRestricted:
        reject(@"E_PHOTO_PERMISSION_DENIED",
               @"Permission to add images to Photos was denied.",
               nil);
        break;
      case PHAuthorizationStatusNotDetermined:
        reject(@"E_PHOTO_PERMISSION_UNAVAILABLE",
               @"Photo library authorization could not be determined.",
               nil);
        break;
    }
  };

  PHAuthorizationStatus status =
    [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelAddOnly];
  if (status == PHAuthorizationStatusNotDetermined) {
    [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelAddOnly
                                              handler:handleAuthorization];
    return;
  }

  handleAuthorization(status);
}

@end
