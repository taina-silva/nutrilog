import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';

abstract class NutritionDatasource {
  Future<List<ListNutritionsModel>> getAllNutritions();
  Future<void> registerNewNutrition(NutritionModel payload);
}

class NutritionDatasourceImpl implements NutritionDatasource {
  final FirebaseFirestore _firestore;

  NutritionDatasourceImpl(this._firestore);

  @override
  Future<List<ListNutritionsModel>> getAllNutritions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('nutrition').get();
      List<ListNutritionsModel> n = snapshot.docs
          .where((doc) => doc.id != 'types')
          .map((doc) => ListNutritionsModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return n;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerNewNutrition(NutritionModel payload) async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('nutrition').where("type", isEqualTo: payload.type).get();
      QueryDocumentSnapshot doc = snapshot.docs.first;
      List<String> n = List.from((doc.data() as Map<String, dynamic>)["nutrition"]);
      n.add(payload.name);

      await _firestore.collection('nutrition').doc(doc.id).set({
        'type': payload.type,
        'nutrition': n,
      });
    } catch (exception) {
      rethrow;
    }
  }
}
