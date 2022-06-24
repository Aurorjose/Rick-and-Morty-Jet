import '../../../domain_layer/models.dart';
import '../../dtos.dart';

/// Mapping extensions on the [LocationDTO].
extension LocationDTOMapping on LocationDTO {
  /// Maps a [LocationDTO] into a [Location].
  Location toLocation() => Location(
        id: id ?? 0,
        name: name ?? '',
        type: type ?? '',
        dimension: dimension ?? '',
        residentIds: residentIds,
        url: url ?? '',
        created: created,
      );
}
