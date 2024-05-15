import 'package:revy/env/env.dart';
import 'package:supabase/supabase.dart';

void test() {
  print('Hello World!');
  print(Env.googleMapsApiKey);
}

Future<void> main() async {
  test();

  print('[1] Initializing Supabase client...');
  final SupabaseClient supabase = SupabaseClient(
    Env.publicSupabaseUrl,
    Env.publicSupabaseAnonKey,
  );

  // Authenticate.
  print('\n[2] Signing in with email and password...');
  final AuthResponse res = await supabase.auth.signInWithPassword(
    email: 'mpvviernes@gmail.com',
    password: 'Qwerty1234',
  );
  final Session? session = res.session;
  final User? user = res.user;

  print('Session: $session');
  print('User: $user');

  // Fetch.
  print('\n[3] Fetching data...');
  final data = await supabase.from('currencies').select('*');
  print('Data: $data');
}
