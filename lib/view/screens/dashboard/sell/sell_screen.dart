import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tampay/config/app_strings.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/utils/enums.dart';
import 'package:tampay/view/components/coin_list_view.dart';
import 'package:tampay/view/components/profile_image.dart';
import 'package:tampay/view_model/dashboard/dashboard_view_model.dart';

class SellSectionScreen extends ConsumerStatefulWidget {
  const SellSectionScreen({super.key});

  @override
  ConsumerState<SellSectionScreen> createState() => _SellSectionScreenState();
}

class _SellSectionScreenState extends ConsumerState<SellSectionScreen> {
  @override
  Widget build(BuildContext context) {
    var dashboardProvider = ref.watch(dashboardViewModel);

    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBars.mainAppBar(context,
       
          text: selectCoin,
          textSize: 20.spMin,
          callback: (){
            dashboardProvider.setPageIndexToHome(context);
          }
         ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: assetsText),
                  TextView(text: ratesText),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              Expanded(
                child: listItems(),
              )
            ],
          ),
        ),
      ),
    );
  }

  listItems() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Check if it's the last item
        bool isLastItem = index == 9;

        return Column(
          children: <Widget>[
            CoinListView(
              imageUrl: AppImages.btcLogo,
              coinPrice: 'NGN2,806/\$',
              coinName: 'Bitcoin',
              coinTicker: 'BTC',
              onTap: () {
                logger.wtf('Hello');
                addBankBottomModalSheetWidget(context);
              },
            ),
            if (!isLastItem) TampayDivider(),
          ],
        );
      },
    );
  }
}
