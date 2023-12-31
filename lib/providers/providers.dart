import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/firestore_services.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// user name provider that i can save name as text

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final databaseProvider = Provider<FirestoreService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return FirestoreService(uid: uid);
  }
  return null;
});

final nameProvider = ChangeNotifierProvider<NameText>((ref) => NameText());

class NameText extends ChangeNotifier {
  String name = "";

  setName(String n) {
    name = n;
    notifyListeners();
  }
}
