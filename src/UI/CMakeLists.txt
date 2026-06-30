add_subdirectory(AppSettings)
add_subdirectory(toolbar)

qt_add_library(MainWindowModule STATIC)

qt_add_qml_module(MainWindowModule
    URI QGroundControl.MainWindow
    VERSION 1.0
    RESOURCE_PREFIX /qml
    QML_FILES
        MainWindow.qml
        Login/LoginPage.qml
    NO_PLUGIN
    QML_FILES Dashboard/AdminDashboard.qml
    QML_FILES Dashboard/operatorDashboard.qml
    QML_FILES Users/CreateUserDialog.qml
    QML_FILES Users/UserTable.qml
    QML_FILES GroundControl/GroundControlPage.qml
    QML_FILES UserManagement.qml
    QML_FILES Users/UserManagementPage.qml
    QML_FILES Users/CreateUserPage.qml
)