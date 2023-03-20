import 'dart:io';

import 'package:bay_flutter1/src/app.dart';
import 'package:bay_flutter1/src/models/product.dart';
import 'package:bay_flutter1/src/services/network_service.dart';
import 'package:bay_flutter1/src/widgets/custom_flushbar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'management_event.dart';
part 'management_state.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  ManagementBloc() : super(ManagementState()) {
    // Submit
    on<ManagementEventSubmit>((event, emit) async {
      final _product = event.product!;
      final _imageFile = event.image;
      final _editMode = event.isEditMode!;
      final _form = event.form!;

      emit(state.copyWith(status: SubmitStatus.submitting));
      // hideKeyboard();

      await Future.delayed(Duration(seconds: 2));
      _form.currentState?.save();
      try {
        String result;
        if (_editMode) {
          result = await NetworkService().editProduct(_product, imageFile: _imageFile);
        } else {
          logger.i("Add Product : $_product");
          result = await NetworkService().addProduct(_product, imageFile: _imageFile);
        }

        Navigator.pop(navigatorState.currentContext!);
        emit(state.copyWith(status: SubmitStatus.success));

        CustomFlushbar.showSuccess(navigatorState.currentContext!, message: result);
      } catch (exception) {
        CustomFlushbar.showError(navigatorState.currentContext!, message: 'network fail');
        emit(state.copyWith(status: SubmitStatus.failed));
      }
    });

    // Delete
    on<ManagementEventDelete>((event, emit) {
      NetworkService().deleteProduct(event.productId).then((value) {
        Navigator.pop(navigatorState.currentContext!);
        CustomFlushbar.showSuccess(navigatorState.currentContext!, message: value);
        // navigatorState.currentContext!.read<HomeBloc>().add(HomeEventFetch());
      }).catchError((exception) {
        CustomFlushbar.showError(navigatorState.currentContext!, message: 'Delete fail');
      });
    });
  }
}
