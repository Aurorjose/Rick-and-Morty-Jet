/// Convenience class for handling enumeration DTOs
abstract class EnumDTO {
  /// The value of this enum
  final String value;

  /// Creates new [EnumDTO]
  const EnumDTO.internal(this.value);
}
