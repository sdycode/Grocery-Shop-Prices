import 'dart:io';

import 'package:groceryshopprices/lib.dart';

class AddNewItemPage extends StatefulWidget {
  final ShopModel shop;
  const AddNewItemPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<AddNewItemPage> createState() => _AddNewItemPageState();
}

class _AddNewItemPageState extends State<AddNewItemPage> {
  late final ShopModel shop;

  List<PriceModel> costPrices = [];
  List<PriceModel> sellingPrices = [];
  List<File> images = [];
  List<String> imageLinks = [];
  List<String> altenateNames = [];
  TextEditingController nameC = TextEditingController();
  TextEditingController alternateNameC = TextEditingController();
  TextEditingController descbrC = TextEditingController();
  TextEditingController sellingPriceC = TextEditingController();
  TextEditingController qtyC = TextEditingController();

  MeasureType? selectedMeasureType;
  List<MeasureType> measureTypes = [];
  Item? item;
  ItemDynamic? itemDynamic;
  bool loadingForImg = false;
  bool showLoadingForAddItem = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shop = widget.shop;
  }

  @override
  void dispose() {
    nameC.dispose();
    alternateNameC.dispose();
    descbrC.dispose();
    sellingPriceC.dispose();
    qtyC.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  bool isCompleteDataFilledForItem() {
    return (nameC.text.isNotEmpty &&
        images.isNotEmpty &&
        measureTypes.isNotEmpty &&
        sellingPrices.isNotEmpty);
  }

  setUpItem() {
    if (isCompleteDataFilledForItem()) {
      item = Item(
          id: "id",
          name: nameC.text.trim(),
          imageLinks: imageLinks,
          altenateNames: altenateNames,
          measureTypes: measureTypes);
      itemDynamic = ItemDynamic(
          date: nowDTime,
          id: "id",
          costPrices: costPrices,
          sellingPrices: sellingPrices);
    }
  }

  getImage(StateSetter state) async {
    await openSheet(
      context,
      (value) {
        images.insert(0, value);
        state(() {
          loadingForImg = false;
        });
        setState(() {});
      },
      () {
        printLog("update called $loadingForImg");
        state(() {
          loadingForImg = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setUpItem();
    return Scaffold(
      appBar: appBarWidget(context: context, text: "Add New Item"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatefulBuilder(builder: (context, state) {
            return Column(
              children: [
                loadingForImg
                    ? const CircularProgressIndicator.adaptive()
                        .placeInContainer(w * 0.4, w * 0.4)
                    : BouncingBtn.fast(
                        onTap: () async {
                          getImage(state);
                        },
                        child: MultiSourceImageWidget(
                          defaultImgPath: "assets/appicon.png",
                          img: images.isNotEmpty ? images.first.path : "",
                          filePath: true,
                          size: w * 0.4,
                          roundRad: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                "Upload Photo".elButnStyle(
                  onTap: () async {
                    getImage(state);
                  },
                  fullWidth: false,
                  loading: loadingForImg,
                  padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                )
              ],
            );
          }).alignCenter(),
          gap20,
          lableAboveTextField("Item Name*").alignLeft(),
          TextFieldBoxWidget(
            normalBorderColor: transperent,
            withPrimaryBorder: false,
            controller: nameC,
            onChanged: (value) {
              setState(() {});
            },
            hint: "Enter Item Name",
          ),
          gap10,
          lableAboveTextField("Alternate Names").alignLeft(),
          Row(
            children: [
              TextFieldBoxWidget(
                bottomPad: 0,
                normalBorderColor: transperent,
                withPrimaryBorder: false,
                controller: alternateNameC,
                onChanged: (value) {
                  setState(() {});
                },
                hint: "Enter Alternate Name",
              ).expandIfNeeded(),
              BouncingBtn.fast(
                      onTap: () {
                        if (alternateNameC.text.isNotEmpty) {
                          altenateNames.add(alternateNameC.text.trim());
                          alternateNameC.clear();
                          setState(() {});
                        }
                      },
                      child: Card(
                          shape: 8.roundedCardShape(),
                          child: Icon(Icons.add).applyPadding()))
                  .applyHorizontalPadding(horizontal: 6)
                  .applyOpacityWithIgnore(ignore: alternateNameC.text.isEmpty)
            ],
          ),
          if (altenateNames.isNotEmpty)
            Column(
              children: altenateNames.map((name) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  shape: 12.roundedCardShape(),
                  child: Row(
                    children: [
                      TextStyWidget.black(
                        text: name,
                        maxLines: 10,
                      ).applyPadding().expandIfNeeded(),
                      BouncingBtn.fast(
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: DesignColor.red,
                          ).applyPadding(),
                          onTap: () {
                            altenateNames.remove(name);
                            setState(() {});
                          })
                    ],
                  ),
                );
              }).toList(),
            ),
          gap30,
          lableAboveTextField("Item Description").alignLeft(),
          TextFieldBoxWidget(
            normalBorderColor: transperent,
            withPrimaryBorder: false,
            maxLines: 3,
            controller: descbrC,
            onChanged: (value) {
              setState(() {});
            },
            hint: "Enter Item Description",
          ),
          gap10,
          lableAboveTextField("Select Measure Types").alignLeft(),
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
              setState(() {});
            },
          ),
          gap20,
          if (selectedMeasureType != null)
            Row(
              children: [
                lableAboveTextField("Selling Price*  (₹)")
                    .alignLeft()
                    .expandIfNeeded(),
                if (measureTypes.isNotEmpty)
                  PopupMenuButton<MeasureType>(
                    onSelected: (MeasureType selectedMeasure) {
                      // Handle selected measure type here
                      print(
                          'Selected Measure Type: ${selectedMeasure.toString().split('.').last}');
                    },
                    itemBuilder: (BuildContext context) {
                      return measureTypes.map((MeasureType measureType) {
                        return PopupMenuItem<MeasureType>(
                          onTap: () {
                            selectedMeasureType = measureType;
                            setState(() {});
                            dismissKeyboard();
                          },
                          value: measureType,
                          child: Text(measureType
                              .toString()
                              .split('.')
                              .last), // Convert enum to readable string
                        );
                      }).toList();
                    },
                    child: selectedMeasureType == null
                        ? const Icon(Icons.more_vert)
                        : Row(
                            children: [
                              TextStyWidget.black(
                                text: selectedMeasureType!.name,
                                fontweight: FontWeight.w600,
                                fontsize: w * 0.046,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: DesignColor.primary,
                              )
                            ],
                          ), // You can customize this icon or widget
                  )
              ],
            ),
          if (selectedMeasureType != null)
            Row(
              children: [
                TextFieldBoxWidget.onlyDigit(
                  inputFormatters: [intFormatters],
                  normalBorderColor: transperent,
                  withPrimaryBorder: false,
                  controller: sellingPriceC,
                  onCleared: () {
                    sellingPrices.clear();
                    setState(() {});
                  },
                  onChanged: (value) {
                    checkAndSetPriceAndQty();
                  },
                  hint: "Selling Price",
                ).expandIfNeeded(),
                12.horizontalSpacing(),
                TextFieldBoxWidget.onlyDigit(
                  inputFormatters: [intFormatters],
                  normalBorderColor: transperent,
                  withPrimaryBorder: false,
                  controller: qtyC,
                  onCleared: () {
                    sellingPrices.clear();
                    setState(() {});
                  },
                  onChanged: (value) {
                    checkAndSetPriceAndQty();
                  },
                  hint: "Quantity",
                ).expandIfNeeded(),
              ],
            ),
          "Add Item".elButnStyle(
              onTap: () async {
                if (await noInternetAvailable()) {
                  showNoInternetDialog(context);
                  return;
                }

                setUpItem();
                if (item != null &&
                    itemDynamic != null &&
                    images.isNotEmpty &&
                    sellingPrices.isNotEmpty) {
                  setState(() {
                    showLoadingForAddItem = true;
                  });
                  String link = await uploadDocument(images.first);
                  if (link.isNotEmpty) {
                    imageLinks.clear();
                    imageLinks.add(link);
                    String id =
                        "itemid_$uniqueId${nameC.text.formatSpacesAndForFirebasePath()}";
                    item = item!.copyWith(
                        id: id,
                        altenateNames: altenateNames,
                        imageLinks: imageLinks);
                    itemDynamic = itemDynamic!
                        .copyWith(id: id, sellingPrices: sellingPrices);

                    await addNewItem(shop.id, item!, itemDynamic!);
                    triggerSnackbar("Item added successfully");
                    clearAllFields();
                  }

                  setState(() {
                    showLoadingForAddItem = false;
                  });
                }
              },
              loading: showLoadingForAddItem,
              ignore: !isCompleteDataFilledForItem() || showLoadingForAddItem)
        ],
      ).applySymmetricPadding().verticalScrollable(),
    );
  }

  checkAndSetPriceAndQty() {
    int? price = int.tryParse(sellingPriceC.text.trim());
    int? qty = int.tryParse(qtyC.text.trim());

    if (price != null && qty != null) {
      sellingPrices.clear();
      sellingPrices.add(PriceModel(
          qty: qty,
          measureType: selectedMeasureType ?? MeasureType.kg,
          price: price));
    }
    if (sellingPriceC.text.isEmpty) {
      sellingPrices.clear();
    }
    setState(() {});
  }

  clearAllFields() {
    imageLinks.clear();
    images.clear();
    nameC.clear();
    descbrC.clear();
    sellingPriceC.clear();
    qtyC.clear();
    costPrices.clear();
    sellingPrices.clear();
    item = null;
    itemDynamic = null;
    altenateNames.clear();
    selectedMeasureType = null;
    measureTypes.clear();
  }
}

class MeasureTypesListWidget extends StatelessWidget {
  final List<MeasureType> measureTypes;
  final ValueChanged<MeasureType> onTap;
  const MeasureTypesListWidget({
    Key? key,
    required this.measureTypes,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: MeasureType.values.map((e) {
        bool selected = measureTypes.contains(e);
        return BouncingBtn.fast(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: 12.circularBorder(),
                color:
                    selected ? DesignColor.primary : DesignColor.primaryLight1,
              ),
              child: TextStyWidget(
                text: e.name,
                fontsize: w * 0.05,
                color: selected ? DesignColor.white : DesignColor.black,
                fontweight: FontWeight.w600,
              ),
            ),
            onTap: () {
              onTap(e);
            }).applyRightPadding();
      }).toList(),
    ).applyVerticalPadding(padding: 4);
  }
}
