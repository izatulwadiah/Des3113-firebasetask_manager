import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class FirestoreService {
  final CollectionReference _tasksRef = FirebaseFirestore.instance.collection(
    'tasks',
  );

  // READ — only tasks belonging to the logged-in user
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

  // CREATE
  Future<void> addTask(String title, String description, String userId) {
    return _tasksRef.add({
      'title': title,
      'description': description,
      'createdAt': Timestamp.now(),
      'userId': userId,
    });
  }

  // UPDATE
  Future<void> updateTask(String taskId, String title, String description) {
    return _tasksRef.doc(taskId).update({
      'title': title,
      'description': description,
    });
  }

  // DELETE
  Future<void> deleteTask(String taskId) {
    return _tasksRef.doc(taskId).delete();
  }
}
