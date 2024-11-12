package bankapp.gui;

import bankapp.database.DatabaseHelper;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import bankapp.utils.Global;

public class MainFrame extends JFrame {


    public MainFrame() {
        setTitle("Bank Application - Main");
        setSize(400, 300); // 可根据需要调整尺寸
        initializeUI();
    }

    private void getBalance() {
        double[] balances = DatabaseHelper.getUserBalances(Global.getCurrentUser());
        Global.setCashBalance(balances[0]);
        Global.setFinanceBalance(balances[1]);
    }

    private void initializeUI() {
        setLayout(new BorderLayout(10, 10)); // 添加边框布局的间距

        getBalance();

        // 创建并设置余额面板
        JPanel balancePanel = new JPanel();
        balancePanel.setLayout(new BoxLayout(balancePanel, BoxLayout.Y_AXIS));
        balancePanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10)); // 添加边距

        JLabel cashBalanceLabel = createBalanceLabel("Cash Balance: $" + Global.getCashBalance());
        JLabel financeBalanceLabel = createBalanceLabel("Finance Balance: $" + Global.getFinanceBalance());

        // 设置字体大小
        cashBalanceLabel.setFont(new Font("Serif", Font.BOLD, 18));
        financeBalanceLabel.setFont(new Font("Serif", Font.BOLD, 18));

        balancePanel.add(cashBalanceLabel);
        balancePanel.add(financeBalanceLabel);
        add(balancePanel, BorderLayout.NORTH);

        // 创建并设置按钮面板
        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 30, 10)); // 使用流布局进行居中

        JButton transferButton = new JButton("Transfer");
        transferButton.setPreferredSize(new Dimension(120, 40)); // 设置按钮大小
        transferButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                openTransferWindow();
            }
        });

        JButton detailButton = new JButton("Detail");
        detailButton.setPreferredSize(new Dimension(120, 40)); // 设置按钮大小
        detailButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                openDetailWindow();
            }
        });

        buttonPanel.add(transferButton);
        buttonPanel.add(detailButton);

        add(buttonPanel, BorderLayout.CENTER);
    }


    private void openTransferWindow() {
        TransferFrame transferFrame = new TransferFrame();
        transferFrame.setVisible(true);
    }

    private void openDetailWindow() {
        FinanceDetailsFrame financeDetailsFrame = new FinanceDetailsFrame();
        financeDetailsFrame.setVisible(true);
    }

    private JLabel createBalanceLabel(String text) {
        JLabel label = new JLabel(text, SwingConstants.CENTER);
        label.setAlignmentX(Component.CENTER_ALIGNMENT);
        return label;
    }
}
