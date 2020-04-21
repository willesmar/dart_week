import 'package:budget_api/controllers/movimentacoes/salvar_movimentacao_request.dart';
import 'package:budget_api/budget_api.dart';
import 'package:budget_api/model/categoria_model.dart';
import 'package:budget_api/model/movimentacao_model.dart';
import 'package:budget_api/model/usuario_model.dart';
import 'package:budget_api/repository/movimentacoes_repository.dart';

class MovimentacoesService {
  MovimentacoesService(this.context) : repository = MovimentacoesRepository(context);

  final ManagedContext context;
  final MovimentacoesRepository repository;

  Future<List<MovimentacaoModel>> buscarMovimentacoes(UsuarioModel usuario, String anoMes) {
    return repository.buscarMovimentacoes(usuario, anoMes);
  }

  Future<Map<String, dynamic>> recuperarTotalMovimentacoPorTipo(UsuarioModel usuario, String anoMes) async {
    final receitas = await repository.recuperarTotalMesAno(usuario, TipoCategoria.receita, anoMes);
    final despesas = await repository.recuperarTotalMesAno(usuario, TipoCategoria.despesa, anoMes);

    return {
      'receitas': receitas,
      'despesas': despesas,
      'total': (receitas['total'] ?? 0) + (despesas['total'] ?? 0),
      'saldo': (receitas['total'] ?? 0) + (despesas['total'] * -1 ?? 0),
    };
  }

  Future<void> salvarMovimentacao(UsuarioModel usuario, SalvarMovimentacaoRequest request) async {
    await repository.salvarMovimentacao(usuario, request);
  }
}
