package bankapp.database;

import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import bankapp.utils.Global;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseHelper {

    private static final HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:sqlite:./src/main/resources/db/database.db");
        config.setDriverClassName("org.sqlite.JDBC");
        config.setMaximumPoolSize(10); // 可根据需要调整连接池大小
        dataSource = new HikariDataSource(config);

        // 初始化数据库和表
        initializeDatabase();
    }

    private static void initializeDatabase() {
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            // 检查并创建表
            stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "username TEXT NOT NULL UNIQUE, " +
                    "password TEXT NOT NULL, " +
                    "salt TEXT NOT NULL);"
            );
            stmt.execute("CREATE TABLE IF NOT EXISTS accounts (" +
                    "    id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "    username TEXT NOT NULL UNIQUE," +
                    "    cash_balance REAL DEFAULT 0," +
                    "    finance_balance REAL DEFAULT 0);"
            );
            stmt.execute("CREATE TABLE IF NOT EXISTS transactions (" +
                    "    id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "    from_user TEXT NOT NULL," +
                    "    to_user TEXT NOT NULL," +
                    "    amount REAL NOT NULL," +
                    "    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                    "    transaction_type TEXT NOT NULL);"
            );
        } catch (SQLException e) {
            throw new RuntimeException("Database initialization failed", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void closePool() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }

    public static boolean validateUser(String username, String password) {
        String query = "SELECT password, salt FROM users WHERE username = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String salt = rs.getString("salt");
                String hashedPassword = hashPassword(password, Base64.getDecoder().decode(salt));

                return storedPassword.equals(hashedPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    private static String hashPassword(String password, byte[] salt) {
        try {
            // Optionally add a pepper
            String pepper = "e$B>72'z%@gCv3x^5Jk9!p#";
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest((password + pepper).getBytes());
            return Base64.getEncoder().encodeToString(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }


    public static boolean createUser(String username, String password) {
        // Generate a new, random salt for this user
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        String encodedSalt = Base64.getEncoder().encodeToString(salt);

        String hashedPassword = hashPassword(password, salt);

        Connection conn = null;
        PreparedStatement pstmt = null;
        String insertQuery;
        try {
            conn = getConnection();
            conn.setAutoCommit(false); // 开启事务
            insertQuery = "INSERT INTO users (username, password, salt) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, username);
            pstmt.setString(2, hashedPassword);
            pstmt.setString(3, encodedSalt);
            pstmt.executeUpdate();

            // Create account for user
            insertQuery = "INSERT INTO accounts (username, cash_balance, finance_balance) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, username);
            pstmt.setDouble(2, 200.0);
            pstmt.setDouble(3, 0.0);
            pstmt.executeUpdate();

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // 出错时回滚事务
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // 恢复默认的提交模式
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static double[] getUserBalances(String username) {
        String query = "SELECT cash_balance, finance_balance FROM accounts WHERE username = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                double cashBalance = rs.getDouble("cash_balance");
                double financeBalance = rs.getDouble("finance_balance");
                return new double[]{cashBalance, financeBalance};
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new double[]{0, 0};
    }

    public static boolean transferAmount(String fromUser, String toUser, double amount) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false); // 开启事务

            // 检查 toUser 是否存在
            pstmt = conn.prepareStatement("SELECT COUNT(*) FROM accounts WHERE username = ?");
            pstmt.setString(1, toUser);
            rs = pstmt.executeQuery();
            if (!rs.next() || rs.getInt(1) == 0) {
                conn.rollback(); // 不存在 toUser，回滚事务
                return false; // toUser 不存在
            }

            // 查询 fromUser 的余额
            pstmt = conn.prepareStatement("SELECT cash_balance, finance_balance FROM accounts WHERE username = ?");
            pstmt.setString(1, fromUser);
            rs = pstmt.executeQuery();

            if (!rs.next()) {
                conn.rollback(); // 回滚事务
                return false; // fromUser 不存在
            }

            double fromUserCashBalance = rs.getDouble("cash_balance");
            double fromUserFinanceBalance = rs.getDouble("finance_balance");

            if (fromUserCashBalance + fromUserFinanceBalance < amount) {
                conn.rollback(); // 余额不足，回滚事务
                return false; // 余额不足
            }

            // 计算新的余额
            double newCashBalance = fromUserCashBalance;
            double newFinanceBalance = fromUserFinanceBalance;
            if (newCashBalance >= amount) {
                newCashBalance -= amount;
            } else {
                amount -= newCashBalance;
                newCashBalance = 0;
                newFinanceBalance -= amount;
            }

            // 更新 fromUser 的余额
            pstmt = conn.prepareStatement("UPDATE accounts SET cash_balance = ?, finance_balance = ? WHERE username = ?");
            pstmt.setDouble(1, newCashBalance);
            pstmt.setDouble(2, newFinanceBalance);
            pstmt.setString(3, fromUser);
            pstmt.executeUpdate();

            // 增加 toUser 的现金余额
            pstmt = conn.prepareStatement("UPDATE accounts SET cash_balance = cash_balance + ? WHERE username = ?");
            pstmt.setDouble(1, amount);
            pstmt.setString(2, toUser);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("INSERT INTO transactions (from_user, to_user, amount, transaction_type) VALUES (?, ?, ?, ?)");
            pstmt.setString(1, fromUser);
            pstmt.setString(2, toUser); // from_user 和 to_user 都是同一个用户，因为是给自己转账
            pstmt.setDouble(3, amount);
            pstmt.setString(4, "TRANSFER");
            pstmt.executeUpdate();

            conn.commit(); // 提交事务

            Global.setCashBalance(newCashBalance);
            Global.setFinanceBalance(newFinanceBalance);

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // 出错时回滚事务
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // 恢复默认的提交模式
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static boolean updateUserBalances(
            String username, double newCashBalance, double newFinanceBalance,
            double initialCashBalance, double initialFinanceBalance) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false); // 开启事务

            // 计算资金的流向
            double cashDifference = initialCashBalance - newCashBalance;
            double financeDifference = initialFinanceBalance - newFinanceBalance;

            // 更新用户余额
            pstmt = conn.prepareStatement("UPDATE accounts SET cash_balance = ?, finance_balance = ? WHERE username = ?");
            pstmt.setDouble(1, newCashBalance);
            pstmt.setDouble(2, newFinanceBalance);
            pstmt.setString(3, username);
            pstmt.executeUpdate();

            // 插入交易记录
            String transactionType = (cashDifference > 0) ? "INVESTMENT" : "WITHDRAWAL";
            double transactionAmount = Math.abs(cashDifference > 0 ? cashDifference : financeDifference);

            pstmt = conn.prepareStatement("INSERT INTO transactions (from_user, to_user, amount, transaction_type) VALUES (?, ?, ?, ?)");
            pstmt.setString(1, username);
            pstmt.setString(2, username); // from_user 和 to_user 都是同一个用户，因为是给自己转账
            pstmt.setDouble(3, transactionAmount);
            pstmt.setString(4, transactionType);
            pstmt.executeUpdate();

            Global.setCashBalance(newCashBalance);
            Global.setFinanceBalance(newFinanceBalance);

            conn.commit(); // 提交事务
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // 出错时回滚事务
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // 恢复默认的提交模式
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


}
