import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:movieapp/base/base_bloc.dart';
import 'package:movieapp/utils/utils.dart';

class LoginBloc extends BaseBloc {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get currentUser => _auth.authStateChanges();

  final fb = FacebookLogin();

  Future<UserCredential> signInWithFb(AuthCredential credential) =>
      _auth.signInWithCredential(credential);

  // Future<void> logout() => _auth.signOut();

  logoutWithFb() {
    _auth.signOut();
  }

  fbSignIn() async {
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        final result = await signInWithFb(authCredential);

        // Get profile data
        final profile = await fb.getUserProfile();

        logInfo("LOGIN", 'Hello, ${profile?.name}! You ID: ${profile?.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);

        logInfo("LOGIN", 'Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        logInfo("LOGIN", 'Your emaill: $email');

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  @override
  void dispose() {}
}
