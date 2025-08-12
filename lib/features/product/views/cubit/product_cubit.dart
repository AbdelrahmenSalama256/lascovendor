// lib/features/products/cubit/product_cubit.dart
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final ImagePicker _picker = ImagePicker();

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }

  void reset() {
    emit(ProductInitial());
  }

  Future<void> pickImages() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final newState = state.copyWith();
      newState.productImages.add(File(image.path));
      emit(newState);
    }
  }

  void removeImage(int index) {
    final newState = state.copyWith();
    newState.productImages.removeAt(index);
    emit(newState);
  }

  void updateProductName(String value) {
    final newState = state.copyWith();
    newState.nameController.text = value;
    emit(newState);
  }

  void updateProductPrice(String value) {
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

  Future<void> addProduct() async {
    if (!_validateInputs()) {
      emit(ProductError("Please fill all required fields"));
      return;
    }

    emit(ProductLoading());

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(ProductAddedSuccessfully());
    } catch (e) {
      emit(ProductError("Failed to add product: ${e.toString()}"));
    }
  }

  bool _validateInputs() {
    return state.nameController.text.isNotEmpty &&
        state.priceController.text.isNotEmpty &&
        state.descriptionController.text.isNotEmpty &&
        state.quantityController.text.isNotEmpty &&
        state.selectedCategory != null &&
        state.selectedCategory != 'Category' &&
        state.productImages.isNotEmpty;
  }

// Add to your ProductCubit
  void initialize(ProductState initialState) {
    emit(initialState.copyWith());
  }

  Future<void> updateProduct() async {
    if (!_validateInputs()) {
      emit(ProductError("Please fill all required fields"));
      return;
    }

    emit(ProductLoading());

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(ProductUpdatedSuccessfully());
    } catch (e) {
      emit(ProductError("Failed to update product: ${e.toString()}"));
    }
  }

  Future<void> deleteProduct() async {
    emit(ProductLoading());

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      emit(ProductDeletedSuccessfully());
    } catch (e) {
      emit(ProductError("Failed to delete product: ${e.toString()}"));
    }
  }
}
