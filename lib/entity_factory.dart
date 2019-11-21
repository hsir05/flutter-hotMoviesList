import 'package:flutter-hotMoviesList/model/photo_model_entity.dart';
import 'package:flutter-hotMoviesList/model/optionions_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "PhotoModelEntity") {
      return PhotoModelEntity.fromJson(json) as T;
    } else if (T.toString() == "OptionionsEntity") {
      return OptionionsEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}