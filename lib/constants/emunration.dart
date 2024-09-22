enum MeasureType { kg, gram, units, ltr, ml }

extension MeasureTypeExtension on String {
  // Method to convert enum value to readable string
  MeasureType getMeasureType() {
    switch (toLowerCase()) {
      case 'kg':
        return MeasureType.kg;
      case 'gram':
        return MeasureType.gram;
      case 'units':
        return MeasureType.units;
      case 'ltr':
        return MeasureType.ltr;
      case 'ml':
        return MeasureType.ml;
      default:
        return MeasureType
            .kg; // Return null if the string doesn't match any enum value
    }
  }
}
