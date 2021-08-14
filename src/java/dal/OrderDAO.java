/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;

/**
 *
 * @author Admin
 */
public class OrderDAO extends DBContext{
    public List<Order> getOrder(String username){
        List<Order> list = new ArrayList();
        try {
            String sql = "select o.OrderID, p.Name, p.Price,o.OrderQuantity, o.TotalPrice\n"
                    + "  from Products p, [Orders] o\n"
                    + "  where p.ID = o.ProductID and o.Username = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
}
