 
import 'package:groceryshopprices/lib.dart';

class FullPageItemDetail extends StatefulWidget {
  final Item item;
  final ItemDynamic itemDynamic;
  const FullPageItemDetail({
    Key? key,
    required this.item,
    required this.itemDynamic,
  }) : super(key: key);

  @override
  State<FullPageItemDetail> createState() => _FullPageItemDetailState();
}

class _FullPageItemDetailState extends State<FullPageItemDetail> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
