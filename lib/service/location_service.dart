import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as Location;
import 'package:geolocator/geolocator.dart';

class LocationService {
  late bool _locationEnabled;
  late LocationPermission _locationPermission;
  Location.Location location = new Location.Location();
  Future<bool> isLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.checkPermission();
    if (_locationPermission == LocationPermission.denied ||
        _locationPermission == LocationPermission.deniedForever) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> requestLocationPermission() async {
    await Geolocator.requestPermission();
  }

  Future<bool> isLocationEnabled() async {
    _locationEnabled = await Geolocator.isLocationServiceEnabled();
    return _locationEnabled;
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<void> openLocationPermissionSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<void> openLocationStatusSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<Placemark> getLocationNameFromPosition(
      {required String latitude, required String longitude}) async {
    // final _coordinates = Coordinates(double.parse(latitude.replaceAll(" ", "")),
    //     double.parse(longitude.replaceAll(" ", "")));
    // List<Address> _addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(_coordinates);
    List<Placemark> _placemarks = await placemarkFromCoordinates(
        double.parse(latitude.replaceAll(" ", "")),
        double.parse(longitude.replaceAll(" ", "")));
    Placemark _firstLocation = _placemarks.first;
    return _firstLocation;
  }

  Future<Placemark> getMyLocationAddressDirect() async {
    // Position position = await Geolocator.getCurrentPosition();
    Location.LocationData _locatioData = await location.getLocation();

    List<Placemark> _placemarks = await placemarkFromCoordinates(
        _locatioData.latitude!, _locatioData.longitude!);

    Placemark _firstLocation = _placemarks.first;

    return _firstLocation;
  }
}
