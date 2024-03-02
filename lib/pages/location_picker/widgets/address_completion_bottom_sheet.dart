import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:p2pbookshare/extensions/color_extension.dart';
import 'package:p2pbookshare/pages/addbook/widgets/widgets.dart';
import 'package:p2pbookshare/pages/location_picker/location_handler.dart';
import 'package:p2pbookshare/services/providers/firebase/user_service.dart';
import 'package:p2pbookshare/services/providers/others/location_service.dart';
import 'package:provider/provider.dart';

//TODO: Give name to address (home/college/office)

//! Further address completion Botom Sheet
addressCompletionBottomSheet(
    {required BuildContext context, required String city, state}) {
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController(text: city);
  TextEditingController stateController = TextEditingController(text: state);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      return Consumer2<LocationService, FirebaseUserService>(
        builder: (context, locationService, firebaseUserService, child) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              height: 500,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                //  color: Theme.of(context).bottomSheetTheme.backgroundColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 5,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    const Spacer(),
                    const Text('Street'),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: streetController,
                      // labelText: "City",
                      isMultiline: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('City'),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: cityController,
                      // labelText: "City",
                      isMultiline: false,
                      isReadOnly: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('State'),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: stateController,
                      // labelText: "State",
                      isMultiline: false,
                      isReadOnly: true,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    FilledButton(
                        onPressed: () {
                          GetLocationHandler.handleAddressCompletionContinue(
                            context: context,
                            streetController: streetController,
                            cityController: cityController,
                            stateController: stateController,
                          );
                        },
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.arrowRight,
                                color: context.onPrimary,
                              ),
                              Text(
                                'Continue',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
