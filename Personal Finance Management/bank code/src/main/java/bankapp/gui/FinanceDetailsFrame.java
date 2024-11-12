package bankapp.gui;

import bankapp.database.DatabaseHelper;
import bankapp.utils.Global;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.*;

public class FinanceDetailsFrame extends JFrame {
    private JTable table;

    public FinanceDetailsFrame() {

        setTitle("Financial Details");
        setSize(600, 400); // 可根据需要调整尺寸
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null); // 居中显示

        initializeUI();
        loadTransactionData();
    }

    private void initializeUI() {
        setLayout(new BorderLayout());

        table = new JTable();
        JScrollPane scrollPane = new JScrollPane(table);
        add(scrollPane, BorderLayout.CENTER);
    }

    private void loadTransactionData() {
        DefaultTableModel model = new DefaultTableModel(new String[]{"ID", "From", "To", "Amount", "Date", "Type"}, 0);
        table.setModel(model);

        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT id, from_user, to_user, amount, transaction_date, transaction_type FROM transactions WHERE from_user = ? OR to_user = ?")) {

            pstmt.setString(1, Global.getCurrentUser());
            pstmt.setString(2, Global.getCurrentUser());

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    model.addRow(new Object[]{
                            rs.getInt("id"),
                            rs.getString("from_user"),
                            rs.getString("to_user"),
                            rs.getDouble("amount"),
                            rs.getTimestamp("transaction_date"),
                            rs.getString("transaction_type")
                    });
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading transaction data.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
