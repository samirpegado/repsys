// lib/data/catalogo_repository.dart
import 'package:repsys/domain/models/catalogo_page_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClientesRepository {
  final _supabase = Supabase.instance.client;

  /// Insere um item no catálogo.
  Future<void> inserir(Map<String, dynamic> data) async {
    // Remover nulos para não enviar colunas desnecessárias
    data.removeWhere((k, v) => v == null);
    await _supabase.from('clientes').insert(data);
  }

  Future<void> editar(Map<String, dynamic> data) async {
    // Remover nulos para não enviar colunas desnecessárias
    data.removeWhere((k, v) => v == null);
    await _supabase.from('clientes').update(data).eq('id', data['id']);
  }

  Future<void> deletar(Map<String, dynamic> data) async {
    // Remover nulos para não enviar colunas desnecessárias

    await _supabase.from('clientes').delete().eq('id', data['id']);
  }

  /// Busca paginada via RPC `buscar_catalogo`, já convertendo para modelos.
  Future<CatalogoPageModel> buscarCatalogoPage({
    required String empresaId,
    String? busca,
    String? tipo,
    String? marca,
    int limit = 20,
    int pagina = 1,
  }) async {
    final resp = await _supabase.rpc('buscar_catalogo', params: {
      'p_empresa_id': empresaId,
      'p_busca': _nullIfEmpty(busca),
      'f_tipo': _nullIfEmpty(tipo),
      'f_marca': _nullIfEmpty(marca),
      'p_limit': limit,
      'p_pagina': pagina,
    });

    // Usa o factory que une as duas partes (itens + paginação)
    return CatalogoPageModel.fromRpc(resp);
  }

  // Helper
  String? _nullIfEmpty(String? s) {
    if (s == null) return null;
    final t = s.trim();
    return t.isEmpty ? null : t;
  }
}
