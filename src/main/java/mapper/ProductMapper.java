package mapper;

import dto.ProductDTO;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductMapper implements RowMapper<ProductDTO> {

    @Override
    public ProductDTO map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new ProductDTO(rs.getInt("id"), rs.getString("name"), rs.getInt("saleQuantity"));
    }
}
