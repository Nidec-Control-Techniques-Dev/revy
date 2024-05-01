enum DatabaseSourcesEnum {
  firebaseFirestore('Firebase Firestore'),
  firebaseRealtimeDatabase('Firebase Realtime Database'),
  supabase('Supabase'),
  appwrite('Appwrite'),
  sharedPreference('Shared Preference'),
  hive('Hive'),
  isar('Isar'),
  other('Other');

  const DatabaseSourcesEnum(this.name);
  final String name;
}
