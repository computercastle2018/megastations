import 'package:mega/common/enums/data_source_enum.dart';
import 'package:mega/features/home/domain/models/advertisement_model.dart';

abstract class AdvertisementServiceInterface {
  Future<List<AdvertisementModel>?> getAdvertisementList(DataSourceEnum source);
}
