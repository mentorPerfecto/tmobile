import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import '../../../../src/components.dart';

class BuyCryptoAssetScreen extends ConsumerStatefulWidget {
  const BuyCryptoAssetScreen({super.key});

  @override
  ConsumerState<BuyCryptoAssetScreen> createState() => _BuyCryptoAssetScreenState();
}

class _BuyCryptoAssetScreenState extends ConsumerState<BuyCryptoAssetScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(buyViewModel).getCryptoCoins();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    var buySectionProvider = ref.watch(buyViewModel);
    var dashboardProvider = ref.watch(dashboardViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        bottomVisible: true,
        bottomText: "Buy ${DummyData.cryptoAbbreviation}",
      ),
      body: XResponsiveWrap.mobile(
        onRefresh: () => buySectionProvider.getCryptoCoins(),
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoCoinView extends StatelessWidget {
  const CryptoCoinView(
      {super.key,
      required this.cryptoSymbol,
      required this.cryptoName,
      required this.cryptoAcronym,
      required this.aCryptoCoin,
      required this.onPressed});

  final String cryptoSymbol;
  final String cryptoName;
  final String cryptoAcronym;
  final CryptoCoinResponse aCryptoCoin;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 25.h,
                horizontal: 15.w,
              ),
              child: GestureDetector(
                onTap: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 112.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(cryptoSymbol),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: cryptoName,
                                fontSize: 14.spMin,
                              ),
                              Gap(3.h),
                              TextView(
                                text: cryptoAcronym,
                                color: AppColors.kCardText,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    TextView(
                      text:
                          "₦${UtilFunctions.formatAmount(aCryptoCoin.rate?.toDouble() ?? 0.0)}/$dollarSign",
                      fontSize: 14.spMin,
                    )
                  ],
                ),
              ),
            ),
          ),
          const TampayDivider(),
        ],
      ),
    );
  }
}
