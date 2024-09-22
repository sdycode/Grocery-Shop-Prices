import 'package:groceryshopprices/lib.dart';

extension OfRadiusdouble on double {
  Radius radius() {
    return Radius.circular(this);
  }

  BorderRadius rightSideRadius() {
    return BorderRadius.horizontal(right: this.radius());
  }

  BorderRadius leftSideRadius() {
    return BorderRadius.horizontal(left: this.radius());
  }
}

extension OfRadiusINt on int {
  Radius radius() {
    return Radius.circular(this.toDouble());
  }

  BorderRadius rightSideRadius() {
    return BorderRadius.horizontal(right: this.radius());
  }

  BorderRadius leftSideRadius() {
    return BorderRadius.horizontal(left: this.radius());
  }
}
