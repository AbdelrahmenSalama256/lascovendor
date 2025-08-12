// lib/features/products/views/edit_product_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/widgets/app_button.dart';
import 'package:lasco/core/component/widgets/app_custom_dialog.dart';
import 'package:lasco/core/component/widgets/app_text_field.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';
import 'package:lasco/features/offers/views/widgets/custom_app_bar.dart';

import '../../offers/views/widgets/apply_sale_toggle.dart';
import '../../offers/views/widgets/category_dropdown.dart';
import '../../offers/views/widgets/image_upload_widget.dart';
import 'cubit/product_cubit.dart';
import 'cubit/product_state.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'edit_product'.tr(context),
        ),
        body: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductUpdatedSuccessfully) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('product_updated_successfully'.tr(context))),
              );
              Navigator.pop(context);
            } else if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ProductCubit>();
            final categories = [
              'Category',
              'Skin Care',
              'Electronics',
              'Clothing',
              'Food & Beverages',
              'Beauty & Health',
              'Sports',
              'Books',
            ];

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'edit_product'.tr(context),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Image Upload Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'upload_product_images'.tr(context),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ImageUploadWidget(
                        productImages: state.productImages,
                        onAddImage: cubit.pickImages,
                        onRemoveImage: cubit.removeImage,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Product Name
                  AppTextField(
                    controller: state.nameController,
                    onChanged: cubit.updateProductName,
                    hintText: 'enter_product_name'.tr(context),
                    radius: BorderRadiusDirectional.circular(12.r),
                  ),
                  SizedBox(height: 16.h),

                  // Product Price
                  AppTextField(
                    controller: state.priceController,
                    onChanged: cubit.updateProductPrice,
                    hintText: 'enter_product_price'.tr(context),
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
                  ),
                  SizedBox(height: 16.h),

                  // Apply Sale Toggle
                  ApplySaleToggle(
                    value: state.applySale,
                    onChanged: cubit.toggleApplySale,
                  ),
                  SizedBox(height: 16.h),

                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        controller: state.descriptionController,
                        onChanged: cubit.updateDescription,
                        hintText: 'enter_product_description'.tr(context),
                        maxLines: 4,
                        radius: BorderRadiusDirectional.circular(12.r),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Category and Quantity Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CategoryDropdown(
                          value: state.selectedCategory,
                          items: categories,
                          onChanged: cubit.updateSelectedCategory,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AppTextField(
                          controller: state.quantityController,
                          onChanged: cubit.updateQuantity,
                          hintText: 'enter_quantity'.tr(context),
                          keyboardType: TextInputType.number,
                          radius: BorderRadiusDirectional.circular(12.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Delete Product Button
                  InkWell(
                    onTap: () => _showDeleteConfirmationDialog(context, cubit),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.trash,
                          size: 20.sp,
                          color: AppColors.red,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'delete_product'.tr(context),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.red,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Save Changes Button
                  AppButton(
                    text: 'save_changes'.tr(context),
                    backgroundColor: AppColors.orange,
                    onPressed:
                        state is ProductLoading ? null : cubit.updateProduct,
                    isLoading: state is ProductLoading,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, ProductCubit cubit) {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              imagePath: "assets/images/svg/cancel.svg",
              title: "delete_order_title",
              subtitle: "delete_order_subtitle",
              buttons: [
                DialogButton(
                  text: "cancel",
                  backgroundColor: const Color(0xffFEEBE3),
                  textStyle: TextStyle(
                    color: AppColors.orange,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                DialogButton(
                  text: "delete",
                  backgroundColor: AppColors.orange,
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  height: 56.h,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }
}
