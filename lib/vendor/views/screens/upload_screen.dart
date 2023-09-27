import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vendor_app_only/vendor/provider/product_provider.dart';
import 'package:vendor_app_only/vendor/views/screens/tab_bar_screen/general_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/tab_bar_screen/images_screen.dart';

class UploadScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('General'),
              ),
              // Tab(
              //   child: Text('Shipping'),
              // ),
              // Tab(
              //   child: Text('Attributes'),
              // ),
              Tab(
                child: Text('Images'),
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            children: [
              GeneralScreen(),
              //ShippingScreen(),
              //AttributesScreen(),
              ImagesScreen(),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () async {
              DocumentSnapshot userDoc = await _firestore
                  .collection('vendors')
                  .doc(_auth.currentUser!.uid)
                  .get();
              final menuId = Uuid().v4();
              if (_formKey.currentState!.validate()) {
                EasyLoading.show(status: 'Uploading');
                await _firestore.collection('menu').doc(menuId).set({
                  'menuId': menuId,
                  'menuName': _productProvider.productData['menuName'],
                  'menuPrice': _productProvider.productData['menuPrice'],
                  'categories': _productProvider.productData['categories'],
                  'description': _productProvider.productData['description'],
                  'menuImages': _productProvider.productData['imageUrlList'],
                  'shopName':
                      (userDoc.data() as Map<String, dynamic>)['shopName'],
                  'storeImage':
                      (userDoc.data() as Map<String, dynamic>)['storeImage'],
                  'countryValue':
                      (userDoc.data() as Map<String, dynamic>)['countryValue'],
                  'cityValue':
                      (userDoc.data() as Map<String, dynamic>)['cityValue'],
                  'stateValue':
                      (userDoc.data() as Map<String, dynamic>)['stateValue'],
                  'vendorId': _auth.currentUser!.uid,
                }).whenComplete(() {
                  EasyLoading.dismiss();
                  _productProvider.clearData();
                });
              } else {
                print('Not valid');
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
