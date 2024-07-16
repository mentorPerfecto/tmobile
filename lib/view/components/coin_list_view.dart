import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';

class CoinListView extends ConsumerStatefulWidget {
  final String imageUrl;
  final String coinName;
  final String coinPrice;
  final String coinTicker;
  final VoidCallback onTap;
  const CoinListView( { required this.imageUrl, required this.coinName,required this.coinTicker ,required this.coinPrice, required this.onTap,super.key});

  @override
  ConsumerState<CoinListView> createState() => _CoinListViewState();
}

class _CoinListViewState extends ConsumerState<CoinListView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Row(children: [
            ImageView.asset(widget.imageUrl, width: 32.w,),
            SizedBox(width: 8.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(text: widget.coinName),
                TextView(text: widget.coinTicker, color:  AppColors.kCardText,),
              ],
            ),

          ],),
          TextView(text: widget.coinPrice),

        ],),
      ),
    );
  }
}
