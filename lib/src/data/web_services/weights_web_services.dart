import 'package:cloud_firestore/cloud_firestore.dart';

class WeightsWebServices {
  final weightsRef = FirebaseFirestore.instance.collection('weights');

  Stream<QuerySnapshot> getWeightsSnapshots() {
    return weightsRef.orderBy("timestamp", descending: true).snapshots();
  }

  Future<void> addWeight(Map<String, dynamic> weight) async {
    await weightsRef.doc(weight["id"]).set(weight);
  }

  Future<void> editWeight(Map<String, dynamic> weight) async {
    await weightsRef.doc(weight["id"]).update(weight);
  }

  Future<void> deleteWeight(String id) async {
    await weightsRef.doc(id).delete();
  }
}
