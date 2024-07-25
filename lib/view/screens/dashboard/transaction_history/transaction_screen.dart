import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';

class TransactionScreen extends ConsumerWidget {
  TransactionScreen({Key? key}) : super(key: key);
  final List<TransactionStatus> _transactions = [
    TransactionStatus(
      price: "₦280,500",
      transactionStatus: "Pending",
    ),
    TransactionStatus(
      price: "₦280,500",
      transactionStatus: "Completed",
    ),
    TransactionStatus(
      price: "₦280,500",
      transactionStatus: "Failed",
    ),
    TransactionStatus(
      price: "₦280,500",
      transactionStatus: "Pending",
    ),
  ];
  Color transactionStatusColor(String transactionStatus) {
    switch (transactionStatus) {
      case "Pending":
        return AppColors.kHarvestGold;
      case "Completed":
        return AppColors.kScreaminGreen;
      case "Failed":
        return AppColors.kError300;

      default:
        return AppColors.kWhite;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        arrowBackColor: theme.colorScheme.primary,
        text: "Transactions",
        trailing: Padding(
          padding: EdgeInsets.only(right: 15.0.w),
          child: Row(
            children: [
              const TextView(text: "filter"),
              Gap(5.w),
              Image.asset(
                AppImages.filterButtonIcon,
                width: 20.w,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: DailyTransactions(
                  transactions: ListView.builder(
                      itemCount: _transactions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final transaction = _transactions[index];
                        return Transactions(
                          transactionStatusColor:
                              transactionStatusColor(transaction.transactionStatus),
                          transactionPrice: transaction.price,
                          transactionStatus: transaction.transactionStatus,
                        );
                      }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DailyTransactions extends StatelessWidget {
  const DailyTransactions({
    super.key,
    required this.transactions,
  });
  final Widget transactions;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: "Today",
          fontSize: 10.spMin,
          color: AppColors.kGrey500,
        ),
        Gap(15.h),
        transactions,
      ],
    );
  }
}

class Transactions extends StatelessWidget {
  const Transactions({
    super.key,
    required this.transactionPrice,
    required this.transactionStatus,
    required this.transactionStatusColor,
  });
  final String transactionPrice;
  final String transactionStatus;
  final Color transactionStatusColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                AppImages.receiveMoneyLogo,
                width: 28.w,
                height: 28.h,
              ),
              Gap(5.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "Bitcoin",
                    fontSize: 14.spMin,
                  ),
                  Gap(5.h),
                  TextView(
                    text: "Buy",
                    fontSize: 12.spMin,
                    color: AppColors.kGrey500,
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextView(
                text: transactionPrice,
                fontSize: 14.spMin,
              ),
              Gap(5.h),
              TextView(
                color: transactionStatusColor,
                text: transactionStatus,
                fontSize: 12.spMin,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionStatus {
  final String price;
  final String transactionStatus;

  TransactionStatus({required this.price, required this.transactionStatus});
}
