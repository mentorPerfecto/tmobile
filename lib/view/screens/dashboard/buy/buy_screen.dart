import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import '../../../../src/components.dart';

class BuySectionScreen extends ConsumerStatefulWidget {
  const BuySectionScreen({super.key});

  @override
  ConsumerState<BuySectionScreen> createState() => _BuySectionScreenState();
}

class _BuySectionScreenState extends ConsumerState<BuySectionScreen> {
  @override
  void didChangeDependencies() {
    ref.watch(buyViewModel).getCryptoCoins();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var buySectionProvider = ref.watch(buyViewModel);
    var dashboardProvider = ref.watch(dashboardViewModel);
    return Scaffold(
      appBar: AppBars.mainAppBar(
        context,
        backgroundColor: theme.scaffoldBackgroundColor,
        arrowBackColor: theme.primaryColor,
          text: selectCoin,
        callback: (){
          dashboardProvider.setPageIndexToHome(context);
        }
      ),
      body: XResponsiveWrap.mobile(
        onRefresh: () => buySectionProvider.getCryptoCoins(),
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 15.0.w,
                    right: 15.0.w,
                    top: 25.h,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(text: assetsText),
                      TextView(text: ratesText),
                    ],
                  ),
                ),
                Gap(10.h),
                const TampayDivider(),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: buySectionProvider.cryptoList.length,
                    itemBuilder: (context, index) {
                      CryptoCoinResponse aCryptoCoin = buySectionProvider.cryptoList[index];
                      String cryptoName = aCryptoCoin.id?.name ?? notAvailable;
                      String cryptoAcronym = aCryptoCoin.id?.acronym ?? notAvailable;
                      String cryptoSymbol = aCryptoCoin.symbol ?? notAvailable;

                      return CryptoCoinView(
                        cryptoSymbol: cryptoSymbol,
                        cryptoName: cryptoName,
                        cryptoAcronym: cryptoAcronym,
                        aCryptoCoin: aCryptoCoin,
                        onPressed: () {
                          navigatePush(
                              context,
                              EnterAmountScreen(
                                cryptoName: cryptoName,
                                cryptoAcronym: cryptoAcronym,
                                ratePerCrypto: aCryptoCoin.rate ?? 1505,
                              ));
                        },
                      );
                    })
              ],
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
