// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:groceryshopprices/lib.dart';

class UpdateItemPricesPage extends StatefulWidget {
  final Item item;
  final ItemDynamic itemDynamic;
  const UpdateItemPricesPage({
    Key? key,
    required this.item,
    required this.itemDynamic,
  }) : super(key: key);

  @override
  State<UpdateItemPricesPage> createState() => _UpdateItemPricesPageState();
}

class _UpdateItemPricesPageState extends State<UpdateItemPricesPage> {
  late Item item;
  late ItemDynamic itemDynamic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item = widget.item;
    itemDynamic = widget.itemDynamic;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
