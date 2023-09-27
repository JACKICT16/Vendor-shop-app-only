import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_app_only/vendor/provider/product_provider.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter menu Name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(menuName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Menu Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter menu Price';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(menuPrice: double.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Enter Price',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              DropdownButtonFormField(
                hint: Text(
                  'Select Category',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                items: _categoryList.map<DropdownMenuItem<dynamic>>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  _productProvider.getFormData(categories: value);
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter menu Description';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(description: value);
                },
                maxLength: 100,
                decoration: InputDecoration(
                  labelText: 'Enter Product Description',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
