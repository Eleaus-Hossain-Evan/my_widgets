// ignore_for_file: constant_identifier_names

class APIRoute {
  //:<<=================== GENERAL =======================>>
  static const String DUMMY_PERSON = 'https://i.pravatar.cc/300';
  static const String DEFAULT_IMAGE =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
  static const String DEFAULT_WORKING_IMAGE =
      'https://images.pexels.com/photos/4012966/pexels-photo-4012966.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  static const String WEB_URL = "";

  static const String BASE_URL = "https://api-lms.b2gsoft.xyz/";
  static const String BASE_URL_LOCAL = "http://192.168.68.121:5170/";
  static const String API_V1 = "api/v1/";

  //:<<=================== Auth =======================>>
  static const String SIGNUP = "${API_V1}student/signup";
  static const String SEND_SIGNUP_OTP = "${API_V1}customer/sms";
  static const String LIGNIN = "${API_V1}student/login";
  static const String CHANGE_PASSWORD =
      "${API_V1}student/student-password-update";
  static const String PROFILE_PICTIURE_UPDATE =
      "${API_V1}student/student-profile-picture-update";

  //#<<=================== LMS =======================>>
  static const String HOME = "${API_V1}home";
  static const String SINGLE_COURSE = "${API_V1}course/course-info/";
  static const String ALL_CATEGORIES =
      "${API_V1}category/fetch-cat-with-subCat";
  static const String COURSE_BY_CATEGORY =
      "${API_V1}course/sub-category?subId=";
  static const String ALL_SUBCATEGORIES = "${API_V1}sub-category/fetch-all";

  //'<<--------------------Search--------------------->>
  static const String SEARCH_SUGGESTION =
      "${API_V1}search/course-search-suggestion?suggestion=";
  static const String SEARCH_COURSE = "${API_V1}search/course-search?search=";

  //'<<------------------instructor-------------------->>
  static const String INSTRUCTOR =
      "${API_V1}instructor/fetch-single-instructor/";
  static const String INSTRUCTOR_COURSES = "${API_V1}course/instructor?";
  static const String ALL_APPROVED_INSTRUCTORS = "${API_V1}instructor/approve?";
  static const String FEATURED_INSTRUCTORS =
      "${API_V1}instructor/featured-instructors?";

  //'<<-----------------course review------------------>>
  static const String REVIEW_SUBMIT = "${API_V1}course-review/submit/";
  static const String REVIEW_UPDATE =
      "${API_V1}course-review/submit-updated-review/";
  static const String COURSE_RATING_CHART =
      "${API_V1}course-review/course-rating-chart/";
  static const String COURSE_REVIEW =
      "${API_V1}course-review/fetch-approved-review/";
  static const String COURSE_PREVIOUSLY_SUBMITTED_REVIEW =
      "${API_V1}course-review/previousReview/";

  static const String INSTRUCTOR_REVIEW_SUBMIT =
      "${API_V1}instructor-review/submit/";
  static const String INSTRUCTOR_REVIEW_UPDATE =
      "${API_V1}instructor-review/submit-updated-review/";
  static const String INSTRUCTOR_PREVIOUS_REVIEW =
      "${API_V1}instructor-review/previous-review/";
  static const String DOWNLOAD_CERTIFICATE =
      "${API_V1}student/generate-certificate/";

  //'<<---------------------quiz------------------------>>
  static const String QUIZ_FETCH = "${API_V1}quiz/fetch/";
  static const String QUIZ_SUBMIT = "${API_V1}quiz/submit/";

  //'<<----------------student profile------------------>>
  static const String STUDENT_PROFILE = "${API_V1}student/student-profile";
  static const String UPDATE_PROFILE =
      "${API_V1}student/student-profile-update";
  static const String MY_COURSES = "${API_V1}student/enrolled-courses?";
  static const String FAVORITE_COURSES = "${API_V1}student/favorite-courses?";
  static const String UPDATE_FAVORITE_COURSE =
      "${API_V1}student/update-favorite-courses/";

  //'<<--------------------purchase-------------------->>
  static const String PURCHASE_HISTORY = "${API_V1}purchase/student-history";
  static const String PROMO_CHECK = "${API_V1}promoCode/promoCheck/";
  static const String PURCHASE_COURSE = "${API_V1}purchase/create";

  //* <<=================== Cart =======================>>
  static const String FETCH_CART = "${API_V1}student/fetch-cart";
  static const String ADD_TO_CART = "${API_V1}student/add-to-cart";
  static const String REMOVE_FROM_CART = "${API_V1}student/remove-from-cart/";

  //'<<--------------------refund-------------------->>
  static const String REFUND_REQ_STEP_1 =
      "${API_V1}course-refund/refund-request-step-1";
  static const String REFUND_REQ_STEP_2 =
      "${API_V1}course-refund/refund-request-step-2";
  static const String REFUND_REQ_HISTORY =
      "${API_V1}course-refund/fetch-refund-request";

  //*<<-------------------Refresh Token---------------------->>
  static const String REFRESH_TOKEN = "${API_V1}refresh-token/get";
}
