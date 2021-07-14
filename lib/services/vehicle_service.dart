import 'package:pon/core/models/vehicle.dart';
import 'package:pon/locator.dart';
import 'package:pon/services/api.dart';

class VehicleService {
  List<Vehicle> _vehicle;

  Future<List<Vehicle>> getVehicles() async {
    if (_vehicle == null) {
      // _vehicle = await locator<API>().fetchVehicle();
    }

    return _vehicle;
  }

  Future<List<Vehicle>> get refresh async {
    //_vehicle = await locator<API>().fetchVehicle();
    return _vehicle;
  }
}

class DriverService {
  List<DriverEntry> _driverId;

  Future<List<DriverEntry>> getId() async {
    if (_driverId == null) {
      // _driverId = await locator<API>().fetchDriverId();
    }

    return _driverId;
  }

  Future<List<DriverEntry>> get refresh async {
    // _driverId = await locator<API>().fetchDriverId();
    return _driverId;
  }
}
