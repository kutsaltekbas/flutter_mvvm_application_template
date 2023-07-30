# Welcome to Flutter Application Template
  * This template uses state management techniques like MobX and Provider. It uses MVVM (Model-View-Viewmodel) structure to keep everything organized while seperating      business logic from UI components. It contains basic screens that most applications has like splash, on board and login. It also provides a base to change the            language and theme of the app.
  ## To initialize the app for your needs, please do the following:
   * Load images into assets folder and replace placeholder widgets inside some pages with commented images.
   * Adjust the base, dev and local URLs inside vexana manager to make your services work.
   * Modify the app_theme_light file to adjust colors, fonts etc. according to your needs.
   * You can use service helper without any issue if all of your service responses are in a format given below:
      ```   
      {
        message: String,
        type: bool,
        data: dynamic,
      }
   * To use service helper correctly field names must be same in the model above. If not correct it on backend side or change variable names in service helper.
   * Modify the service_helper file to manage headers of your services.
   * You can modifiy on board screen contents from language files under assets/languages.
   * If you want to add a new page, please make sure that the page is involved in navigation_route file and if generated file throws an error, just make sure that all pages are included in the file are imported.

