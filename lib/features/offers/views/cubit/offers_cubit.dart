// lib/features/offers/cubit/offers_cubit.dart
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  final ImagePicker _picker = ImagePicker();

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }

  void reset() {
    emit(OffersInitial());
  }

  Future<void> pickImages() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final newState = state.copyWith();
      newState.offersImages.add(File(image.path));
      emit(newState);
    }
  }

  void removeImage(int index) {
    final newState = state.copyWith();
    newState.offersImages.removeAt(index);
    emit(newState);
  }

  void updateOfferName(String value) {
    final newState = state.copyWith();
    newState.nameController.text = value;
    emit(newState);
  }

  void updateOfferPrice(String value) {
    final newState = state.copyWith();
    newState.priceController.text = value;
    emit(newState);
  }

  void updateDescription(String value) {
    final newState = state.copyWith();
    newState.descriptionController.text = value;
    emit(newState);
  }

  void updateQuantity(String value) {
    final newState = state.copyWith();
    newState.quantityController.text = value;
    emit(newState);
  }

  void toggleApplySale(bool value) {
    final newState = state.copyWith();
    newState.applySale = value;
    emit(newState);
  }

  void updateSelectedCategory(String? value) {
    final newState = state.copyWith();
    newState.selectedCategory = value;
    emit(newState);
  }

  Future<void> addOffer() async {
    if (!_validateInputs()) {
      emit(OffersError("Please fill all required fields"));
      return;
    }

    emit(OffersLoading());

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(OffersAddedSuccessfully());
    } catch (e) {
      emit(OffersError("Failed to add offer: ${e.toString()}"));
    }
  }

  bool _validateInputs() {
    return state.nameController.text.isNotEmpty &&
        state.priceController.text.isNotEmpty &&
        state.descriptionController.text.isNotEmpty &&
        state.quantityController.text.isNotEmpty &&
        state.selectedCategory != null &&
        state.selectedCategory != 'Category' &&
        state.offersImages.isNotEmpty;
  }
}
