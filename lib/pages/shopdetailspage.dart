// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:groceryshopprices/lib.dart';
import 'package:groceryshopprices/pages/addnewitempage.dart';

class ShopDetailsPage extends StatefulWidget {
  final ShopModel shop;
  const ShopDetailsPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  late ShopModel shop;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shop = widget.shop;
  }

  List itemIds = [];

  @override
  Widget build(BuildContext context) {
    itemIds.clear();
    return Scaffold(
      appBar: appBarWidget(context: context, text: shop.name),
      body: StreamBuilder<ShopModel?>(
          stream: null,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    if (isMyRequestPending(shop) && isValidUser)
                      Card(
                        child: TextStyWidget.primary(
                          text: "Request Pending",
                          fontsize: w * 0.056,
                        ).alignCenter().applyPadding(),
                      ),
                    if (!isMyRequestPending(shop) &&
                        !amIPartOfThisShop(shop) &&
                        isValidUser)
                      "Join Shop".elButnStyle(onTap: () async {
                        if (await noInternetAvailable()) {
                          showNoInternetDialog(context);
                          return;
                        }
                        await requstShopToJoin(shop);
                        setState(() {});
                      }),
                    StreamBuilder(
                        stream: getItemIdsListStream(shop.id),
                        builder: (_, snap) {
                          if (snap.hasData && snap.data!.isNotEmpty) {
                            itemIdsMap[shop.id] = snap.data!;
                            itemIds = snap.data!;
                          }
                          if (itemIds.isEmpty) {
                            return Center(
                              child: TextStyWidget.primary(
                                text: "No Items in the shop",
                                fontweight: FontWeight.w700,
                                fontsize: w * 0.065,
                                maxLines: 4,
                              ),
                            ).constrainFixedHeight(h * 0.7);
                          }
                          return GridView.builder(
                              itemCount: itemIds.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 1,
                                      crossAxisCount: 2),
                              itemBuilder: (c, i) {
                                return ItemBasicCardFromId(
                                  itemId: itemIds[i],
                                  shop: shop
                                  ,
                                );
                              });
                        })
                  ],
                ).verticalScrollable().expandIfNeeded(),
                if (amIPartOfThisShop(shop))
                  "Add New Item".elButnStyle(onTap: () async {
                    goToScreenFor000(
                        context,
                        AddNewItemPage(
                          shop: shop,
                        ));
                  }).applyPadding()
              ],
            );
          }),
    );
  }
}

class ItemBasicCardFromId extends StatelessWidget {
  final String itemId;
  final ShopModel shop;
  const ItemBasicCardFromId({
    Key? key,
    required this.itemId,
    required this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, ItemDynamic> itemMap = {};

    Item? item;
    return StreamBuilder<Map<String, ItemDynamic>>(
        stream: loadItemDynamicMapStream(itemId),
        builder: (context, snap) {
          if (snap.hasData) {
            itemMap = snap.data!;
          }
          String latestDateString = findNearestDateKey(itemMap.keys.toList());
          ItemDynamic? itemDynamic = itemMap[latestDateString];
          return StreamBuilder<Item?>(
              stream: getStaticItem(itemId),
              builder: (context, stSnap) {
                if (stSnap.hasData) {
                  item = stSnap.data;
                }
                if (item == null) {
                  return const SizedBox();
                }
                return BouncingBtn.fast(
                  onTap: () {
                    if (item != null && itemDynamic != null) {
                      showItemDetailDialog(context,
                          item: item!, itemMap: itemMap, shop: shop);
                    }
                  },
                  child: Card(
                    shape: 12.roundedCardShape(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (item!.imageLinks.isNotEmpty)
                          MultiSourceImageWidget(
                            img: item!.imageLinks.first,
                            size: w * 0.3,
                            roundRad: 12,
                            fit: BoxFit.cover,
                          ),
                        TextStyWidget.black(
                          text: item!.name,
                          fontsize: w * 0.04,
                          fontweight: FontWeight.w700,
                        ),
                        if (itemDynamic != null &&
                            itemDynamic!.sellingPrices.isNotEmpty)
                          Builder(builder: (context) {
                            PriceModel priceModel =
                                itemDynamic.sellingPrices.first;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextStyWidget.black(
                                    fontweight: FontWeight.w800,
                                    fontsize: w * 0.05,
                                    text: "${priceModel.price} $rupee "),
                                TextStyWidget.black(
                                    fontweight: FontWeight.w500,
                                    fontsize: w * 0.04,
                                    text:
                                        "(${priceModel.qty} ${priceModel.measureType.name})"),
                              ],
                            );
                          })
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

String findNearestDateKey(List<String> keys) {
  // Parse the map keys into DateTime objects
  List<DateTime> dateList =
      keys.map((key) => key.dateStringTo_DateTime()).toList();

  // Get today's date
  DateTime today = DateTime.now();

  // Separate dates into past and future dates
  List<DateTime> pastDates =
      dateList.where((date) => date.isBefore(today)).toList();
  List<DateTime> futureDates =
      dateList.where((date) => date.isAfter(today)).toList();

  // Sort both lists
  pastDates.sort((a, b) => b.compareTo(a)); // Nearest past date first
  futureDates.sort((a, b) => a.compareTo(b)); // Nearest future date first

  // If there are past dates, return the nearest past date
  if (pastDates.isNotEmpty) {
    DateTime nearestPastDate = pastDates.first;
    return DateFormat('dd_MM_yyyy').format(nearestPastDate);
  }

  // If no past date is available, return the nearest future date
  if (futureDates.isNotEmpty) {
    DateTime nearestFutureDate = futureDates.first;
    return DateFormat('dd_MM_yyyy').format(nearestFutureDate);
  }

  // If there are no past or future dates, return an empty string or handle as needed
  return keys.isNotEmpty ? keys.last : "";
}
