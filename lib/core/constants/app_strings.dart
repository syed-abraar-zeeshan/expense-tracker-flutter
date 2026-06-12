class AppStrings {
  AppStrings._();

  // App
  static const appName = 'Expense Flow';

  // Auth
  static const login = 'Login';
  static const register = 'Register';
  static const email = 'Email';
  static const password = 'Password';
  static const confirmPassword = 'Confirm Password';
  static const forgotPassword = 'Forgot Password?';
  static const resetPassword = 'Reset Password';
  static const newPassword = 'New Password';
  static const confirmNewPassword = 'Confirm New Password';
  static const enterNewPassword = 'Enter your new password';
  static const passwordResetSuccess = 'Password reset successfully!';
  static const sendResetLink = 'Send Reset Link';
  static const checkYourEmail = 'Check Your Email';
  static const backToLogin = 'Back to Login';
  static const resetLinkDescription = 'Enter your email address and we will send you a link to reset your password.';
  static const resetLinkSentTo = 'We have sent a password reset link to';
  static const dontHaveAccount = "Don't have an account?";
  static const fullName = 'Full Name';
  static const enterEmail = 'Enter your email';
  static const enterPassword = 'Enter your password';
  static const enterName = 'Enter your name';
  static const alreadyHaveAccount = 'Already have an account?';
  static const trackExpensesSmarter = 'Track your expenses smarter';
  static const createAccountToContinue = 'Create your account to continue';
  static const requiredField = 'This field is required';
  static const emailRequired = 'Email is required';
  static const invalidEmail = 'Please enter a valid email address';
  static const passwordRequired = 'Password is required';
  static const passwordMinLength = 'Password must be at least 8 characters';
  static const passwordUppercase =
      'Password must contain at least one uppercase letter';
  static const passwordLowercase =
      'Password must contain at least one lowercase letter';
  static const passwordNumber = 'Password must contain at least one number';
  static const passwordSpecialCharacter =
      'Password must contain at least one special character';
  static const confirmPasswordRequired = 'Confirm Password is required';
  static const passwordMismatch = 'Passwords do not match';
  static const logout = 'Logout';

  // Expense
  static const addExpense = 'Add Expense';
  static const editExpense = 'Edit Expense';
  static const deleteExpense = 'Delete Expense';
  static const expenses = 'Expenses';

  // Dashboard
  static const dashboard = 'Dashboard';
  static const totalBalance = 'Total Balance';
  static const income = 'Income';
  static const expense = 'Expense';
  static const transactions = 'Transactions';
  static const recentTransactions = 'Recent Transactions';
  static const viewAll = 'View All';
  static const noTransactionsYet = 'No Transactions Yet';
  static const startTracking =
      'Start tracking your income\nand expenses to see them here.';
  static const addTransaction = 'Add Transaction';
  static const goodMorning = 'Good Morning';
  static String hello(String name) => 'Hello, $name 👋';

  // Profile
  static const profile = 'Profile';
  static const editProfile = 'Edit Profile';
  static const themeMode = 'Theme Mode';
  static const aboutApp = 'About App';
  static const guestUser = 'Guest User';
  static const guestEmail = 'guest@example.com';

  // Navigation
  static const home = 'Home';
  static const categories = 'Categories';

  // Generic
  static const loading = 'Loading...';
  static const retry = 'Retry';
  static const cancel = 'Cancel';
  static const save = 'Save';
  static const total = 'Total';
}
