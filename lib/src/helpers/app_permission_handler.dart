import 'package:permission_handler/permission_handler.dart';

class AppPermissionHandler {
  static Future<bool> checkAndRequestPermission(Permission permission) async {
    if (!(await permission.isGranted)) {
      PermissionStatus permissionStatus = await permission.status;
      switch (permissionStatus) {
        case PermissionStatus.denied:
          PermissionStatus status = await permission.request();
          return status.isGranted;
          break;
        case PermissionStatus.granted:
          return true;
          break;
        case PermissionStatus.restricted:
          PermissionStatus status = await permission.request();
          return status.isGranted;
          break;
        case PermissionStatus.limited:
          PermissionStatus status = await permission.request();
          return status.isGranted;
          break;
        case PermissionStatus.permanentlyDenied:
          await openAppSettings();
          PermissionStatus status = await permission.request();
          return status.isGranted;
          break;
        default:
          return false;
          break;
      }
    } else {
      return true;
    }
  }
}
