package bankapp.gui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TransferFrame extends JFrame {

    public TransferFrame() {
        setTitle("Transfer Options");
        setSize(300, 200); // 可根据需要调整尺寸
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null); // 居中显示

        initializeUI();
    }

    private void initializeUI() {
        setLayout(new BorderLayout(10, 10));

        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new BoxLayout(buttonPanel, BoxLayout.Y_AXIS));
        buttonPanel.setBorder(BorderFactory.createEmptyBorder(10, 30, 10, 30)); // 设置边缘空白

        // 创建按钮
        JButton btnTransferToSelf = new JButton("Transfer to yourself");
        btnTransferToSelf.setAlignmentX(Component.CENTER_ALIGNMENT);
        btnTransferToSelf.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                openTransferToSelfWindows();
            }
        });

        JButton btnTransferToOther = new JButton("Transfer to other");
        btnTransferToOther.setAlignmentX(Component.CENTER_ALIGNMENT);
        btnTransferToOther.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                openTransferToOtherWindow();
            }
        });

        JButton btnBack = new JButton("Back");
        btnBack.setAlignmentX(Component.CENTER_ALIGNMENT);
        btnBack.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                TransferFrame.this.dispose(); // 关闭当前窗口
            }
        });

        // 添加按钮到面板
        buttonPanel.add(btnTransferToSelf);
        buttonPanel.add(Box.createRigidArea(new Dimension(0, 10))); // 添加按钮间隙
        buttonPanel.add(btnTransferToOther);
        buttonPanel.add(Box.createRigidArea(new Dimension(0, 10))); // 添加按钮间隙
        buttonPanel.add(btnBack);

        add(buttonPanel, BorderLayout.CENTER);
    }

    private void openTransferToOtherWindow() {
        TransferToOtherFrame transferToOtherFrame = new TransferToOtherFrame();
        transferToOtherFrame.setVisible(true);
    }

    private void openTransferToSelfWindows() {
        TransferToSelfFrame transferToSelfFrame = new TransferToSelfFrame();
        transferToSelfFrame.setVisible(true);
    }
}
