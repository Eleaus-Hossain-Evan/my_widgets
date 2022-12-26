class KStrings {
  KStrings._();

  static const String appName = 'LMS';
  static const String token = 'token';
  static const String cacheBox = 'cacheBox';
  static const String user = 'user';
  static const String applications = 'applications';
  static const String tkSymbol = "\u{09F3}";

  //? Auth
  static const String loggedIn = 'Successfully logged in';
  static const String loggedOut = 'logged out';

  //? Login Screen
  static const String logIn = 'Log In';
  static const String enterLoginDetails =
      'Enter you login details to access you account';
  static const String loginWithFacebook = 'Log in with Facebook';
  static const String loginWithGoogle = 'Log in with Google';
  static const String yourEmail = 'Your Email';
  static const String yourPassword = 'Your Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String continueText = 'Continue';
  static const String rememberMe = 'Remember me!';
  static const String noAccount = 'Don\'t have an account?';
  static const String signUp = 'Sign Up';
  static const String browse = ' Browse as a guest';

  //? Sign Up Screen
  static const String signupTitle =
      'Enter your details to sign up into a new account';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String email = 'Email';
  static const String phoneNumber = 'Phone Number';
  static const String password = 'Password';
  static const String repeatPassword = 'Repeat Password';
  static const String passwordNotMatched =
      'Does not match with New Password field';
  static const String alreadyAccount = 'Already have an account?';

  //? Regex Experssions
  static const String phonePattern =
      r'^[0-9]{10}$'; //regex pattern for phone number

  static const String emailPattern =
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+'; //regex pattern for email

  static const String passwordPattern =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$'; //regex pattern for password

  //? Homne Screen

  //? Category Screen
  static const String noCourse = 'No course found';

  //? Cart Screen
  static const String cart = 'Cart';
  static const String enterCouponCode = 'Enter coupon code';
  static const String subtotal = 'Subtotal';
  static const String discount = 'Discount';
  static const String total = 'Total';
  static const String checkout = 'Checkout';
  static const String bdt = 'BDT';
  static const String apply = 'Apply';

  //? Course Details Screen
  static const String nameNotFound = 'Name not found';
  static const String instructor = 'Instructor';
  static const String noDescription = 'No description available';
  static const String courseDetails = 'Course Details';
  static const String noTitle = 'Title not found';
  static const String aboutCourse = 'About Course';
  static const String guestInstructor = 'Guest Instructor';
  static const String noName = 'No name found';
  static const String instructorReview = "Instructor Review";
  static const String downloadCertificate = 'Download Certificate';

  //? Instructor Details Screen
  static const String aboutMe = 'About Me';
  static const String noCourseAvailable = 'No course available';
  static const String totalStudents = 'Total Students';
  static const String totalReviews = 'Total Reviews';

  //? Courses Screen
  static String feedback = "Feedback";
  static String seeAllReviews = 'See all Reviews';
  static String giveFeedback = "Give Feedback";
  static String editFeedback = "Edit Feedback";
  static String averageRating = "Average Rating";
  static String giveAFeedback = "Give A FeedBack";
  static String giveInstructorFeedback = "Give Instructor FeedBack";
  static String feedbackSubmissionDescription =
      'Tap a star to set your rating. Add a comment below to complete the feedback.';
  static String submit = 'Submit';
  static String addComment = 'Add Comment';

  //? Profile Screen
  static const String profile = 'Profile';
  static const String viewCertificates = 'View All Certificates';
  static const String viewCourses = 'View All Courses';
  static const String favoriteCourses = 'Favorite Courses';
  static const String editProfile = 'Edit Profile';
  static const String purchaseHistory = 'Purchase History';
  static const String refundHistory = 'Refund History';
  static const String changePassword = 'Change Password';
  static const String darkMode = 'Dark Mode';
  static const String privacy = 'Privacy';
  static const String help = 'Help & Support';
  static const String logout = 'Logout';

  //? Change Password Screen
  static const String currentPassword = 'Current Password';
  static const String newPassword = 'New Password';
  static const String reTypeNewPassword = 'Retype-New Password';
  static const String notSame = 'New password can\'t be same as old password';
  static const String chooseImageSource = 'Choose Image Source';
  static const String fromCamera = 'Camera';
  static const String fromGallery = 'Gallery';

  //?Purchase History
  static const String promo = 'Promo: ';

  //? My Courses Screen
  static const String myCourses = 'My Courses';

  //? Favorite Courses
  static const String noFavorite =
      'You haven\'t added any course to your favorite list ';
}
