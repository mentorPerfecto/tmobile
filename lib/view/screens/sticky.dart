// import 'package:flutter/material.dart';
//
// class StickyRowScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sticky Row Example'),
//       ),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverList(
//             delegate: SliverChildListDelegate([
//               Container(
//                 height: 50,
//                 color: Colors.green,
//                 alignment: Alignment.center,
//                 child: Text('Container 1'),
//               ),
//               Container(
//                 height: 50,
//                 color: Colors.yellow,
//                 alignment: Alignment.center,
//                 child: Text('Container 2'),
//               ),
//               Container(
//                 height: 50,
//                 color: Colors.orange,
//                 alignment: Alignment.center,
//                 child: Text('Container 3'),
//               ),
//               Container(
//                 height: 50,
//                 color: Colors.purple,
//                 alignment: Alignment.center,
//                 child: Text('Container 4'),
//               ),
//               Container(
//                 height: 50,
//                 color: Colors.red,
//                 alignment: Alignment.center,
//                 child: Text('Container 5'),
//               ),
//             ]),
//           ),
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: _StickyHeaderDelegate(
//               child: Container(
//                 color: Colors.blue,
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Sticky Row'),
//                     IconButton(
//                       icon: Icon(Icons.settings),
//                       onPressed: () {
//                         // Handle settings button press
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                 return ListTile(
//                   title: Text('List Item $index'),
//                 );
//               },
//               childCount: 50,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//
//   _StickyHeaderDelegate({required this.child});
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.blue,
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: child,
//     );
//   }
//
//   @override
//   double get maxExtent => 70.0;
//
//   @override
//   double get minExtent => 70.0;
//
//   @override
//   bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
