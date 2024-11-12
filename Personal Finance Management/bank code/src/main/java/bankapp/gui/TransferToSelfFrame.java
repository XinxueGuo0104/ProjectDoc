package bankapp.gui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import bankapp.database.DatabaseHelper;
import bankapp.utils.Global;

public class TransferToSelfFrame extends JFrame {

    private JTextField txtCashBalance;
    private JTextField txtFinanceBalance;
    private JLabel lblTotalAfterOneMonth;
    private JLabel lblTotalAfterHalfYear;
    private JLabel lblTotalAfterOneYear;

    public TransferToSelfFrame() {
        setTitle("Transfer to Myself");
        setSize(400, 300); // 可根据需要调整尺寸
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null); // 居中显示

        initializeUI();
    }

    private void initializeUI() {
        setLayout(new BorderLayout(10, 10));

        // 输入面板
        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new GridLayout(2, 2, 10, 10));
        inputPanel.setBorder(BorderFactory.createEmptyBorder(10, 30, 10, 30)); // 设置边缘空白

        inputPanel.add(new JLabel("Current Cash:"));
        txtCashBalance = new JTextField(String.valueOf(Global.getCashBalance()));
        inputPanel.add(txtCashBalance);

        inputPanel.add(new JLabel("Current Finance:"));
        txtFinanceBalance = new JTextField(String.valueOf(Global.getFinanceBalance()));
        inputPanel.add(txtFinanceBalance);

        add(inputPanel, BorderLayout.NORTH);

        // 预测面板
        JPanel forecastPanel = new JPanel();
        forecastPanel.setLayout(new GridLayout(3, 1, 10, 10));
        lblTotalAfterOneMonth = new JLabel("Total after one month:");
        lblTotalAfterHalfYear = new JLabel("Total after half year:");
        lblTotalAfterOneYear = new JLabel("Total after one year:");
        forecastPanel.add(lblTotalAfterOneMonth);
        forecastPanel.add(lblTotalAfterHalfYear);
        forecastPanel.add(lblTotalAfterOneYear);

        add(forecastPanel, BorderLayout.CENTER);

        // 按钮面板
        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 10, 10));

        JButton btnBack = new JButton("Back");
        btnBack.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                TransferToSelfFrame.this.dispose(); // 关闭当前窗口
            }
        });
        buttonPanel.add(btnBack);

        JButton btnSave = new JButton("Save");
        btnSave.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                saveChanges();
            }
        });
        buttonPanel.add(btnSave);

        add(buttonPanel, BorderLayout.SOUTH);

        updateForecastLabels(Global.getCashBalance(), Global.getFinanceBalance());
    }

    private void saveChanges() {
        try {
            double newCashBalance = Double.parseDouble(txtCashBalance.getText().trim());
            double newFinanceBalance = Double.parseDouble(txtFinanceBalance.getText().trim());

            double totalBalance = Global.getCashBalance() + Global.getFinanceBalance();
            double newTotalBalance = newCashBalance + newFinanceBalance;

            // 检查总金额是否相同
            if (Math.abs(totalBalance - newTotalBalance) > 0.01) { // 允许一定的浮点误差
                JOptionPane.showMessageDialog(this, "Total balance must remain the same.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // 更新数据库
            boolean success = DatabaseHelper.updateUserBalances(Global.getCurrentUser(), newCashBalance, newFinanceBalance, Global.getCashBalance(), Global.getFinanceBalance());
            if (!success) {
                JOptionPane.showMessageDialog(this, "Failed to update balances.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // 更新预测标签
            updateForecastLabels(newCashBalance, newFinanceBalance);

            JOptionPane.showMessageDialog(this, "Changes saved successfully.");
//            this.dispose(); // 关闭当前窗口
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "Invalid number format.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void updateForecastLabels(double cashBalance, double financeBalance) {
        lblTotalAfterOneMonth.setText("Total after one month: " + calculateFutureBalance(cashBalance, financeBalance, 1.0 / 12));
        lblTotalAfterHalfYear.setText("Total after half year: " + calculateFutureBalance(cashBalance, financeBalance, 0.5));
        lblTotalAfterOneYear.setText("Total after one year: " + calculateFutureBalance(cashBalance, financeBalance, 1));
    }

    private double calculateFutureBalance(double cashBalance, double financeBalance, double years) {
        double annualInterestRate = 0.02; // 年化收益 2%
        return cashBalance + financeBalance * Math.pow(1 + annualInterestRate, years);
    }
}
