package bankapp.database;

import bankapp.database.DatabaseHelper;

public class DatabaseHelperTest {

    public static void main(String[] args) {
        // 测试用户名和密码
        String username = "testUser1";
        String password = "testPassword123";

        // 尝试创建用户
        System.out.println("Attempting to create user...");
        boolean createUserResult = DatabaseHelper.createUser(username, password);
        System.out.println("User creation result: " + createUserResult);

        // 尝试验证用户
        System.out.println("Attempting to validate user...");
        boolean validateUserResult = DatabaseHelper.validateUser(username, password);
        System.out.println("User validation result: " + validateUserResult);
    }
}