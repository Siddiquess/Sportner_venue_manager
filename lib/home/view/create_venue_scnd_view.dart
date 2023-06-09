import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view/create_venue_third_view.dart';
import 'package:sportner_venue_manager/home/view_model/create_venue_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import '../../utils/routes/navigations.dart';
import '../components/create_venue_components/discount_and_amount_field.dart';
import '../components/create_venue_components/document_image_picker.dart';
import '../components/create_venue_components/select_sport_widget.dart';
import '../components/create_venue_components/venue_image_picker.dart';
import '../components/error_data_widget.dart';

class CreateVenueScndView extends StatelessWidget {
  const CreateVenueScndView({
    super.key,
    this.isEditVenue = false,
    this.venueId = "",
  });
  final bool isEditVenue;
  final String venueId;

  @override
  Widget build(BuildContext context) {
    final createVenueViewModel = context.watch<CreateVenueViewModel>();
    final allSports = createVenueViewModel.sportsData;
    final title = isEditVenue ? "Edit your" : "Add new";
    return Scaffold(
      appBar: AppBar(
        title: Text("$title venue"),
        centerTitle: true,
      ),
      body: createVenueViewModel.errorData?.code == 404
          ? const NoInternetWidget()
          : GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizes.kHeight30,
                      const DocumentImagePicker(),
                      AppSizes.kHeight10,
                      DiscountAndAmountField(
                        controller: createVenueViewModel.venuePriceCntrllr,
                        title: "Amount",
                        hintText: "Per Hour",
                      ),
                      AppSizes.kHeight10,
                      DiscountAndAmountField(
                        controller: createVenueViewModel.venueDiscountCntrllr,
                        title: "Dicount %",
                        hintText: "Percentage%",
                      ),
                      AppSizes.kHeight20,
                      const VenueImageWidget(),
                      AppSizes.kHeight20,
                      SelectSportWidget(
                        allSports: allSports,
                        createVenueModel: createVenueViewModel,
                      ),
                      AppSizes.kHeight30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: context
                                      .watch<CreateVenueViewModel>()
                                      .createVenueSecondValidate()
                                  ? () {
                                      Navigator.push(
                                        context,
                                        AppScreens.animatedRoute(
                                          route: CreateVenueThirdView(
                                            isEditVenue: isEditVenue,
                                            venueId: venueId,
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                disabledBackgroundColor: AppColors.lightgrey,
                              ),
                              child: const Text("Next"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
