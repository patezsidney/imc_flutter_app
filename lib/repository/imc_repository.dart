import '../models/imc.dart';

class ImcRepository {
  final List<IMC> _imcItems = [];
  final Duration _duration = const Duration(milliseconds: 100);

  Future<void> add(IMC item) async {
    await Future.delayed(_duration);
    _imcItems.add(item);
  }

  Future<List<IMC>> fetch() async {
    await Future.delayed(_duration);
    return _imcItems;
  }

  Future<void> remove(String itemId) async {
    await Future.delayed(_duration);
    _imcItems.remove(_imcItems.where((item) => item.id == itemId).first);
  }
}
