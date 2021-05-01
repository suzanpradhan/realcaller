import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  Future getAllPermissionsRequests() async {
    Map<Permission, PermissionStatus> permissionStatus =
        await [Permission.phone, Permission.contacts].request();
    return permissionStatus;
  }
}
