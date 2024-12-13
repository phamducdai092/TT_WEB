package mapper;

import bean.Bill;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BillMapper implements RowMapper<Bill> {

    @Override
    public Bill map(ResultSet rs, StatementContext ctx) throws SQLException {
        Bill bill = new Bill();
        bill.setId(rs.getInt("id"));
        bill.setUserId(rs.getInt("userId"));
        bill.setCreateDate(rs.getString("createDate"));
        bill.setTotalPrice(rs.getDouble("totalPrice"));
        bill.setPaymentMethod(rs.getString("payment_method"));
        bill.setFullName(rs.getString("full_name"));
        bill.setAddress(rs.getString("address"));
        bill.setPhone(rs.getString("phone"));
        bill.setStatus(rs.getString("status"));
        bill.setProductName(rs.getString("name"));
        bill.setQuantity(rs.getInt("quantity"));
        bill.setProductColor(rs.getString("product_color"));
        return bill;
    }
}
