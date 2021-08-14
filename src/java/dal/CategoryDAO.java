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
import model.Category;
import model.Product;

/**
 *
 * @author Admin
 */
public class CategoryDAO extends DBContext{
    public List<Category> getAllCategorys(){
        String sql="select * from Categories";
        List<Category> list = new ArrayList<>();
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery(); 
            while (rs.next()) {
                list.add(new Category(rs.getInt(1),
                        rs.getString(2),rs.getString(3)));
            }
            return list;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    //lay ten category
    public Category getCatByID(int id){
            String sql="select * from Categories where CategoryID=?";
            try{
                PreparedStatement st=con.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet rs=st.executeQuery();
                if(rs.next())
                    return new Category(rs.getInt(1),
                               rs.getString(2),
                               rs.getString(3));
            }catch(SQLException e){
                System.out.println(e);
            }        
            return null;
        }
}
