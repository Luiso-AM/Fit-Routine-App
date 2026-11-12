/// Unit used to display and enter weights. Storage is always in kg.
enum WeightUnit {
  kg('kg'),
  lb('lb');

  const WeightUnit(this.symbol);

  /// Short label shown next to a weight, e.g. `60 kg`.
  final String symbol;
}
