import 'package:eco_app/models/user.dart';
import 'package:eco_app/services/database_service.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  final _db = DatabaseService();

  Future<UserProfile?> userProfile(String uid) => _db.getUserFirebase(uid);
}
