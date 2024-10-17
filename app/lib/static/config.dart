final class Config {
  const Config._();

  static const totalBaseItemQuestions = 3;
  static const totalFullItemQuestions = 7;
  static const totalQuestions = totalBaseItemQuestions + totalFullItemQuestions;

  static const patchNotesPageSize = 8;

  static const adminPassword = '175613';
  static const amountOfStepsToEnableAdmin = 7;

  static const supabaseUrl = String.fromEnvironment('supabase_url');
  static const supabaseAnonKey = String.fromEnvironment('supabase_anon_key');

  static const githubOwner = String.fromEnvironment('github_owner');
  static const githubRepo = String.fromEnvironment('github_repo');
}
