class SignUpEmailPaswwordFailure {
  final String message;
  const SignUpEmailPaswwordFailure(
      [this.message = "Une erreur inconnue est survenue"]);
  factory SignUpEmailPaswwordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpEmailPaswwordFailure(
            'Please enter a stronger password');
      case 'invalid-email':
        return const SignUpEmailPaswwordFailure(
            'Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const SignUpEmailPaswwordFailure(
            'An account already exists for that email');
      case 'operation-not-allowed':
        return const SignUpEmailPaswwordFailure(
            'Operation is not allowed . Please contact support');
      case 'user-disabled':
        return const SignUpEmailPaswwordFailure(
            'This user has been disabled . Please contact support for help');
      default:
        return const SignUpEmailPaswwordFailure();
    }
  }
}
