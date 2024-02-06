import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/modules/nutrition/infra/models/nutrition_model.dart';
import 'package:nutrilog/app/modules/nutrition/infra/models/nutrition_type_model.dart';
import 'package:uuid/uuid.dart';

abstract class NutritionsDatasource {
  Future<Tuple2<List<NutritionTypeModel>, List<NutritionModel>>> getAllNutritions();
  Future<void> registerNewNutrition(NutritionModel payload);
}

class NutritionsDatasourceImpl implements NutritionsDatasource {
  final FirebaseFirestore _firestore;

  NutritionsDatasourceImpl(this._firestore);

  @override
  Future<Tuple2<List<NutritionTypeModel>, List<NutritionModel>>> getAllNutritions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('physical-activities').get();
      List<dynamic> typesList = (snapshot.docs.firstWhere((doc) => doc.id == 'types').data()
          as Map<String, dynamic>)['types'];
      List<NutritionTypeModel> types = typesList.map((t) => NutritionTypeModel.fromMap(t)).toList();
      List<NutritionModel> pA = snapshot.docs
          .where((doc) => doc.id != 'types')
          .map((doc) => NutritionModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return Tuple2(types, pA);
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerNewNutrition(NutritionModel payload) async {
    try {
      _firestore.collection('physical-activities').doc(const Uuid().v4()).set(payload.toMap());
    } catch (exception) {
      rethrow;
    }
  }
}
