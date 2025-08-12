import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  // Controllers
  final storeNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final storeAddressController = TextEditingController();
  final storeDescriptionController = TextEditingController();

  // Brand Category
  String? selectedCategory;
  final List<String> categories = [
    "Food & Beverage",
    "Clothing",
    "Electronics",
    "Health & Beauty",
  ];

  void setBrandCategory(String? category) {
    selectedCategory = category;
    emit(SignUpCategoryChanged(selectedCategory));
  }

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Password visibility
  bool isPasswordObscure = true;
  bool isStrongPassword = false;

  // Brand Logo
  File? brandLogo;
  final ImagePicker _picker = ImagePicker();

  void togglePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    emit(SignUpPasswordVisibilityChanged(isPasswordObscure));
  }

  void toggleStrongPassword(bool value) {
    isStrongPassword = value;
    emit(SignUpStrongPasswordChanged(isStrongPassword));
  }

  Future<void> pickBrandLogo() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        brandLogo = File(image.path);
        emit(SignUpBrandLogoSelected(brandLogo!));
      }
    } catch (e) {
      emit(SignUpError('Failed to pick image: $e'));
    }
  }

  Future<void> takeBrandLogoPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        brandLogo = File(image.path);
        emit(SignUpBrandLogoSelected(brandLogo!));
      }
    } catch (e) {
      emit(SignUpError('Failed to take photo: $e'));
    }
  }

  void removeBrandLogo() {
    brandLogo = null;
    emit(SignUpBrandLogoRemoved());
  }

  void signUp(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    Future.delayed(const Duration(seconds: 2), () {
      emit(SignUpSuccess());
    });
  }

  @override
  Future<void> close() {
    storeNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    storeAddressController.dispose();
    storeDescriptionController.dispose();
    return super.close();
  }
}
