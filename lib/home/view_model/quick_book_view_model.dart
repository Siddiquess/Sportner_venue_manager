import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/venue_details_view_model.dart';
import '../../repo/api_services.dart';
import '../../repo/api_status.dart';
import '../../utils/constants.dart';
import '../model/quick_book_model.dart';
import '../model/slot_availibility_model.dart';
import '../model/venue_details_model.dart';

class QuickBookViewModel with ChangeNotifier {
  QuickBookViewModel() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 5; i++) {
      _dates.add(now.add(Duration(days: i)));
    }
    _selectedDate = now;
  }
  bool _isLoading = false;
  List<SlotAvailabilityModel> _slotAvailability = [];
  int _selectedSport = -1;
  String _selectedSportName = "";
  DateTime? _selectedDate = DateTime.now();
  final List<DateTime> _dates = [];
  String _selectedRadioButton = "";
  String _facility = "";
  String _selectedTime = "HH:MM";
  List<Slot> venueDataSlot = [];
  int fromTimeSlotIndex = -1;
  String timeSlotText = "";

  List<SlotAvailabilityModel> get slotAvailability => _slotAvailability;
  int get selectedSport => _selectedSport;
  String get selectedSportName => _selectedSportName;
  DateTime? get selectedDate => _selectedDate;
  List<DateTime> get dates => _dates;
  String get selectedRadioButton => _selectedRadioButton;
  String get facility => _facility;
  String get selectedTime => _selectedTime;
  bool get isLoading => _isLoading;

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  getQuickBooking(String venueId) async {
    setLoading(true);
    final accessToken = await AccessToken.getAccessToken();
    log(quickBookingBody(venueId).toString());
    final response = await ApiServices.dioPostMethod(
      url: Urls.kQuickBook,
      body: quickBookingBody(venueId),
      headers: accessToken,
    );

    if (response is Success) {
      setLoading(false);
      log(response.response.toString());
      log("success");
    }

    if (response is Failure) {
      log("failed");
      setLoading(false);
    }
  }

  Map<String, dynamic> quickBookingBody(String venueId) {
    final slotData = DateFormat('d,MMM,y').format(
      DateTime.parse('$_selectedDate'),
    );
    final quickBookBody = QuickBookModel(
      turfId: venueId,
      sport: _selectedSportName,
      facliity: _selectedRadioButton,
      slotDate: slotData,
      slotTime: _selectedTime,
    );

    return quickBookBody.toJson();
  }

  // GET THE SLOTS AVAILABILITY

  getSlotAvailability({
    required String venueId,
  }) async {
    final date = DateFormat('d,MMM,y').format(
      DateTime.parse('$_selectedDate'),
    );
    log(date);
    final response = await ApiServices.dioPostMethod(
      url: Urls.kGETSLOTAVAILABILITY,
      body: {
        "turfId": venueId,
        "slotDate": date,
      },
      jsonEncode: slotAvailabilityModelFromJson,
    );
    if (response is Success) {
      if (response.response != null) {
        await setSlotAvailability(
            response.response as List<SlotAvailabilityModel>);
      }
      log("Success");
      log("-----------------------${response.response}");
    }
    if (response is Failure) {
      log("Error");
    }
  }

  setSlotAvailability(List<SlotAvailabilityModel> slotAvailability) async {
    _slotAvailability = slotAvailability;
    notifyListeners();
  }

  // Selected sport controller ---------

  void setSelectedSport(
    int index,
    String facility,
    String sportName,
  ) {
    _selectedSport = index;
    _selectedSportName = sportName;
    _facility = facility;
    clearRadioValue();
    notifyListeners();
  }

  // Radio button controller -----------

  setRadioButton(String selectedButton) {
    _selectedRadioButton = selectedButton;
    notifyListeners();
  }

  clearRadioValue() {
    _selectedRadioButton = "";
  }

  // Date format controller ---------------

  setSelectedDate(DateTime? selectedDate, String venueId) {
    _selectedDate = selectedDate;
    getSlotAvailability(venueId: venueId);
    clearSelectedTime();
    notifyListeners();
  }

  setDate(DateTime selectedDate, venueId) {
    _selectedDate = selectedDate;
    _dates.clear();
    for (int i = 0; i < 5; i++) {
      _dates.add(selectedDate.add(Duration(days: i)));
    }
    getSlotAvailability(venueId: venueId);
    clearSelectedTime();
    notifyListeners();
  }

  // Time slot controller ----------------

  setSelectedTime(String selectedTime) {
    _selectedTime = selectedTime;
    notifyListeners();
  }

  clearSelectedTime() {
    _selectedTime = "HH:MM";
  }

  // CHECK SELECTED ALL FACILITY NEEDED

  checkBookingSelection() {
    if (_selectedDate == null ||
        _facility == "" ||
        _selectedRadioButton == "" ||
        _selectedSport == -1 ||
        _selectedTime == "HH:MM") {
      return false;
    }

    return true;
  }

  clearBookingSelection() {
    _facility = "";
    _selectedRadioButton = "";
    _selectedSport = -1;
    _selectedTime = "HH:MM";
    notifyListeners();
  }

  // Convert to 12 hours
  String convertTo12HourFormat(String time24) {
    if (time24 == "HH:MM") {
      return time24;
    }
    DateTime time = DateFormat('HH:mm').parse(time24);

    String time12 = DateFormat('h:mm a').format(time);

    return time12;
  }

  bool canSelectTimeSlot(
      {required bool isFromSlot,
      required int slotIndex,
      required BuildContext context}) {
    final venueViewModel = context.watch<VenueDetailsViewModel>();
    venueDataSlot = venueViewModel.venueData.slots!;
    timeSlotText = isFromSlot == true
        ? venueDataSlot[venueViewModel.dayIndex]
            .slots![slotIndex]
            .split("-")
            .first
        : venueDataSlot[venueViewModel.dayIndex]
            .slots![slotIndex]
            .split("-")
            .last;
    if (isFromSlot == false &&
        _selectedTime.isNotEmpty &&
        _selectedTime.contains(
          _selectedTime.split("-").last,
        )) {
      fromTimeSlotIndex =
          venueDataSlot[venueViewModel.dayIndex].slots!.indexWhere(
                (element) =>
                    element.split("-").last == _selectedTime.split("-").last,
              );
    }

    final parsedTimeOnly = DateFormat('HH:mm').parse(timeSlotText);
    final now = DateTime.now();
    final parsedDateTime = DateTime(
      _selectedDate?.year ?? now.year,
      _selectedDate?.month ?? now.month,
      _selectedDate?.day ?? now.day,
      parsedTimeOnly.hour,
      parsedTimeOnly.minute,
    );

    if (!isFromSlot && fromTimeSlotIndex == slotIndex ||
        isFromSlot && parsedDateTime.isAfter(now)) {
      return true;
    } else {
      return false;
    }
  }
}
