import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GOOGLE_MAPS_API_KEY', obfuscate: true)
  static final String googleMapsApiKey = _Env.googleMapsApiKey;

  @EnviedField(varName: 'PUBLIC_SUPABASE_URL', obfuscate: true)
  static final String publicSupabaseUrl = _Env.publicSupabaseUrl;

  @EnviedField(varName: 'PUBLIC_SUPABASE_ANON_KEY', obfuscate: true)
  static final String publicSupabaseAnonKey = _Env.publicSupabaseAnonKey;
}
