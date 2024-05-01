enum AuthSourcesEnum {
  supabaseAuth('Supabase Auth'),
  firebaseAuth('Firebase Auth'),
  customAuth('Custom Auth');

  const AuthSourcesEnum(this.name);
  final String name;
}
