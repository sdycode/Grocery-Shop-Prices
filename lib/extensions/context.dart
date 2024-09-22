

import 'package:groceryshopprices/lib.dart';

extension WidgetExt on BuildContext {
  //  updateProvider =;
  T getProvider<T>() {
    return Provider.of(this);
  }
}
