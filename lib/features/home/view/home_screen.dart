import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lasco/core/constants/navigation.dart';
import 'package:lasco/features/home/view/component/widgets/custom_drawer.dart';
import 'package:lasco/features/notification/views/notifications_screen.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/cubit/global_cubit.dart';
import 'component/header.dart';
import 'component/metrics_grid.dart';
import 'component/new_orders_section.dart';
import 'component/profit_chart.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Transform.flip(
                        flipX: context.read<GlobalCubit>().language == "ar"
                            ? true
                            : false,
                        child: SvgPicture.asset(
                          "assets/images/svg/menu.svg",
                          width: 24.w,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateTo(context, NotificationScreen());
                      },
                      child: SvgPicture.asset(
                        "assets/images/svg/notification.svg",
                        color: AppColors.black,
                        width: 24.w,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: HeaderWidget(),
              ),
              SizedBox(height: 20.h),
              ProfitChartWidget(),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: MetricsGrid(),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: NewOrdersSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
