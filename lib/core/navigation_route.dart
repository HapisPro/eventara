enum NavigationRoute {
  mainRoute("/"),
  welcomeRoute("/welcome"),
  loginRoute("/login"),
  registerRoute("/register"),
  detailRoute("/detail"),
  profileRoute("/profile"),
  bookmarkRoute("/bookmark"),
  addEventRoute("/add_event"),
  chatbotRoute("/chatbot");

  final String path;
  const NavigationRoute(this.path);
}
