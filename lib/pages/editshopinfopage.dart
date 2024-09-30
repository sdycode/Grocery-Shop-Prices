// // ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
// import 'package:flutter/widgets.dart';

// import 'package:groceryshopprices/lib.dart';

// class EditShopPage extends StatefulWidget {
//   final ShopModel shop;
//   const EditShopPage({
//     Key? key,
//     required this.shop,
//   }) : super(key: key);

//   @override
//   State<EditShopPage> createState() => _EditShopPageState();
// }

// class _EditShopPageState extends State<EditShopPage> {
//   late ShopModel shop;
//   TextEditingController controller = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     shop = widget.shop;
//     oldName = shop.name.trim();
//   }

//   double get size => w * 0.6;
//   String oldShopName = "";
//   @override
//   void dispose() {
//     controller.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarWidget(context: context, text: "Edit Shop Details"),
//       body: Center(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 if (shop.images.isNotEmpty)
//                   CachedImageWidget(
//                     image: shop.images.first,
//                     width: size,
//                     height: size,
//                     padding: 0,
//                     radius: 20,
//                   ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: IconButton(
//                       onPressed: () {},
//                       icon: CircleAvatar(
//                           backgroundColor: Colors.grey.shade300,
//                           child: Icon(Icons.edit))),
//                 )
//               ],
//             ).placeInContainer(size, size),
//             TextFieldBoxWidget(controller: controller, hint: "Enter shop name")
//                 .applySymmetricPadding(),
//             "Update".elButnStyle(
//               onTap: () async {},
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
