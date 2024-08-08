import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/dashboard/transaction_details/details_screen.dart';

class TransactionScreen extends ConsumerWidget {
  TransactionScreen({super.key});
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    var dashProvider = ref.watch(dashboardViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context, isVisible: false,
        bottomText: "Transactions",
        bottomVisible: true,
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
                          transactionId: "Payout",
                          transactionStatusColor:
                              dashProvider.transactionStatusColor(transaction.transactionStatus),
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
          text: "T O D A Y",
          fontSize: 12.spMin,
          color: AppColors.kGrey600,
        ),
        Gap(15.h),
        transactions,
      ],
    );
  }
}

class Transactions extends ConsumerWidget {
  const Transactions({
    super.key,
    required this.transactionPrice,
    required this.transactionStatus,
    required this.transactionStatusColor,
    required this.transactionId,
  });
  final String transactionPrice;
  final String transactionStatus;
  final Color transactionStatusColor;
  final String transactionId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        navigatePush(
            context,
            DetailsScreen(
              transactionStatus: transactionStatus,
            ));
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.0.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  transactionId == "Deposit" ? AppImages.receiveMoneyLogo : AppImages.sendMoneyLogoWhite,
                  width: 28.w,
                  height: 28.h,
                  color: theme.colorScheme.primary,
                ),
                Gap(5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "$transactionId ${DummyData.crypto}",
                      fontSize: 14.spMin,
                    ),
                    Gap(5.h),
                    TextView(
                      text: "105.5 ${DummyData.cryptoAbbreviation}",
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
      ),
    );
  }
}

class TransactionStatus {
  final String price;
  final String transactionStatus;

  TransactionStatus({required this.price, required this.transactionStatus});
}
