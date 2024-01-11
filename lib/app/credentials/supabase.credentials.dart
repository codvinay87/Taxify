import 'package:supabase/supabase.dart';

class SupabaseCredentials{
  static const APIKEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqampweGFpc2trb2ZvcGZqdnBoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzY2MjI2MzIsImV4cCI6MTk5MjE5ODYzMn0.7epADfI0pGU814wi1_yaNaFV8OCq137x0EurzwqS7Jw";
  static const APIURL="https://ljjjpxaiskkofopfjvph.supabase.co";

  static SupabaseClient supabaseClient =SupabaseClient(APIURL, APIKEY);
}