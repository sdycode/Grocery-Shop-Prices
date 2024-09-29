import 'package:groceryshopprices/lib.dart';
import 'package:groceryshopprices/models/ItemDynamic.dart';

Future<DateTime?> addNewRatesForItemDialog(
    BuildContext context,
    Item item,
    Map<String, ItemDynamic> itemMap,
    TextEditingController sellingPriceC,
    TextEditingController qtyC) async {
  MeasureType measureType = item.measureTypes.first;
  DateTime date = nowDTime;
  ItemDynamic? itemDynamic = itemMap[date.dateToUnder_Score_String()];
  if (itemDynamic != null) {
    String latestDateString = findNearestDateKey(itemMap.keys.toList());
    itemDynamic = itemMap[latestDateString];
  }
  bool isControllsersAreReadyToUpload() {
    int? price = int.tryParse(sellingPriceC.text.trim());
    int? qty = int.tryParse(qtyC.text.trim());
    if (qty != null && price != null && qty > 0 && price > 0) {
      return true;
    }

    return false;
  }

  PriceModel? getPriceModel() {
    int? price = int.tryParse(sellingPriceC.text.trim());
    int? qty = int.tryParse(qtyC.text.trim());
    if (qty != null && price != null && qty > 0 && price > 0) {
      return PriceModel(measureType: measureType, price: price, qty: qty);
    }
    return null;
  }

  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: StatefulBuilder(builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                "Select Date".elButnStyleBorderedButton(onTap: () async {
                  DateTime? d = await displayAndSelectDate(context);
                  if (d != null) {
                    date = d;
                    // if (itemMap.containsKey(date.dateToUnder_Score_String())) {
                    //   itemDynamic = itemMap[date.dateToUnder_Score_String()];
                    // }
                    // updateControllersForExistingData();

                    state(() {});
                  }
                }),
                TextStyWidget.primary(
                        fontweight: FontWeight.w700,
                        fontsize: w * 0.04,
                        text: date.toDayFullMonthYear())
                    .alignCenter(),
                MeasureTypesListWidget(
                    measureTypes: [measureType],
                    onTap: (b) {
                      state(() {
                        measureType = b;
                        // updateControllersForExistingData();
                      });
                    }).alignCenter(),
                gap20,
                lableAboveTextField("Selling Price"),
                TextFieldBoxWidget.onlyDigit(
                  bottomPad: 2,
                  inputFormatters: [intFormatters],
                  normalBorderColor: transperent,
                  withPrimaryBorder: false,
                  controller: sellingPriceC,
                  onCleared: () {
                    sellingPriceC.clear();
                    state(() {});
                  },
                  onChanged: (value) {
                    state(() {});
                  },
                  hint: "Selling Price",
                ),
                lableAboveTextField("Quantity"),
                TextFieldBoxWidget.onlyDigit(
                  bottomPad: 2,
                  inputFormatters: [intFormatters],
                  normalBorderColor: transperent,
                  withPrimaryBorder: false,
                  controller: qtyC,
                  onCleared: () {
                    qtyC.clear();
                    state(() {});
                  },
                  onChanged: (value) {
                    state(() {});
                  },
                  hint: "Quantity",
                ),
                "Update".elButnStyle(
                    onTap: () async {
                      PriceModel? priceModel = getPriceModel();
                      if (priceModel != null) {
                        itemDynamic ??= ItemDynamic(
                            id: item.id,
                            date: date,
                            costPrices: [],
                            sellingPrices: [priceModel]);
                        itemDynamic = addOrUploadPriceModelToItemDynamic(
                            priceModel, itemDynamic!);
                        itemMap[itemDynamic!.date.dateToUnder_Score_String()] =
                            itemDynamic!;
                        updateDynamicItem(itemDynamic!,
                            date: itemDynamic!.date);
                        exitOrAttemptExit000(context, returnValue: date);
                      }
                    },
                    ignore: !isControllsersAreReadyToUpload())
              ],
            ).verticalScrollable().applySymmetricPadding();
          }),
        );
      });
}

ItemDynamic addOrUploadPriceModelToItemDynamic(
    PriceModel priceModel, ItemDynamic itemDynamic) {
  for (var i = 0; i < itemDynamic.sellingPrices.length; i++) {
    PriceModel temppriceModel = itemDynamic.sellingPrices[i];
    if (temppriceModel.measureType == priceModel.measureType &&
        temppriceModel.qty == priceModel.qty) {
      itemDynamic.sellingPrices[i] = priceModel.copyWith();
      return itemDynamic;
    }
  }
  itemDynamic.sellingPrices.add(priceModel);
  return itemDynamic;
}


  // updateControllersForExistingData() {
  //   if (itemDynamic != null) {
  //     printLog("pricers ${itemDynamic!.sellingPrices.toString()}");
  //     int ind = itemDynamic!.sellingPrices
  //         .indexWhere((e) => e.measureType == measureType);
         
  //     if (ind >= 0) {
  //       PriceModel priceModel = itemDynamic!.sellingPrices[ind];
  //       sellingPriceC.text = priceModel.price.toString();
  //       qtyC.text = priceModel.qty.toString();
  //     } else {
  //       sellingPriceC.clear();
  //       qtyC.clear();
  //     }
  //   }
  // }

  // updateControllersForExistingData();