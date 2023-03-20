import 'dart:io';

import 'package:bay_flutter1/src/bloc/management/management_bloc.dart';
import 'package:bay_flutter1/src/models/product.dart';
import 'package:bay_flutter1/src/pages/management/widgets/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final _form = GlobalKey<FormState>();

  var _product = Product(name: "productX", price: 10, stock: 20);
  var _editMode = false;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Product) {
      // edit mode
      _editMode = true;
      _product = arguments;
    }

    InputDecoration _inputStyle(String label) => InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          errorText: false ? 'Value Can\'t Be Empty' : null,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
          labelText: label,
        );

    return Scaffold(
        appBar: AppBar(title: Text('Management'), actions: [
          BlocBuilder<ManagementBloc, ManagementState>(
            builder: (context, state) {
              return IconButton(
                  icon: Icon(state.status == SubmitStatus.submitting ? Icons.directions_run : Icons.upload),
                  onPressed: state.status != SubmitStatus.submitting
                      ? () => context.read<ManagementBloc>().add(ManagementEventSubmit(
                            product: _product,
                            image: _imageFile,
                            isEditMode: _editMode,
                            form: _form,
                          ))
                      : null);
            },
          ),
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ProductForm(
              _product,
              formKey: _form,
              callBackSetImage: (file) {
                _imageFile = file;
              },
              deleteProduct: () => context.read<ManagementBloc>().add(ManagementEventDelete(_product.id!)),
            ),
          ),
        ));
  }
}
