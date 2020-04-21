import 'package:budget_api/model/movimentacao_model.dart';
import 'package:budget_api/budget_api.dart';

class UsuarioModel extends ManagedObject<_UsuarioModel> implements _UsuarioModel {}

@Table(name: 'usuario')
class _UsuarioModel {

  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column(unique: true)
  String login;

  @Column()
  String senha;

  ManagedSet<MovimentacaoModel> movimentacoes;
}
