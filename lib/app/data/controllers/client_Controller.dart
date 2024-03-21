import 'package:objectbox/objectbox.dart';
import 'package:ArielSchool/app/data/modal.dart';

class ClientStore {
  final Store _store;

  ClientStore(this._store);

  Future<int> ajouterClient(Client client) async {
    final box = _store.box<Client>();
    return box.put(client);
  }

  Future<bool> modifierClient(Client client) async {
    final box = _store.box<Client>();
    return box.put(client) > 0;
  }

  Future<bool> supprimerClient(int id) async {
    final box = _store.box<Client>();
    return box.remove(id);
  }

  Future<Client?> getClientById(int id) async {
    final box = _store.box<Client>();
    return box.get(id);
  }

  List<Client> getAllClients() {
    final box = _store.box<Client>();
    return box.getAll();
  }
}
