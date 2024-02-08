import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';

abstract class GetNutritionDatasource {
  Future<List<ListNutritionsModel>> getAllNutritions();
  Future<void> registerNewNutrition(NutritionModel payload);
}

class GetNutritionDatasourceImpl implements GetNutritionDatasource {
  final FirebaseFirestore _firestore;

  GetNutritionDatasourceImpl(this._firestore);

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
      List<String> pA = List.from((doc.data() as Map<String, dynamic>)["nutrition"]);
      pA.add(payload.name);

      await _firestore.collection('nutrition').doc(doc.id).set({
        'type': payload.type,
        'nutrition': pA,
      });
    } catch (exception) {
      rethrow;
    }
  }
}
