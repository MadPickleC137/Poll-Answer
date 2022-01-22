class RouterApi {
  static const String rootUrl = "http://192.168.0.121:7014/";

  static const String getCategoriesUrl = "Category/GetCategories"; //GET
  static const String loginUrl = "Main/Login"; //POST
  static const String addQuestionUrl = "api/Question/AddQuestion"; //POST
  static const String updateQuestionUrl = "api/Question/UpdateQuestion"; //PUT
  static const String deleteQuestionUrl =
      "api/Question/DeleteQuestion"; //DELETE
  static const String closeQuestionUrl = "api/Question/CloseQuestion"; //PUT

  static const String getAllQuestions = "api/Question/GetAllQuestions"; //GET
  static const String getBundleQuestions =
      "api/Question/GetQuestionBundle"; //GET
  static const String getUserQuestions = "api/Question/GetUserQuestions"; //GET
  static const String getInfoQuestions = "api/Question/GetQuestionInfo"; //GET
  static const String putVote = "api/Question/Vote"; //PUT

}
