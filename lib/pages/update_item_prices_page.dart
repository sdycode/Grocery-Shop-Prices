// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:wheel_chooser/wheel_chooser.dart';

import 'package:groceryshopprices/lib.dart';

class UpdateItemPricesPage extends StatefulWidget {
  final Item item;
  final Map<String, ItemDynamic> itemMap;
  final ShopModel shop;
  const UpdateItemPricesPage({
    Key? key,
    required this.item,
    required this.itemMap,
    required this.shop,
  }) : super(key: key);

  @override
  State<UpdateItemPricesPage> createState() => _UpdateItemPricesPageState();
}

class _UpdateItemPricesPageState extends State<UpdateItemPricesPage> {
  // FixedExtentScrollController fixedExtentScrollController =
  //     FixedExtentScrollController(initialItem: 0);
  int position = 0;
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
  DateTime? dateForEditUpdate;
  List<TextEditingController> qtyControllers = [];

  TextEditingController sellingPriceC = TextEditingController();
  TextEditingController qtyC = TextEditingController();
  MeasureType? selectedMeasureType;
  StateSetter? textState;
  updateTextState() {
    if (textState != null) {
      textState!(() {});
    }
  }

  File? image;
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
    // fixedExtentScrollController.addListener(() {
    //   printLog("scroll ${fixedExtentScrollController.offset}");
    // });
  }

  updateDateKeys() {
    List<DateTime> dateList =
        itemMap.keys.map((key) => key.dateStringTo_DateTime()).toList();
    dateList.sort(
        (a, b) => a.millisecondsSinceEpoch.compareTo(b.millisecondsSinceEpoch));
    datesKeys = dateList.map((e) => e.dateToUnder_Score_String()).toList();
    if (currentDateKey != null) {
      int indexOfDate = datesKeys.indexOf(currentDateKey!);
      if (indexOfDate >= 0) {
        position = indexOfDate;
      }
    }
  }

  setItemDyanmicForUpdate(DateTime date) {
    String dateString = date.dateToUnder_Score_String();
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
        measureTypes = itemDynamicForUpdate!.sellingPrices
            .map((e) => e.measureType)
            .toList();
        for (var i = 0; i < itemDynamic!.sellingPrices.length; i++) {
          MeasureType measureType = itemDynamic!.sellingPrices[i].measureType;
          int mInd = fullMeasureTypes.indexOf(measureType);
          if (mInd >= 0) {
            priceControllers[mInd].text =
                itemDynamic!.sellingPrices[i].price.toString();
            qtyControllers[mInd].text =
                itemDynamic!.sellingPrices[i].qty.toString();
          }
        }
      }
    }
  }

  bool showImgUploadloading = false;
  @override
  Widget build(BuildContext context) {
    // printLog("imglinks ${item.imageLinks}");
    // item.imageLinks.forEach((e) {
    //   printLog(e);
    // });
    return Scaffold(
      appBar: appBarWidget(context: context, text: item.name),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (w.horizontalSpacing()),
          // "delellet".elButnStyle(onTap: () async {
          //   printLog("link full ${item.imageLinks.first}");
          //   deleteImageFromFirebaseStorage(item.imageLinks.first);
          // }),
          if (item.imageLinks.isNotEmpty)
            StatefulBuilder(builder: (context, state) {
              return Column(
                children: [
                  Stack(
                    children: [
                      (image != null)
                          ? Image.file(
                              image!,
                              width: w,
                              height: w * 0.65,
                              fit: BoxFit.cover,
                            ).clipRounded(radius: 20)
                          : CachedImageWidget(
                              image: item.imageLinks.first,
                              width: w,
                              height: w * 0.65,
                              radius: 20,
                              fit: BoxFit.cover,
                              padding: 0,
                            ),
                      if (showImgUploadloading)
                        CircularProgressIndicator.adaptive()
                            .placeInContainer(w, w * 0.65),
                      if (amIPartOfThisShop(widget.shop))
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                              onPressed: () async {
                                await openSheet(
                                  context,
                                  (value) {
                                    image = value;
                                    state(() {
                                      showImgUploadloading = false;
                                    });
                                    // state(() {
                                    //   loadingForImg = false;
                                    // });
                                    // setState(() {});
                                  },
                                  () {
                                    state(() {
                                      showImgUploadloading = true;
                                    });
                                    // printLog("update called $loadingForImg");
                                    // state(() {
                                    //   loadingForImg = true;
                                    // });
                                  },
                                );
                              },
                              icon: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Icon(Icons.edit).applyPadding())),
                        )
                    ],
                  ).placeInContainer(w, w * 0.65),
                  if (image != null && amIPartOfThisShop(widget.shop))
                    "Update Photo".elButnStyle(
                        sidePad: 0,
                        vertPad: 16,
                        onTap: () async {
                          if (await noInternetAvailable()) {
                            showNoInternetDialog(context);
                            return;
                          }
                          state(() {
                            showImgUploadloading = true;
                          });
                          String link = await uploadDocument(image!);
                          if (link.isNotEmpty) {
                            List<String> oldLinks = List.from(item.imageLinks);
                            item.imageLinks.clear();
                            item.imageLinks.add(link);

                            image = null;
                            state(() {
                              showImgUploadloading = false;
                            });
                            await updateStaticItem(item);
                            oldLinks!.forEach((dlink) {
                              deleteImageFromFirebaseStorage(dlink);
                            });
                          }
                        },
                        loading: showImgUploadloading,
                        ignore: image == null)
                ],
              );
            }),
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
            startPosition: 0,

            // controller: fixedExtentScrollController,
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
              int? i = int.tryParse(s.toString());
              if (i != null) {
                ItemDynamic? itd = itemMap[datesKeys[i]];
                if (itd != null) {
                  itemDynamic = itd;
                  setState(() {});
                }
              }
              // printLog("date in  ${s}");
            },
          ).placeInContainer(w, w * 0.05 + 16).applyVerticalPadding(),
          gap10,
          if (amIPartOfThisShop(widget.shop))
            "Add New Rates".elButnStyle(onTap: () async {
              sellingPriceC.clear();
              qtyC.clear();
              dynamic newd = await addNewRatesForItemDialog(
                  context, item, itemMap, sellingPriceC, qtyC);
              if (newd.runtimeType == DateTime.now().runtimeType) {
                datesKeys.add((newd as DateTime).dateToUnder_Score_String());
                datesKeys = datesKeys.toSet().toList();
                printLog("updateDateKeys ${datesKeys.length}");
                updateDateKeys();
                printLog("updateDateKeys len ${datesKeys.length}");
              }
              setState(() {});
            }),
        ],
      ).applySymmetricPadding().verticalScrollable(),
    );
  }

  bool isUpdateDataHasMinimalData() {
    // printLog(        "data empty len && ${itemDynamicForUpdate!.sellingPrices.length} : ${itemDynamicForUpdate != null}");
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

/*
 if (amIPartOfThisShop(widget.shop))
            "Select Date For New Rates".elButnStyle(
              onTap: () async {
                DateTime? date = await displayAndSelectDate(context);
                if (date != null) {
                  dateForEditUpdate = date;
                  setItemDyanmicForUpdate(date);
                  updateControllersBasedOnDate(date.dateToUnder_Score_String());

                  setState(() {
                    showEditControllers = true;
                  });
                }
              },
            ),
          if (dateForEditUpdate != null)
            TextStyWidget.primary(
                    fontweight: FontWeight.w700,
                    fontsize: w * 0.04,
                    text: dateForEditUpdate!.toDayFullMonthYear())
                .alignCenter(),
          gap10,
          if (amIPartOfThisShop(widget.shop))
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
                                    .dateToUnder_Score_String()] =
                                itemDynamicForUpdate!.copyWith();
                            updateDateKeys();
                            setState(() {});
                            showEditControllers = false;
                            itemDynamicForUpdate = null;
                            dateForEditUpdate = null;
                            await updateDynamicItem(itemDynamicForUpdate!);

                            triggerSnackbar("New Rates Updated");
                          }
                        },
                        ignore: measureTypes.isEmpty ||
                            !isUpdateDataHasMinimalData())
                ],
              );
            }),
*/
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
