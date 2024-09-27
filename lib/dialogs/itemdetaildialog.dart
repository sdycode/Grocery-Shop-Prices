// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:groceryshopprices/lib.dart';

showItemDetailDialog(BuildContext context,
    {required Item item, required Map<String, ItemDynamic> itemMap}) async {
  String latestDateString = findNearestDateKey(itemMap.keys.toList());
  ItemDynamic? itemDynamic = itemMap[latestDateString];

  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Column(
            children: [
              CloseCrossButton().alignRight(),
              if (item.imageLinks.isNotEmpty)
                CachedImageWidget(
                  image: item.imageLinks.first,
                  width: w * 0.6,
                  height: w * 0.6,
                  radius: 20,
                  fit: BoxFit.cover,
                ),
              gap10,
              if (itemDynamic != null)
                ...itemDynamic.sellingPrices.map((e) {
                  return PriceModelBasicWidget(
                    price: e,
                  );
                }),
              gap10,
              "Full Details".elButnStyle(onTap: () {}),
              "Update Rates".elButnStyle(onTap: () {
                goToScreenFor000(context,
                    UpdateItemPricesPage(item: item, itemMap: itemMap));
              })
            ],
          ).verticalScrollable().applySymmetricPadding(),
        );
      });
}

class PriceModelBasicWidget extends StatelessWidget {
  final PriceModel price;
  const PriceModelBasicWidget({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: 8.roundedCardShape(),
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextStyWidget.black(
            text: "${price.qty} ${price.measureType.name}",
            align: TextAlign.end,
            fontsize: w * 0.05,
            fontweight: FontWeight.bold,
          ),
          (w * 0.065).horizontalSpacing(),
          TextStyWidget.black(
            text: "${price.price} $rupee",
            align: TextAlign.start,
            fontsize: w * 0.05,
            fontweight: FontWeight.bold,
          ),
        ],
      ).applyMinimalVerticalPadding_4(),
    );
  }
}
