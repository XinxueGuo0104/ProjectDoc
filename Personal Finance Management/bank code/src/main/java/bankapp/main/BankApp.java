package bankapp.main;

import javax.swing.*;

import bankapp.gui.LoginFrame;
import bankapp.gui.MainFrame;

public class BankApp {

    public static void main(String[] args) {
        // 使用SwingUtilities.invokeLater来确保GUI更新在事件分派线程中执行
        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                // 创建并显示登录窗口
                createAndShowLoginGUI();
            }
        });
    }

    private static void createAndShowLoginGUI() {
        // 创建登录窗口实例
        LoginFrame loginFrame = new LoginFrame();

        // 设置窗口关闭操作
        loginFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // 显示窗口
        loginFrame.setVisible(true);
    }
}
