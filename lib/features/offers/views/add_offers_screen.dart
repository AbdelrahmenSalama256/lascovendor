// lib/features/offers/views/add_offers_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/component/widgets/app_button.dart';
import 'package:lasco/core/component/widgets/app_text_field.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';
import 'package:lasco/features/offers/views/widgets/custom_app_bar.dart';

import 'cubit/offers_cubit.dart';
import 'cubit/offers_state.dart';
import 'widgets/apply_sale_toggle.dart';
import 'widgets/category_dropdown.dart';
import 'widgets/image_upload_widget.dart';

class AddOffersScreen extends StatelessWidget {
  const AddOffersScreen({super.key});

@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'add_offer'.tr(context),
        ),
        body: BlocConsumer<OffersCubit, OffersState>(
          listener: (context, state) {
            if (state is OffersAddedSuccessfully) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('offer_added_successfully'.tr(context))),
              );
              Navigator.pop(context);
            } else if (state is OffersError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<OffersCubit>();
            final categories = [
              'Category',
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
                  // Image Upload Section
                  ImageUploadWidget(
                    productImages: state.offersImages,
                    onAddImage: cubit.pickImages,
                    onRemoveImage: cubit.removeImage,
                  ),
                  SizedBox(height: 24.h),

                  // Offer Name
                  AppTextField(
                    controller: state.nameController,
                    onChanged: cubit.updateOfferName,
                    hintText: 'offer_name'.tr(context),
                    labelText: 'offer_name'.tr(context),
                    radius: BorderRadiusDirectional.circular(12.r),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_offer_name'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Offer Price
                  AppTextField(
                    controller: state.priceController,
                    onChanged: cubit.updateOfferPrice,
                    hintText: 'offer_price'.tr(context),
                    labelText: 'offer_price'.tr(context),
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
                        return 'please_enter_offer_price'.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Apply Sale Toggle
                  ApplySaleToggle(
                    value: state.applySale,
                    onChanged: cubit.toggleApplySale,
                  ),
                  SizedBox(height: 16.h),

                  // Description
                  AppTextField(
                    controller: state.descriptionController,
                    onChanged: cubit.updateDescription,
                    hintText: 'offer_description'.tr(context),
                    labelText: 'description'.tr(context),
                    maxLines: 4,
                    radius: BorderRadiusDirectional.circular(12.r),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_offer_description'.tr(context);
                      }
                      return null;
                    },
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
                          validator: (value) {
                            if (value == null || value == 'Category') {
                              return 'please_select_category'.tr(context);
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AppTextField(
                          controller: state.quantityController,
                          onChanged: cubit.updateQuantity,
                          hintText: 'quantity'.tr(context),
                          labelText: 'quantity'.tr(context),
                          keyboardType: TextInputType.number,
                          radius: BorderRadiusDirectional.circular(12.r),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_quantity'.tr(context);
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Add Offer Button
                  AppButton(
                    text: 'add_offer'.tr(context),
                    backgroundColor: AppColors.orange,
                    onPressed: state is OffersLoading ? null : cubit.addOffer,
                    isLoading: state is OffersLoading,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
