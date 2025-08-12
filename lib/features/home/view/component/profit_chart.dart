import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lasco/core/constants/app_colors.dart';
import 'package:lasco/core/locale/app_loacl.dart';

class ProfitChartWidget extends StatefulWidget {
  const ProfitChartWidget({super.key});

  @override
  State<ProfitChartWidget> createState() => _ProfitChartWidgetState();
}

class _ProfitChartWidgetState extends State<ProfitChartWidget> {
  int selectedMonthIndex = 4; // Default selected month (July)
  final profits = [2.5, 4.2, 1.8, 3.5, 5.2, 3.8];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 233.h,
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xffFEF2ED),
        // borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title & selected profit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 7.h,
                  horizontal: 7.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "monthly_profit".tr(context),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                      color: const Color(0xff000000).withAlpha(33),
                    ),
                  ],
                ),
                child: Text(
                  "${profits[selectedMonthIndex].toStringAsFixed(3)} LE",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: SizedBox(
                width: 600.w,
                child: LineChart(LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30.h,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final months = [
                            "month_mar".tr(context),
                            "month_apr".tr(context),
                            "month_may".tr(context),
                            "month_jun".tr(context),
                            "month_jul".tr(context),
                            "month_aug".tr(context),
                          ];
                          if (value.toInt() >= 0 &&
                              value.toInt() < months.length) {
                            bool isSelected =
                                value.toInt() == selectedMonthIndex;
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  // vertical: 4.h,
                                ),
                                decoration: isSelected
                                    ? BoxDecoration(
                                        color:
                                            AppColors.orange.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      )
                                    : null,
                                child: Text(
                                  months[value.toInt()],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.orange
                                        : Colors.grey[500],
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  backgroundColor: const Color(0xffFEF2ED),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 6,
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) => AppColors.orange,
                      showOnTopOfTheChartBoxArea: false,
                      // tooltipBgColor: AppColors.orange,
                      tooltipRoundedRadius: 20.r,
                      tooltipPadding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            "${spot.y.toStringAsFixed(3)} LE",
                            TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          );
                        }).toList();
                      },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response?.lineBarSpots != null &&
                          response!.lineBarSpots!.isNotEmpty) {
                        setState(() {
                          selectedMonthIndex =
                              response.lineBarSpots!.first.x.toInt();
                        });
                      }
                    },
                    handleBuiltInTouches: true,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        profits.length,
                        (i) => FlSpot(i.toDouble(), profits[i]),
                      ),
                      isCurved: true,
                      curveSmoothness: 0.4,
                      color: AppColors.orange,
                      barWidth: 3.w,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          bool isSelected =
                              spot.x.toInt() == selectedMonthIndex;
                          return FlDotCirclePainter(
                            radius: isSelected ? 5 : 3,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.orange.withOpacity(0.5),
                            strokeWidth: isSelected ? 2 : 0,
                            strokeColor: AppColors.orange,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
