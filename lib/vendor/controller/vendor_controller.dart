import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // FUNCTION TO PICK IMAGE FROM GALLERY OR CAPTION FROM CAMERA

  pickStoreImage(ImageSource source) async {
    final ImagePicker _pickImage = ImagePicker();

    XFile? _file = await _pickImage.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  Future<String> vendorRegistrationForm(
      String shopName,
      String emailAddress,
      String phoneNumber,
      String countryValue,
      String stateValue,
      String cityValue) async {
    String res = 'something went wrong';
    try {
      await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
        'shopName': shopName,
        'emailAddress': emailAddress,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'vendorId': _auth.currentUser!.uid,
        'approved': false,
      });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
