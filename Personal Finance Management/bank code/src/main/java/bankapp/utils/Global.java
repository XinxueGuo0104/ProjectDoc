package bankapp.utils;

public class Global {
    private static Double cashBalance = 0.0;
    private static Double financeBalance = 0.0;
    private static String currentUser = "";

    public static Double getCashBalance() {
        return cashBalance;
    }

    public static void setCashBalance(Double cashBalance) {
        Global.cashBalance = cashBalance;
    }

    public static Double getFinanceBalance() {
        return financeBalance;
    }

    public static void setFinanceBalance(Double financeBalance) {
        Global.financeBalance = financeBalance;
    }

    public static String getCurrentUser() {
        return currentUser;
    }

    public static void setCurrentUser(String currentUser) {
        Global.currentUser = currentUser;
    }
}
