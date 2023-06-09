import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/home/view/quick_booking_view.dart';
import '../../utils/global_colors.dart';
import '../../utils/textstyles.dart';
import '../components/venue_details_components/venue_details_widget.dart';

class VenueDetailsView extends StatelessWidget {
  final int index;
  const VenueDetailsView({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Venue Details",
          style: AppTextStyles.textH2,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: VenueDetailsBody(index: index)),
      ),
      bottomNavigationBar: Container(
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const QuickBookingView(),));
          },
          style: ElevatedButton.styleFrom(elevation: 0),
          child: const Text("QUICK BOOK"),
        ),
      ),
    );
  }
}
