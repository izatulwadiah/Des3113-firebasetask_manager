import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class FirestoreService {
  final CollectionReference _tasksRef = FirebaseFirestore.instance.collection(
    'tasks',
  );

  Stream<List<Task>> getTasks(String userId) {
    return _tasksRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList(),
        );
  }

  
  Future<void> addTask(String title, String description, String userId) {
    return _tasksRef.add({
      'title': title,
      'description': description,
      'createdAt': Timestamp.now(),
      'userId': userId,
    });
  }

  
  Future<void> updateTask(String taskId, String title, String description) {
    return _tasksRef.doc(taskId).update({
      'title': title,
      'description': description,
    });
  }

  
  Future<void> deleteTask(String taskId) {
    return _tasksRef.doc(taskId).delete();
  }
}
