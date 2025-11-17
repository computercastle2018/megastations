import 'package:mega/interfaces/repository_interface.dart';
import 'package:mega/util/html_type.dart';

abstract class HtmlRepositoryInterface extends RepositoryInterface {
  Future<dynamic> getHtmlText(HtmlType htmlType);
}
