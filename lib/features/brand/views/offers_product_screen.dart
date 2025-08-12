import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/constants/navigation.dart';
import 'package:lasco/core/cubit/global_cubit.dart';
import 'package:lasco/core/locale/app_loacl.dart';
import 'package:lasco/features/brand/views/brand_details.dart';
import 'package:lasco/features/offers/views/widgets/custom_app_bar.dart';
import 'package:lasco/features/product/views/edit_product_screen.dart';

import '../../../core/component/widgets/app_text_field.dart';
import '../../home/view/component/widgets/offers_card.dart';
import '../../home/view/component/widgets/product_grid.dart';

class OffersProductScreen extends StatefulWidget {
  final BrandDetailsModel brand;

  const OffersProductScreen({
    super.key,
    required this.brand,
  });

  @override
  State<OffersProductScreen> createState() => _OffersProductScreenState();
}

class _OffersProductScreenState extends State<OffersProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {}); // Rebuild AppBar with updated titles
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: _tabController.index == 0
            ? "products".tr(context)
            : "offers".tr(context),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppTextField(
              controller: TextEditingController(),
              hintText: "search_products".tr(context),
              prefixIcon: Icon(
                CupertinoIcons.search,
                size: 25.sp,
                color: const Color(0xffB3B3B3),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          _buildTabBar(),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Products Tab
                _buildProductsTab(),

                // Offers Tab
                _buildOffersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerHeight: 0,
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: AppColors.orange,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(
            child: Container(
              constraints: BoxConstraints(
                minWidth: 90.w,
              ),
              alignment: Alignment.center,
              child: Text(
                "products".tr(context),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: context.read<GlobalCubit>().language == "ar"
                      ? 'Arabic'
                      : "English",
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              constraints: BoxConstraints(
                minWidth: 90.w,
              ),
              alignment: Alignment.center,
              child: Text(
                "offers".tr(context),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: context.read<GlobalCubit>().language == "ar"
                      ? 'Arabic'
                      : "English",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: ProductGrid(
        title: "",
        type: "vendor",
        ontap: () {
          navigateTo(context, EditProductScreen());
        },
        products: _getBrandProducts(),
      ),
    );
  }

  Widget _buildOffersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        spacing: 10.h,
        children: _getBrandOffers().map((offer) {
          return OfferGridCard(
            title: offer.title,
            type: "vendor",
            category: offer.category,
            imageUrl: offer.imageUrl,
            onPressed: () {
              // Optional onPressed action, e.g., navigate or show details
            },
          );
        }).toList(),
      ),
    );
  }

  List<ProductModel> _getBrandProducts() {
    return [
      ProductModel(
        id: '1',
        name: 'Bubblzz Body Lotion',
        category: 'Skin Care',
        rating: 4.5,
        price: '500 LE',
        imageUrl: 'assets/images/png/test-product.png',
        isOnSale: true,
        isFavorite: false,
      ),
      ProductModel(
        id: '2',
        name: 'Bubblzz Body Lotion',
        category: 'Skin Care',
        rating: 4.5,
        price: '500 LE',
        imageUrl: 'assets/images/png/test-product.png',
        isOnSale: true,
        isFavorite: false,
      ),
      ProductModel(
        id: '3',
        name: 'Bubblzz Body Lotion',
        category: 'Skin Care',
        rating: 4.5,
        price: '500 LE',
        imageUrl: 'assets/images/png/test-product.png',
        isOnSale: true,
        isFavorite: false,
      ),
      ProductModel(
        id: '4',
        name: 'Bubblzz Body Lotion',
        category: 'Skin Care',
        rating: 4.5,
        price: '500 LE',
        imageUrl: 'assets/images/png/test-product.png',
        isOnSale: true,
        isFavorite: false,
      ),
    ];
  }

  List<BrandOfferModel> _getBrandOffers() {
    return [
      BrandOfferModel(
        id: '1',
        title: 'buy_2_get_1_free'.tr(context),
        category: 'Skin Care',
        imageUrl: 'assets/images/png/test-product.png',
      ),
      BrandOfferModel(
        id: '2',
        title: 'buy_2_get_1_free'.tr(context),
        category: 'Skin Care',
        imageUrl: 'assets/images/png/test-product.png',
      ),
      BrandOfferModel(
        id: '3',
        title: 'buy_2_get_1_free'.tr(context),
        category: 'Skin Care',
        imageUrl: 'assets/images/png/test-product.png',
      ),
    ];
  }
}
