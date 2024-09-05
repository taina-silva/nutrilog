import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/errors/exceptions/general.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';

abstract class ManageGeneralNutritionsDatasource {
  Future<List<ListNutritionsModel>> getGeneralNutritions();
  Future<void> registerNewNutrition(NutritionModel nutrition);
}

class ManageGeneralNutritionsDatasourceImpl implements ManageGeneralNutritionsDatasource {
  final FirebaseFirestore _firestore;

  ManageGeneralNutritionsDatasourceImpl(this._firestore);

  @override
  Future<List<ListNutritionsModel>> getGeneralNutritions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('nutritions').get();
      List<ListNutritionsModel> nutritions = snapshot.docs
          .where((doc) => doc.id != 'types')
          .map((doc) => ListNutritionsModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return nutritions;
    } catch (exception) {
      throw const GetGeneralNutritionsException();
    }
  }

  @override
  Future<void> registerNewNutrition(NutritionModel nutrition) async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('nutritions').where("type", isEqualTo: nutrition.type).get();
      QueryDocumentSnapshot doc = snapshot.docs.first;
      List<String> nutritions = List.from((doc.data() as Map<String, dynamic>)["nutritions"]);
      nutritions.add(nutrition.name);

      await _firestore.collection('nutritions').doc(doc.id).set({
        'type': nutrition.type,
        'nutritions': nutritions,
      });
    } catch (exception) {
      throw const RegisterNewNutritionException();
    }
  }
}
