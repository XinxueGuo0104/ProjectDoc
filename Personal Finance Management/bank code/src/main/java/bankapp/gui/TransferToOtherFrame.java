package bankapp.gui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import bankapp.database.DatabaseHelper;
import bankapp.utils.Global;


public class TransferToOtherFrame extends JFrame {

    private JTextField txtTo;
    private JTextField txtAmount;

    public TransferToOtherFrame() {
        setTitle("Transfer to Other");
        setSize(300, 200); // 可根据需要调整尺寸
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

        inputPanel.add(new JLabel("TO:"));
        txtTo = new JTextField();
        inputPanel.add(txtTo);

        inputPanel.add(new JLabel("Amount:"));
        txtAmount = new JTextField();
        inputPanel.add(txtAmount);

        add(inputPanel, BorderLayout.CENTER);

        // 按钮面板
        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 10, 10));

        JButton btnBack = new JButton("Back");
        btnBack.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                TransferToOtherFrame.this.dispose(); // 关闭当前窗口
            }
        });
        buttonPanel.add(btnBack);

        JButton btnSave = new JButton("Save");
        btnSave.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                saveTransfer();
            }
        });
        buttonPanel.add(btnSave);

        add(buttonPanel, BorderLayout.SOUTH);
    }

    private void saveTransfer() {
        String toUser = txtTo.getText().trim();
        String amountStr = txtAmount.getText().trim();

        try {
            double amount = Double.parseDouble(amountStr);
            if (amount <= 0) {
                JOptionPane.showMessageDialog(this, "Amount must be positive.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            boolean success = DatabaseHelper.transferAmount(Global.getCurrentUser(), toUser, amount);
            if (success) {
                JOptionPane.showMessageDialog(this, "Transfer successful.");
                this.dispose(); // 关闭当前窗口
            } else {
                JOptionPane.showMessageDialog(this, "Transfer failed.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "Invalid amount.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

}
