import 'package:get_it/get_it.dart';
import 'package:pon/core/viewmodels/main/enquire_view_model.dart';
import 'package:pon/core/viewmodels/splash_view_model.dart';
import 'package:pon/screens/pdf_creation/PaymentReportView.dart';
import 'package:pon/screens/pdf_creation/enquirydisplayview.dart';
import 'package:pon/services/api.dart';

import 'package:pon/services/dialog_service.dart';
import 'package:pon/services/navigation_service.dart';
import 'package:pon/services/secure_storage.dart';
import 'package:pon/services/vehicle_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => API());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SecureStorage());

  // Repository Services

  // MAIN
  //
  locator.registerFactory(() => SplashViewModel());
  locator.registerFactory(() => EnquireViewModel());
  locator.registerFactory(() => EnquiryDisplayView());

  // CART
  //

  locator.registerFactory(() => PaymentReportView());

  // SHARED
  //
 
  locator.registerLazySingleton(() => VehicleService());
}
