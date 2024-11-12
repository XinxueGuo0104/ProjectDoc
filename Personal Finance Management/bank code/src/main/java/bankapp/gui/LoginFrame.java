package bankapp.gui;

import bankapp.database.DatabaseHelper;
import bankapp.utils.Global;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class LoginFrame extends JFrame {

    private JTextField usernameField;
    private JPasswordField passwordField;

    public LoginFrame() {
        initializeUI();
    }

    private void initializeUI() {
        setTitle("Login - Bank Account System");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);  // 设置窗口居中显示

        setLayout(new GridBagLayout());
        GridBagConstraints constraints = new GridBagConstraints();
        constraints.fill = GridBagConstraints.HORIZONTAL;
        constraints.insets = new Insets(10, 10, 10, 10); // 外部填充

        // 添加用户名和密码字段
        addComponent(new JLabel("Username:"), constraints, 0, 0, 1);
        usernameField = new JTextField(20);
        addComponent(usernameField, constraints, 1, 0, 2);

        addComponent(new JLabel("Password:"), constraints, 0, 1, 1);
        passwordField = new JPasswordField(20);
        addComponent(passwordField, constraints, 1, 1, 2);

        // 添加登录按钮
        JButton loginButton = new JButton("Login");
        loginButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                performLogin();
            }
        });
        addComponent(loginButton, constraints, 0, 2, 1);

        // 添加注册按钮
        JButton registerButton = new JButton("Register");
        registerButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                performRegistration();
            }
        });
        addComponent(registerButton, constraints, 1, 2, 2);
    }

    private void performLogin() {
        String username = usernameField.getText();
        String password = new String(passwordField.getPassword());

        if (DatabaseHelper.validateUser(username, password)) {
            // 登录成功
            JOptionPane.showMessageDialog(this, "Login Successful!");
            // 关闭登录窗口
            this.dispose();
            // 打开主界面
            EventQueue.invokeLater(() -> {
                Global.setCurrentUser(username);
                MainFrame mainFrame = new MainFrame();
                mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                mainFrame.setVisible(true);
            });
        } else {
            // 登录失败
            JOptionPane.showMessageDialog(this, "Invalid username or password.", "Login Failed", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void performRegistration() {
        String username = usernameField.getText();
        String password = new String(passwordField.getPassword());

        if (DatabaseHelper.createUser(username, password)) {
            // 注册成功
            JOptionPane.showMessageDialog(this, "Registration Successful!");
        } else {
            // 注册失败
            JOptionPane.showMessageDialog(this, "Registration Failed. Username may already exist.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void addComponent(Component component, GridBagConstraints constraints, int x, int y, int width) {
        constraints.gridx = x;
        constraints.gridy = y;
        constraints.gridwidth = width;
        add(component, constraints);
    }
}
