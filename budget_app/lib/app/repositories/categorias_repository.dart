import 'package:budget_app/app/core/custom_dio.dart';
import 'package:budget_app/app/models/categoria_model.dart';

class CategoriaRepository {
  Future<List<CategoriaModel>> getCategorias(String tipo) {
    final dio = CustomDio.withAuthentication().instance;
    return dio.get('/categorias/$tipo').then((res) => res.data
        .map<CategoriaModel>((c) => CategoriaModel.fromMap(c))
        .toList());
  }
}
