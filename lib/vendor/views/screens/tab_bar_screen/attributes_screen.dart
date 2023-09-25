import 'package:flutter/material.dart';

class AttributesScreen extends StatefulWidget {
  @override
  State<AttributesScreen> createState() => _AttributesScreenState();
}

class _AttributesScreenState extends State<AttributesScreen> {
  final TextEditingController _sizeController = TextEditingController();
  bool _isEntered = false;

  List<String> _sizeList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Brand',
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  child: TextFormField(
                    controller: _sizeController,
                    onChanged: (value) {
                      setState(() {
                        _isEntered = true;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Size'),
                  ),
                ),
              ),
              _isEntered
                  ? ElevatedButton(
                      onPressed: () {
                        _sizeList.add(_sizeController.text);
                        print(_sizeList);
                        setState(() {
                          _isEntered = false;
                        });
                      },
                      child: Text('Add Size'),
                    )
                  : Text(''),
            ],
          ),
        ],
      ),
    );
  }
}
