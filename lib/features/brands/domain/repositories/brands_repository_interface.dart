import 'package:mega/common/enums/data_source_enum.dart';
import 'package:mega/features/brands/domain/models/brands_model.dart';
import 'package:mega/features/item/domain/models/item_model.dart';
import 'package:mega/interfaces/repository_interface.dart';

abstract class BrandsRepositoryInterface extends RepositoryInterface {
  Future<ItemModel?> getBrandItemList({required int brandId, int? offset});
  Future<List<BrandModel>?> getBrandList({required DataSourceEnum source});
}
