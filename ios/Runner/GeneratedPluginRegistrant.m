//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <amap_location/AmapLocationPlugin.h>
#import <auto_orientation/AutoOrientationPlugin.h>
#import <camera/CameraPlugin.h>
#import <flutter_barcode_scanner/FlutterBarcodeScannerPlugin.h>
#import <flutter_downloader/FlutterDownloaderPlugin.h>
#import <flutter_sound/FlutterSoundPlugin.h>
#import <fluttertoast/FluttertoastPlugin.h>
#import <image_crop/ImageCropPlugin.h>
#import <image_picker/ImagePickerPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <permission_handler/PermissionHandlerPlugin.h>
#import <screen/ScreenPlugin.h>
#import <share/SharePlugin.h>
#import <video_player/VideoPlayerPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AmapLocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"AmapLocationPlugin"]];
  [AutoOrientationPlugin registerWithRegistrar:[registry registrarForPlugin:@"AutoOrientationPlugin"]];
  [CameraPlugin registerWithRegistrar:[registry registrarForPlugin:@"CameraPlugin"]];
  [FlutterBarcodeScannerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBarcodeScannerPlugin"]];
  [FlutterDownloaderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterDownloaderPlugin"]];
  [FlutterSoundPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterSoundPlugin"]];
  [FluttertoastPlugin registerWithRegistrar:[registry registrarForPlugin:@"FluttertoastPlugin"]];
  [ImageCropPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImageCropPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [ScreenPlugin registerWithRegistrar:[registry registrarForPlugin:@"ScreenPlugin"]];
  [FLTSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharePlugin"]];
  [FLTVideoPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTVideoPlayerPlugin"]];
}

@end
