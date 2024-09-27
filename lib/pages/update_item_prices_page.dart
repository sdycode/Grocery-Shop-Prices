// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:groceryshopprices/lib.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class UpdateItemPricesPage extends StatefulWidget {
  final Item item;
  final Map<String, ItemDynamic> itemMap;
  const UpdateItemPricesPage({
    Key? key,
    required this.item,
    required this.itemMap,
  }) : super(key: key);

  @override
  State<UpdateItemPricesPage> createState() => _UpdateItemPricesPageState();
}

class _UpdateItemPricesPageState extends State<UpdateItemPricesPage> {
  late Item item;
  late Map<String, ItemDynamic> itemMap;
  ItemDynamic? itemDynamic;
  List<String> datesKeys = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item = widget.item;
    itemMap = widget.itemMap;
    String latestDateString = findNearestDateKey(itemMap.keys.toList());
    itemDynamic = itemMap[latestDateString];
    List<DateTime> dateList =
        itemMap.keys.map((key) => key.dateStringTo_DateTime()).toList();
    dateList.sort(
        (a, b) => a.millisecondsSinceEpoch.compareTo(b.millisecondsSinceEpoch));
    datesKeys = dateList.map((e) => e.toDayMonthYearUnderscore()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context: context, text: item.name),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (w.horizontalSpacing()),
          if (item.imageLinks.isNotEmpty)
            CachedImageWidget(
              image: item.imageLinks.first,
              width: w,
              height: w * 0.65,
              radius: 20,
              fit: BoxFit.cover,
              padding: 0,
            ),
          gap10,
          if (item.altenateNames.isNotEmpty)
            Wrap(
              children: item.altenateNames.map((name) {
                return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: 6.roundedCardShape(),
                        child: TextStyWidget.black(
                          text: name,
                          maxLines: 10,
                          fontsize: w * 0.045,
                          fontweight: FontWeight.w500,
                        ).applyPadding())
                    .applyPadding(padding: 4);
              }).toList(),
            ),
          if (itemDynamic != null)
            ...itemDynamic!.sellingPrices.map((e) {
              return PriceModelBasicWidget(
                price: e,
              );
            }),
          WheelChooser.custom(
            datas: datesKeys,
            itemSize: w * 0.26 + 16,
            horizontal: true,
            children:
                // List.generate(10, (i) => TextStyWidget.black(text: "text $i")),
                datesKeys
                    .map((d) => Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: 8.circularBorder()),
                          child: TextStyWidget.black(text: d)
                              .applySymmetricPadding(
                                  horizontal: 8, vertical: 4),
                        ))
                    .toList(),
            onValueChanged: (s) {
              printLog("date ${s}");
            },
          ).placeInContainer(w, w * 0.1),
        ],
      ).applySymmetricPadding().verticalScrollable(),
    );
  }
}
