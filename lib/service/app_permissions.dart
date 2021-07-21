// import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realcallerapp/blocs/authbloc/auth_bloc.dart';
import 'package:realcallerapp/blocs/permissionbloc/permissonbloc_bloc.dart';

class AppPermission {
  Future getAllPermissionsRequests({required AuthBloc authBloc}) async {
    var contactPermissionStatus = await Permission.contacts.status;
    var phonePermissionStatus = await Permission.phone.status;
    if (contactPermissionStatus.isDenied) {
      Permission.contacts.request();
    } else if (phonePermissionStatus.isDenied &&
        await Permission.contacts.request().isGranted) {
      Permission.phone.request();
    } else if (await Permission.contacts.request().isGranted &&
        await Permission.phone.request().isGranted) {
      // if (!await MobileNumber.hasPhonePermission) {
      //   await MobileNumber.requestPhonePermission;
      //   getAllPermissionsRequests(authBloc: authBloc);
      // } else {
      authBloc.add(AllPermissionGranted());
      // }
    } else {
      getAllPermissionsRequests(authBloc: authBloc);
    }

    // Map<Permission, PermissionStatus> permissionStatus =
    //     await [Permission.phone, Permission.contacts].request();
    // return permissionStatus;
  }

  Future<bool> isAllPermissionGranted() async {
    Map<Permission, PermissionStatus> permissionStatus =
        await [Permission.phone, Permission.contacts].request();
    if (await Permission.contacts.request().isGranted &&
        await Permission.phone.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
