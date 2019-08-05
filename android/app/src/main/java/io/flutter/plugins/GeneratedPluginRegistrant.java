package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.jzoom.amaplocation.AmapLocationPlugin;
import de.bytepark.autoorientation.AutoOrientationPlugin;
import io.flutter.plugins.camera.CameraPlugin;
import com.amolg.flutterbarcodescanner.FlutterBarcodeScannerPlugin;
import vn.hunghd.flutterdownloader.FlutterDownloaderPlugin;
import com.dooboolab.fluttersound.FlutterSoundPlugin;
import io.github.ponnamkarthik.toast.fluttertoast.FluttertoastPlugin;
import com.lykhonis.imagecrop.ImageCropPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import com.baseflow.permissionhandler.PermissionHandlerPlugin;
import flutter.plugins.screen.screen.ScreenPlugin;
import io.flutter.plugins.share.SharePlugin;
import io.flutter.plugins.videoplayer.VideoPlayerPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    AmapLocationPlugin.registerWith(registry.registrarFor("com.jzoom.amaplocation.AmapLocationPlugin"));
    AutoOrientationPlugin.registerWith(registry.registrarFor("de.bytepark.autoorientation.AutoOrientationPlugin"));
    CameraPlugin.registerWith(registry.registrarFor("io.flutter.plugins.camera.CameraPlugin"));
    FlutterBarcodeScannerPlugin.registerWith(registry.registrarFor("com.amolg.flutterbarcodescanner.FlutterBarcodeScannerPlugin"));
    FlutterDownloaderPlugin.registerWith(registry.registrarFor("vn.hunghd.flutterdownloader.FlutterDownloaderPlugin"));
    FlutterSoundPlugin.registerWith(registry.registrarFor("com.dooboolab.fluttersound.FlutterSoundPlugin"));
    FluttertoastPlugin.registerWith(registry.registrarFor("io.github.ponnamkarthik.toast.fluttertoast.FluttertoastPlugin"));
    ImageCropPlugin.registerWith(registry.registrarFor("com.lykhonis.imagecrop.ImageCropPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    PermissionHandlerPlugin.registerWith(registry.registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));
    ScreenPlugin.registerWith(registry.registrarFor("flutter.plugins.screen.screen.ScreenPlugin"));
    SharePlugin.registerWith(registry.registrarFor("io.flutter.plugins.share.SharePlugin"));
    VideoPlayerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.videoplayer.VideoPlayerPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
