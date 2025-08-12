import 'dart:io';

import 'package:flutter/material.dart';

abstract class OffersState {
  List<File> offersImages = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  bool applySale = false;
  String? selectedCategory = 'Category';

  OffersState copyWith();

  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
  }
}

class OffersInitial extends OffersState {
  @override
  OffersInitial copyWith() {
    return OffersInitial()
      ..offersImages = List.from(offersImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}

class OffersLoading extends OffersState {
  @override
  OffersLoading copyWith() {
    return OffersLoading()
      ..offersImages = List.from(offersImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}

class OffersAddedSuccessfully extends OffersState {
  @override
  OffersAddedSuccessfully copyWith() {
    return OffersAddedSuccessfully()
      ..offersImages = List.from(offersImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}

class OffersError extends OffersState {
  final String message;

  OffersError(this.message);

  @override
  OffersError copyWith() {
    return OffersError(message)
      ..offersImages = List.from(offersImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}
