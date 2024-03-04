import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:p2pbookshare/pages/location_picker/location_picker_view.dart';
import 'package:p2pbookshare/pages/upload_book/upload_book_viewmodel.dart';
import 'package:p2pbookshare/services/providers/firebase/user_service.dart';

import 'widgets/address_card.dart';

class AddressPickerBottomSheet extends StatelessWidget {
  const AddressPickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final addbookHandler = Provider.of<UploadBookViewModel>(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 45,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              child: Consumer<FirebaseUserService>(
                builder: (context, firebaseUser, child) {
                  return StreamBuilder<List<Map<String, dynamic>>>(
                    stream: firebaseUser.fetchUserAddresses(
                      firebaseUser.getCurrentUserUid()!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Return a loading indicator if data is still loading
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Handle the error case
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        // Handle the case when there is no data yet
                        return const Text('No data available');
                      } else {
                        List<Map<String, dynamic>> userAddressList =
                            snapshot.data!;

                        return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: userAddressList.length,
                          itemBuilder: (context, index) {
                            return AddressCard(
                              street: userAddressList[index]['street'],
                              city: userAddressList[index]['city'],
                              state: userAddressList[index]['state'],
                              onTap: () {
                                addbookHandler.handleAddressSelection(
                                  context: context,
                                  address:
                                      '${userAddressList[index]['street']} ${userAddressList[index]['city']} ${userAddressList[index]['state']}',
                                  addressLatLng: LatLng(
                                    userAddressList[index]['coordinates']
                                        ['latitude'],
                                    userAddressList[index]['coordinates']
                                        ['longitude'],
                                  ),
                                );
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
            // Add new address button
            Center(
              child: SizedBox(
                height: 60,
                child: FilledButton(
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LocationPickerView();
                    }));
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_location_outlined,
                      ),
                      SizedBox(
                          width: 8), // Adjust spacing between icon and text
                      Text(
                        'Add new address',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
