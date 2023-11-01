// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../constants/image_urls.dart';
// import '../model/nav_tiles.dart';
// import 'leading_title_text.dart';

// class NavigationBtns extends StatefulWidget {
//   const NavigationBtns({
//     super.key,
//   });

//   @override
//   State<NavigationBtns> createState() => _NavigationBtnsState();
// }

// class _NavigationBtnsState extends State<NavigationBtns> {
//   List<NavigationTile> navTiles = [
//     NavigationTile('Personal Details', iconURL: personIcon, onPressed: () {}),
//     NavigationTile('Location', iconURL: lockIcon, onPressed: () {}),
//     NavigationTile('Payment Method', iconURL: cardIcon, onPressed: () {}),
//     NavigationTile('About', iconURL: personIcon, onPressed: () {}),
//     NavigationTile('Help', iconURL: personIcon, onPressed: () {}),
//     NavigationTile('Notification', iconURL: personIcon, onPressed: () {}),
//     NavigationTile('Log Out', iconURL: bellIcon, onPressed: () {}),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           for (int index = 0; index < navTiles.length; index++)
//             ListTile(
//               onTap: navTiles[index].onPressed,
//               leading: Container(
//                 padding: const EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(90),
//                     border: Border.all(color: Colors.black)),
//                 child: SvgPicture.asset(
//                   navTiles[index].iconURL,
//                   color: Colors.red.shade600,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               title: LeadingTitleText(
//                 navTiles[index].title,
//                 paddingDouble: 0.1,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//               ),
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
