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
  bool showEditControllers = false;
  List<MeasureType> measureTypes = [];
  List<MeasureType> fullMeasureTypes = MeasureType.values;
  String? currentDateKey;
  ItemDynamic? itemDynamic;
  ItemDynamic? itemDynamicForUpdate;
  List<String> datesKeys = [];
  List<TextEditingController> priceControllers = [];

  List<TextEditingController> qtyControllers = [];
  MeasureType? selectedMeasureType;
  StateSetter? textState;
  updateTextState() {
    if (textState != null) {
      textState!(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item = widget.item;
    itemMap = widget.itemMap;
    String latestDateString = findNearestDateKey(itemMap.keys.toList());
    currentDateKey = latestDateString;
    itemDynamic = itemMap[latestDateString];
    updateDateKeys();
    measureTypes = List.from(item.measureTypes);

    priceControllers =
        List.generate(fullMeasureTypes.length, (i) => TextEditingController());
    qtyControllers =
        List.generate(fullMeasureTypes.length, (i) => TextEditingController());
  }

  updateDateKeys() {
    List<DateTime> dateList =
        itemMap.keys.map((key) => key.dateStringTo_DateTime()).toList();
    dateList.sort(
        (a, b) => a.millisecondsSinceEpoch.compareTo(b.millisecondsSinceEpoch));
    datesKeys = dateList.map((e) => e.toDayMonthYearUnderscore()).toList();
  }

  setItemDyanmicForUpdate(DateTime date) {
    String dateString = date.toDayMonthYearUnderscore();
    // printLog(        "dates ${dateString} : ${itemMap.keys.toString()} : ${itemMap.containsKey(dateString)}");
    if (itemMap.containsKey(dateString)) {
      itemDynamicForUpdate = itemMap[dateString];
    } else {
      itemDynamicForUpdate = ItemDynamic(
          id: item.id, date: date, costPrices: [], sellingPrices: []);
    }
  }

  updateControllersBasedOnDate(String dateString) {
    if (itemMap.containsKey(dateString)) {
      itemDynamicForUpdate = itemMap[currentDateKey!]!;
      if (itemDynamicForUpdate != null) {
        for (var i = 0; i < itemDynamic!.sellingPrices.length; i++) {
          priceControllers[i].text =
              itemDynamic!.sellingPrices[i].price.toString();
          qtyControllers[i].text = itemDynamic!.sellingPrices[i].qty.toString();
        }
      }
    }
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
          gap20,
          WheelChooser<String>.custom(
            itemSize: w * 0.3 + 16,
            horizontal: true,
            children: datesKeys
                .map((d) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: 8.circularBorder()),
                      child: TextStyWidget.black(
                              fontsize: w * 0.035,
                              fontweight: FontWeight.w800,
                              text: d.parseToDate().toDayMonthYearSlash())
                          .applySymmetricPadding(horizontal: 4, vertical: 8),
                    ))
                .toList(),
            onValueChanged: (s) {
              printLog("date ${s}");
            },
          ).placeInContainer(w, w * 0.05 + 16).applyVerticalPadding(),
          gap10,
          "Select Date For New Rates".elButnStyle(
            onTap: () async {
              DateTime? date = await displayAndSelectDate(context);
              if (date != null) {
                
                setItemDyanmicForUpdate(date);
                updateControllersBasedOnDate(date.toDayMonthYearUnderscore());
                
                setState(() {
                  showEditControllers = true;
                });
              }
            },
          ),
          StatefulBuilder(builder: (c, doTextState) {
            textState = doTextState;
            return Column(
              children: [
                // if(itemDynamic!= null && itemDynamic!.sellingPrices)
                if (showEditControllers)
                  MeasureTypesListWidget(
                    measureTypes: measureTypes,
                    onTap: (e) {
                      if (measureTypes.contains(e)) {
                        measureTypes.remove(e);
                        if (selectedMeasureType == e) {
                          if (measureTypes.isNotEmpty) {
                            selectedMeasureType = measureTypes.first;
                          } else {
                            selectedMeasureType = null;
                          }
                        }
                      } else {
                        measureTypes.add(e);
                        selectedMeasureType = e;
                      }
                      updateTextState();
                    },
                  ),
                if (showEditControllers && measureTypes.isNotEmpty)
                  Row(children: [
                    lableAboveTextField("Selling Price*  (₹)")
                        .alignLeft()
                        .expandIfNeeded(),
                    20.horizontalSpacing(),
                    lableAboveTextField("Qty").alignLeft().expandIfNeeded(),
                  ]).applySymmetricPadding(horizontal: 8, vertical: 12),
                if (showEditControllers && measureTypes.isNotEmpty)
                  ...List.generate(fullMeasureTypes.length, (i) {
                    MeasureType measureType = fullMeasureTypes[i];
                    if (!measureTypes.contains(measureType)) {
                      return SizedBox();
                    }
                    return Column(
                      children: [
                        TextStyWidget.primary(
                          text: measureType.name,
                          fontweight: FontWeight.w800,
                        ).alignLeft().applyHorizontalPadding(horizontal: 8),
                        Row(
                          children: [
                            TextFieldBoxWidget.onlyDigit(
                              bottomPad: 2,
                              inputFormatters: [intFormatters],
                              normalBorderColor: transperent,
                              withPrimaryBorder: false,
                              controller: priceControllers[i],
                              onCleared: () {
                                priceControllers[i].clear();
                                checkAndSetPriceAndQty(fullMeasureTypes[i],
                                    priceControllers[i], qtyControllers[i]);
                              },
                              onChanged: (value) {
                                checkAndSetPriceAndQty(fullMeasureTypes[i],
                                    priceControllers[i], qtyControllers[i]);
                              },
                              hint: "Selling Price",
                            ).expandIfNeeded(),
                            12.horizontalSpacing(),
                            TextFieldBoxWidget.onlyDigit(
                              bottomPad: 2,
                              inputFormatters: [intFormatters],
                              normalBorderColor: transperent,
                              withPrimaryBorder: false,
                              controller: qtyControllers[i],
                              onCleared: () {
                                qtyControllers[i].clear();
                                checkAndSetPriceAndQty(fullMeasureTypes[i],
                                    priceControllers[i], qtyControllers[i]);
                              },
                              onChanged: (value) {
                                checkAndSetPriceAndQty(fullMeasureTypes[i],
                                    priceControllers[i], qtyControllers[i]);
                              },
                              hint: "Quantity",
                            ).expandIfNeeded(),
                          ],
                        ),
                        Divider(
                          color: DesignColor.primary.withAlpha(50),
                          height: 2,
                        ),
                        gap10,
                      ],
                    );
                  }),
                if (showEditControllers)
                  "Update New Rates".elButnStyle(
                      onTap: () async {
                        if (await noInternetAvailable()) {
                          showNoInternetDialog(context);
                          return;
                        }
                        if (itemDynamicForUpdate != null) {
                          itemDynamic = itemDynamicForUpdate!.copyWith();
                          itemMap[itemDynamicForUpdate!.date
                                  .toDayMonthYearUnderscore()] =
                              itemDynamicForUpdate!.copyWith();
                          updateDateKeys();
                          setState(() {});
                          showEditControllers = false;
                          itemDynamicForUpdate = null;
                          await addNewItem(
                              item.shopId, item, itemDynamicForUpdate!);

                          triggerSnackbar("New Rates Updated");
                        }
                      },
                      ignore:
                          measureTypes.isEmpty || !isUpdateDataHasMinimalData())
              ],
            );
          }),
        ],
      ).applySymmetricPadding().verticalScrollable(),
    );
  }

  bool isUpdateDataHasMinimalData() {
    printLog(
        "data empty len && ${itemDynamicForUpdate!.sellingPrices.length} : ${itemDynamicForUpdate != null}");
    if (itemDynamicForUpdate != null) {
      // if (itemDynamicForUpdate!.sellingPrices.isNotEmpty) {
      //   // printLog(            "loog ${itemDynamicForUpdate!.sellingPrices.first.toString()}");
      // }
      return itemDynamicForUpdate!.sellingPrices.isNotEmpty;
    }
    return false;
  }

  checkAndSetPriceAndQty(MeasureType measureType,
      TextEditingController sellingPriceC, TextEditingController qtyC) {
    printLog("data isnooo");

    int? price = int.tryParse(sellingPriceC.text.trim());
    int? qty = int.tryParse(qtyC.text.trim());
    printLog("data is $price : $qty");
    if (itemDynamicForUpdate != null) {
      int index = itemDynamicForUpdate!.sellingPrices
          .indexWhere((e) => e.measureType == measureType);
      if (price != null && qty != null) {
        PriceModel priceModel =
            PriceModel(measureType: measureType, price: price, qty: qty);
        if (index < 0) {
          itemDynamicForUpdate!.sellingPrices.add(priceModel);
        } else {
          itemDynamicForUpdate!.sellingPrices[index] = priceModel;
        }
      } else {
        if (index >= 0) {
          itemDynamicForUpdate!.sellingPrices
              .removeWhere((e) => e.measureType == measureType);
        }
      }
    }
    printLog(" data remove len ${itemDynamicForUpdate!.sellingPrices.length}");
    updateTextState();
  }
}
// if (price != null && qty != null) {
//   sellingPrices.clear();
//   sellingPrices.add(PriceModel(
//       qty: qty,
//       measureType: selectedMeasureType ?? MeasureType.kg,
//       price: price));
// }
// if (sellingPriceC.text.isEmpty) {
//   sellingPrices.clear();
// }
