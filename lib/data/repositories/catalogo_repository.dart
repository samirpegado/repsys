import 'package:supabase_flutter/supabase_flutter.dart';

class CatalogoRepository {
  final _supabase = Supabase.instance.client;


  Future<void> inserir(Map<String, dynamic> data) async {
    // Remover nulos para não enviar colunas desnecessárias
    data.removeWhere((k, v) => v == null);
    await _supabase.from('catalogo').insert(data);
  }
}
