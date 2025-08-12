import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseBikeScreen extends StatefulWidget {
  const ChooseBikeScreen({super.key});

  @override
  State<ChooseBikeScreen> createState() => _ChooseBikeScreenState();
}

class _ChooseBikeScreenState extends State<ChooseBikeScreen> {
  int selectedCategoryIndex = 0;
  final List<bool> favoriteStates = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF364A5C),
              Color(0xFF1E3A5F),
              Color(0xFF2B5A87),
              Color(0xFF4A90E2),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      _buildFeaturedBike(),
                      SizedBox(height: 30.h),
                      _buildCategoryFilters(),
                      SizedBox(height: 25.h),
                      _buildProductGrid(),
                      SizedBox(height: 100.h), // Space for bottom nav
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Choose Your Bike',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBike() {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2B5A87),
            Color(0xFF1E3A5F),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20.w,
            top: 20.h,
            child: Transform.rotate(
              angle: -0.2,
              child: Image.asset(
                'assets/images/png/featured_bike.png', // Add your bike image
                width: 200.w,
                height: 120.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.directions_bike,
                      size: 60.sp,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 25.w,
            bottom: 25.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '30% Off',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = [
      {'icon': Icons.all_inclusive, 'label': 'All'},
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.directions_bike, 'label': 'Bike'},
      {'icon': Icons.warning, 'label': 'Warning'},
      {'icon': Icons.favorite, 'label': 'Favorite'},
    ];

    return SizedBox(
      height: 10.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          bool isSelected = selectedCategoryIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(
                top: (10 + index * 10).w,
                start: 10.w,
              ),
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4A90E2)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData, // cast هنا
                    color: Colors.white,
                    size: isSelected ? 24.sp : 20.sp,
                  ),
                  if (index == 0)
                    Text(
                      category['label'] as String, // cast هنا
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildProductCard(
                title: 'Road Bike',
                subtitle: 'PEUGEOT - LR01',
                price: '\$1,999.99',
                imageAsset: 'assets/images/png/road_bike.png',
                favoriteIndex: 0,
                height: 180.h,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: _buildProductCard(
                title: 'Road Helmet',
                subtitle: 'SMITH - Trade',
                price: '\$120',
                imageAsset: 'assets/images/png/helmet.png',
                favoriteIndex: 1,
                height: 180.h,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(
              child: _buildProductCard(
                title: 'Mountain Bike',
                subtitle: 'TREK - X01',
                price: '\$2,499.99',
                imageAsset: 'assets/images/png/mountain_bike.png',
                favoriteIndex: 2,
                height: 140.h,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: _buildProductCard(
                title: 'Bike Gloves',
                subtitle: 'SPECIALIZED',
                price: '\$45',
                imageAsset: 'assets/images/png/gloves.png',
                favoriteIndex: 3,
                height: 140.h,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductCard({
    required String title,
    required String subtitle,
    required String price,
    required String imageAsset,
    required int favoriteIndex,
    required double height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.directions_bike,
                          size: 40.sp,
                          color: Colors.white.withOpacity(0.5),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  favoriteStates[favoriteIndex] =
                      !favoriteStates[favoriteIndex];
                });
              },
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  favoriteStates[favoriteIndex]
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      favoriteStates[favoriteIndex] ? Colors.red : Colors.white,
                  size: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF4A90E2).withOpacity(0.9),
            const Color(0xFF2B5A87),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.directions_bike, true),
          _buildNavItem(Icons.pause, false),
          _buildNavItem(Icons.shopping_cart, false),
          _buildNavItem(Icons.person, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4A90E2) : Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24.sp,
      ),
    );
  }
}
