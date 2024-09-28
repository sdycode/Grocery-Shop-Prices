import 'package:groceryshopprices/lib.dart';
import 'package:groceryshopprices/models/ItemDynamic.dart';

Future addNewRatesForItemDialog(
    BuildContext context,
    Item item,
    Map<String, ItemDynamic> itemMap,
    TextEditingController sellingPriceC,
    TextEditingController qtyC) async {
  MeasureType measureType = item.measureTypes.first;
  DateTime date = nowDTime;
  ItemDynamic? itemDynamic = itemMap[date.toDayMonthYearUnderscore()];
  if (itemDynamic != null) {
    String latestDateString = findNearestDateKey(itemMap.keys.toList());
    itemDynamic = itemMap[latestDateString];
  }
  updateControllersForExistingData() {
    if (itemDynamic != null) {
      int ind = itemDynamic.sellingPrices
          .indexWhere((e) => e.measureType == measureType);
      if (ind >= 0) {
        PriceModel priceModel = itemDynamic.sellingPrices[ind];
        sellingPriceC.text = priceModel.price.toString();
        qtyC.text = priceModel.qty.toString();
      }
    }
  }

  updateControllersForExistingData();

  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: StatefulBuilder(builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                "Select Date".elButnStyle(onTap: () async {
                  DateTime? d = await displayAndSelectDate(context);
                  if (d != null) {
                    date = d;
                    updateControllersForExistingData();

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
                        updateControllersForExistingData();
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
                    // checkAndSetPriceAndQty(fullMeasureTypes[i],
                    //     priceControllers[i], qtyControllers[i]);
                  },
                  onChanged: (value) {
                    // checkAndSetPriceAndQty(fullMeasureTypes[i],
                    //     priceControllers[i], qtyControllers[i]);
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
                    // checkAndSetPriceAndQty(fullMeasureTypes[i],
                    //     priceControllers[i], qtyControllers[i]);
                  },
                  onChanged: (value) {
                    // checkAndSetPriceAndQty(fullMeasureTypes[i],
                    //     priceControllers[i], qtyControllers[i]);
                  },
                  hint: "Quantity",
                ),
              ],
            ).verticalScrollable().applySymmetricPadding();
          }),
        );
      });
}
