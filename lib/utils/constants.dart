import 'package:shared_preferences/shared_preferences.dart';
import 'keys.dart';

class Urls {
  static const String kBASEURL = "http://192.168.0.215:5000";

  static const String kVENDORSIGNIN = "$kBASEURL/vm/signin";
  static const String kVENDORSIGNUP = "$kBASEURL/vmSignup";
  static const String kGetAllVenues = "$kBASEURL/vm/turfs";
  static const String kGetAllbooking = "$kBASEURL/vm/bookings";
  static const String kGetAllSports = "$kBASEURL/vm/sports";
  static const String kCreateVenue = "$kBASEURL/vm/turf";
  static const String kUpdateVenue = "$kBASEURL/vm/turf/";
  static const String kBlockVenue = "$kBASEURL/vm/turf/block";
  static const String kQuickBook = "$kBASEURL/vm/offlineBook";
  static const String kGETSLOTAVAILABILITY= "$kBASEURL/bookedSlot";
  static const String kGETSINGLEVENUE= "$kBASEURL/vm/turf/";
}

class AccessToken {
  static Future<String?> getAccessToken() async {
    final sharedpref = await SharedPreferences.getInstance();
    final accessToken = sharedpref.getString(GlobalKeys.accesToken);
    return accessToken;
  }
}

class InvalidRespons {
  static const kVENDORINVALIDRESPONSE = 100;
  static const kNOINTERNET = 404;
  static const kINVALIDFORMAT = 102;
  static const kUNKNOWNERROR = 103;
  static const kTIMEOUT = 104;
}
