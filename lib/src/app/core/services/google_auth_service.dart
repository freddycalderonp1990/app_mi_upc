import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService();

  static const String _serverClientId =
      '239580414059-j5ji0e7gej6sllcg3t3hlt9hnjelrd76.apps.googleusercontent.com';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    await _googleSignIn.initialize(
      serverClientId: _serverClientId,
    );

    _initialized = true;
  }

  Future<UserCredential> signInWithGoogle() async {
    await _ensureInitialized();

    final GoogleSignInAccount googleUser =
    await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOutGoogle() async {
    await _ensureInitialized();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}