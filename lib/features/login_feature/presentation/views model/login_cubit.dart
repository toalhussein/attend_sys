import 'package:attend_sys/features/login_feature/presentation/views%20model/login_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void login({required String workId, required String password}) async {
    emit(LoginLoading());
    try {
      final QuerySnapshot snapshot =
          await getUser(workId: workId, password: password);

      checkUserAvailability(snapshot, workId);
    } catch (e) {
      emit(LoginFailed(errorMessage: e.toString()));
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUser(
      {required String workId, required String password}) async {
    return await _firestore
        .collection('users')
        .where('work_id', isEqualTo: workId)
        .where('password', isEqualTo: password)
        .get();
  }

  void checkUserAvailability(QuerySnapshot<Object?> snapshot, String workId) {
    if (snapshot.docs.isNotEmpty) {
      final userRole = snapshot.docs.first['role'] as String;
      emit(LoginSuccess(userRole: userRole, userID: workId));
    } else {
      emit(LoginFailed(errorMessage: 'Invalid Work ID or Password'));
    }
  }
}




//       if (snapshot.docs.isNotEmpty) {
//         final userRole = snapshot.docs.first['role'] as String?;

//         if (userRole == null || userRole.isEmpty) {
//           emit(LoginFailed(errorMessage: 'Role is missing for this user'));
//         } else {
//           await _navigateToRolePage(userRole, doc.id);
//         }
//       } else {
//         _showToast('Invalid Work ID or Password');
//       }