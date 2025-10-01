// lib/ui/catalogo/widgets/catalogo_custom_table.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repsys/app_state/app_state.dart';
import 'package:repsys/data/repositories/clientes_repository.dart';
import 'package:repsys/domain/models/clientes_filtro_model.dart';
import 'package:repsys/domain/models/clientes_model.dart';
import 'package:repsys/domain/models/clientes_page_model.dart';
import 'package:repsys/domain/models/paginacao_model.dart';
import 'package:repsys/ui/clientes/components/clientes_editar.dart';
import 'package:repsys/ui/clientes/view_models/clientes_viewmodel.dart';

import 'package:repsys/ui/core/themes/colors.dart';
import 'package:repsys/ui/core/ui/input_decorations.dart';

class ClientesCustomTable extends StatefulWidget {
  final String empresaId;
  final int initialLimit;

  /// Você pode injetar o repo (para testes) ou deixar nulo que cria sozinho.
  final ClientesRepository? repository;

  const ClientesCustomTable({
    super.key,
    required this.empresaId,
    this.initialLimit = 20,
    this.repository,
  });

  @override
  State<ClientesCustomTable> createState() => _ClientesCustomTableState();
}

class _ClientesCustomTableState extends State<ClientesCustomTable> {
  late final ClientesRepository _repo;

  // filtros que vêm do AppState.catalogoFiltro
  String? _tipo;
  String? _comoConheceu;
  String? _busca;

  int _limit = 20;
  int _pagina = 1;

  late AppState _appState;
  ClientesFiltroModel? _lastFiltro;

  // Future atual (para o FutureBuilder)
  Future<ClientesPageModel>? _future;

  @override
  void initState() {
    super.initState();
    _repo = widget.repository ?? ClientesRepository();

    // AppState + listener
    _appState = context.read<AppState>();
    _lastFiltro = _appState.clientesFiltro;

    _limit = widget.initialLimit;
    _tipo = _lastFiltro?.tipo;
    _comoConheceu = _lastFiltro?.comoConheceu;
    _busca = _lastFiltro?.busca;

    _appState.addListener(_onAppStateChanged);

    _reload();
  }

  void _onAppStateChanged() {
    final f = _appState.clientesFiltro;
    final mudouTipo = f?.tipo != _tipo;
    final mudouMarca = f?.comoConheceu != _comoConheceu;
    final mudouBusca = f?.busca != _busca;
    if (!mudouTipo && !mudouMarca && !mudouBusca) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _tipo = f?.tipo;
        _comoConheceu = f?.comoConheceu;
        _busca = f?.busca;
        _pagina = 1;
      });
      _reload();
    });
  }

  @override
  void dispose() {
    _appState.removeListener(_onAppStateChanged);
    super.dispose();
  }

  Future<ClientesPageModel> _fetchPage() {
    return _repo.buscarClientesPage(
      empresaId: widget.empresaId,
      busca: _busca,
      tipo: _tipo,
      comoConheceu: _comoConheceu,
      limit: _limit,
      pagina: _pagina,
    );
  }

  void _reload() {
    final next = _fetchPage(); // faz o async fora
    if (!mounted) return;
    setState(() {
      // atualiza estado de forma síncrona
      _future = next;
    });
  }

  Future<void> _editaritem(ClientesModel item) async {
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider(
        create: (_) => ClientesViewmodel(), // já instancia com o repo dentro
        child: ClientesEditar(
          item: item,
        ),
      ),
    );
    _reload();
  }

  Widget _headerCell(String label) => Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF525251),
          fontSize: 12,
        ),
      );

  Widget _dataCell(String text,
      {TextAlign align = TextAlign.left, bool secondary = false}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: const Color(0xFF333233),
        fontSize: 14,
        fontWeight: secondary ? FontWeight.w400 : FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    return FutureBuilder<ClientesPageModel>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(
            child: Text('Erro ao carregar: ${snap.error}',
                style: const TextStyle(color: Colors.red)),
          );
        }
        final page = snap.data;
        if (page == null) return const SizedBox.shrink();

        final List<ClientesModel> itens = page.itens;
        final PaginacaoModel pag = page.paginacao;

        final int paginaAtual = pag.paginaAtual ?? _pagina;
        final int totalPaginas = pag.qtdPaginas ?? 1;

        return Column(
          children: [
            // Header (apenas em telas largas)
            if (isWide)
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE1E1E1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(child: _headerCell('Nome')),
                    const SizedBox(width: 8),
                    Expanded(child: _headerCell('E-mail')),
                    const SizedBox(width: 8),
                    Expanded(child: _headerCell('CPF/CNPJ')),
                    const SizedBox(width: 8),
                    Expanded(child: _headerCell('Telefone')),
                  ],
                ),
              ),
            const SizedBox(height: 8),

            // Linhas
            Expanded(
              child: itens.isEmpty
                  ? Center(child: Text('Nenhum item a ser listado'))
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: itens.length,
                      itemBuilder: (context, index) {
                        final e = itens[index];

                        if (isWide) {
                          // layout em colunas (tela larga)
                          return InkWell(
                            onTap: () => _editaritem(e),
                            child: Container(
                              height: 72,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFCFCFC),
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xFFE1E1E1))),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: _dataCell(e.nome ?? '-')),
                                  const SizedBox(width: 8),
                                  Expanded(child: _dataCell(e.email ?? '-')),
                                  const SizedBox(width: 8),
                                  Expanded(
                                      child: _dataCell(e.documento ?? '-')),
                                  const SizedBox(width: 8),
                                  Expanded(child: _dataCell(e.telefone ?? '-')),
                                ],
                              ),
                            ),
                          );
                        } else {
                          // layout "card" (mobile)
                          return InkWell(
                            onTap:  () => _editaritem(e),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCFCFC),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0xFFE1E1E1)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _dataCell(e.nome ?? '-'),
                                  const SizedBox(height: 6),
                                  _dataCell(e.email ?? '-', secondary: true),
                                  const SizedBox(height: 6),
                                  _dataCell(e.documento ?? '-',
                                      secondary: true),
                                  const SizedBox(height: 6),
                                  _dataCell(e.telefone ?? '-', secondary: true),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
            ),

            const SizedBox(height: 8),

            // Footer: paginação
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFFFCFCFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE1E1E1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // limit por página
                  IntrinsicWidth(
                    child: DropdownButtonFormField<int>(
                      isDense: true,
                      initialValue: _limit,
                      items: const [10, 20, 50]
                          .map((v) => DropdownMenuItem<int>(
                                value: v,
                                child: Text('$v itens',
                                    style: TextStyle(fontSize: 12)),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() {
                          _limit = v;
                          _pagina = 1;
                        });
                        _reload();
                      },
                      decoration: AppInputDecorations.dropdownNoLabel(),
                    ),
                  ),
                  // paginação
                  Row(
                    children: [
                      Text(
                        '$paginaAtual de $totalPaginas',
                        style: const TextStyle(
                            color: Color(0xFF525251), fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        color: AppColors.primaryText,
                        onPressed: paginaAtual <= 1
                            ? null
                            : () {
                                setState(() {
                                  _pagina = _pagina - 1;
                                });
                                _reload();
                              },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        color: AppColors.primaryText,
                        onPressed: paginaAtual >= totalPaginas
                            ? null
                            : () {
                                setState(() {
                                  _pagina = _pagina + 1;
                                });
                                _reload();
                              },
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
