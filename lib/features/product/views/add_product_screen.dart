import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lasco/core/component/widgets/app_button.dart';
import 'package:lasco/core/component/widgets/app_text_field.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/features/offers/views/widgets/custom_app_bar.dart';

import '../../auth/view/sign_up_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();

  final List<File> _productImages = [];
  bool _applySale = false;
  String _selectedCategory = 'Category';
  final ImagePicker _picker = ImagePicker();

  final List<String> _categories = [
    'Category',
    'Electronics',
    'Clothing',
    'Food & Beverages',
    'Beauty & Health',
    'Sports',
    'Books',
  ];

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Add Product',
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Upload Section
              _buildImageUploadSection(),
              SizedBox(height: 24.h),

              // Product Name
              AppTextField(
                controller: _productNameController,
                hintText: 'Product Name',
                labelText: 'Product Name',
                radius: BorderRadiusDirectional.circular(12.r),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Product Price
              AppTextField(
                controller: _productPriceController,
                hintText: 'Product Price',
                labelText: 'Product Price',
                keyboardType: TextInputType.number,
                radius: BorderRadiusDirectional.circular(12.r),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    'LE',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Apply Sale Toggle
              _buildApplySaleToggle(),
              SizedBox(height: 16.h),

              // Description
              AppTextField(
                controller: _descriptionController,
                hintText: 'Product description',
                labelText: 'Description',
                maxLines: 4,
                radius: BorderRadiusDirectional.circular(12.r),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Category and Quantity Row
              Row(
                children: [
                  Expanded(
                    child: _buildCategoryDropdown(),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: AppTextField(
                      controller: _quantityController,
                      hintText: 'Quantity',
                      labelText: 'Quantity',
                      keyboardType: TextInputType.number,
                      radius: BorderRadiusDirectional.circular(12.r),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Add Product Button
              AppButton(
                text: 'Add Product',
                backgroundColor: AppColors.orange,
                onPressed: _addProduct,
                borderRadius: BorderRadiusDirectional.circular(12.r),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: _pickImages,
            child: CustomPaint(
              painter: DashedBorderPainter(
                color: Color(0xff2b2b266),
                strokeWidth: 1.5,
                dashWidth: 8.0,
                dashSpace: 4.0,
                borderRadius: 12.r,
              ),
              child: Container(
                width: 112.w,
                height: 112.h,
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  borderRadius: BorderRadiusDirectional.circular(12.r),
                ),
                child: _productImages.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(30.w),
                        child: SvgPicture.asset(
                          "assets/images/svg/camera-shot.svg",
                          width: 40.w,
                          height: 20.h,
                          color: Color(0xffB2B2B2).withAlpha(40),
                        ),
                      )
                    : _buildImagePreview(),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Upload Product Images',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xffB2B2B2),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemCount: _productImages.length + 1,
        itemBuilder: (context, index) {
          if (index == _productImages.length) {
            return GestureDetector(
              onTap: _pickImages,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.grey[600],
                  size: 24.sp,
                ),
              ),
            );
          }
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  _productImages[index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4.h,
                right: 4.w,
                child: GestureDetector(
                  onTap: () => _removeImage(index),
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildApplySaleToggle() {
    return Row(
      children: [
        Switch(
          value: _applySale,
          onChanged: (value) {
            setState(() {
              _applySale = value;
            });
          },
          activeColor: AppColors.orange,
        ),
        SizedBox(width: 8.w),
        Text(
          'Apply Sale',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadiusDirectional.circular(12.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _productImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _productImages.removeAt(index);
    });
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      // Add product logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
      Navigator.pop(context);
    }
  }
}
