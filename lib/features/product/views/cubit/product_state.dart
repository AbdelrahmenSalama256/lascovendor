// lib/features/products/cubit/product_state.dart
import 'dart:io';

import 'package:flutter/material.dart';

abstract class ProductState {
  List<File> productImages = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  bool applySale = false;
  String? selectedCategory = 'Category';

  ProductState copyWith();

  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
  }
}

class ProductInitial extends ProductState {
  @override
  ProductInitial copyWith() {
    return ProductInitial()
      ..productImages = List.from(productImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}

class ProductLoading extends ProductState {
  @override
  ProductLoading copyWith() {
    return ProductLoading()
      ..productImages = List.from(productImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}

class ProductAddedSuccessfully extends ProductState {
  @override
  ProductAddedSuccessfully copyWith() {
    return ProductAddedSuccessfully()
      ..productImages = List.from(productImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  ProductError copyWith() {
    return ProductError(message)
      ..productImages = List.from(productImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}

class ProductUpdatedSuccessfully extends ProductState {
  @override
  ProductUpdatedSuccessfully copyWith() {
    return ProductUpdatedSuccessfully()
      ..productImages = List.from(productImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}

class ProductDeletedSuccessfully extends ProductState {
  @override
  ProductDeletedSuccessfully copyWith() {
    return ProductDeletedSuccessfully()
      ..productImages = List.from(productImages)
      ..nameController.text = nameController.text
      ..priceController.text = priceController.text
      ..descriptionController.text = descriptionController.text
      ..quantityController.text = quantityController.text
      ..applySale = applySale
      ..selectedCategory = selectedCategory;
  }
}
