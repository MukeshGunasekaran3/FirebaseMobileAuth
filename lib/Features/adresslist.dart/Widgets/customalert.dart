import 'package:batechtask/Features/adresslist.dart/provider/addressProivder.dart';
import 'package:batechtask/core/widgets/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showalert(
    {required BuildContext context,
    required String name,
    required String address,
    int index = 0,
    required bool isedit}) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController =
      TextEditingController(text: name);
  final TextEditingController addressController =
      TextEditingController(text: address);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Details'),
        content: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name"),
                SizedBox(height: 5),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text("Address"),
                SizedBox(height: 5),
                TextFormField(
                  maxLines: 7,
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Save the data
                String name = nameController.text.trim();
                String address = addressController.text.trim();
                if (!isedit) {
                  try {
                    print("entered");
                    await Provider.of<Addressproivder>(context, listen: false)
                        .adddata(name: name, address: address);
                    Navigator.pop(context);
                  } catch (e) {
                    // TODO
                    showSnackBar(
                        message: e.toString(),
                        context: context,
                        color: Colors.red);
                    Navigator.pop(context);
                  }
                } else {
                  try {
                    await Provider.of<Addressproivder>(context, listen: false)
                        .editdata(index: index, name: name, address: address);
                    Navigator.pop(context);
                  } catch (e) {
                    // TODO
                    showSnackBar(
                        message: e.toString(),
                        context: context,
                        color: Colors.red);
                    Navigator.pop(context);
                  }
                }
              }
            },
            child: Text(
              'save',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      );
    },
  );
}
