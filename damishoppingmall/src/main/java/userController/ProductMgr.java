package userController;



import java.sql.Connection;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;

import javax.sql.DataSource;



import com.oreilly.servlet.MultipartRequest;

import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class ProductMgr {

	private Connection conn;

	private PreparedStatement pstmt;

	private ResultSet rs;

	private DataSource ds;

	

	

	public ProductMgr() {

		try {

		 Context context = new InitialContext();

			ds = (DataSource)context.lookup("java:comp/env/jdbc/system");

			

		} catch (Exception e) {

			System.out.println("ProductMgr err : " + e);

		}

	}

	

	public ArrayList<Product> getProductAll(){

		ArrayList<Product> list = new ArrayList<>();

		try {

			conn = ds.getConnection();

			String sql = "select * from shop_product order by no desc;";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while(rs.next()) {

			Product bean = new Product();


			bean.setName(rs.getString("name"));

			bean.setPrice(rs.getString("price"));

			bean.setImg(rs.getString("img"));

			list.add(bean);				

			}

		} catch (Exception e) {

			System.out.println("Product err:" + e);

		}finally {

			try {

				if(rs != null) rs.close();

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e2) {

				// TODO: handle exception

			}	

		}

		return list;

	}

	

	public boolean insertProduct(HttpServletRequest request) {

		boolean b = false;

		try {

			//���ε��� �̹��� ���(���� ���)

			String uploadDir ="C:/dami/webserver/products";

			//MultipartRequest multi=new MultipartRequest(request, savePath, sizeLimit, new DefaultFileRenamePolicy());

			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());

			conn = ds.getConnection();

			String sql = "insert into shop_product(name, price, detail, sdate, stock, image) values(?,?,?,?,?,?)"; //now�� sdate(����) �ǹ�

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1,  multi.getParameter("name"));

			pstmt.setString(2,  multi.getParameter("price"));


			if(multi.getFilesystemName("img") == null) {

				//�Ż�ǰ �̹����� ������ �ʾ��� ��� ����Ʈ �̹��� ����

				pstmt.setString(6, "../img/ready.gif");

			}else {

				pstmt.setString(5,  multi.getFilesystemName("img"));

			}			

			if(pstmt.executeUpdate() > 0) b = true;

			

		} catch (Exception e) {

			System.out.println("insertProduct err:" + e);

		}finally {

			try {

				if(rs != null) rs.close();

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e2) {

				// TODO: handle exception

			}	

		}

		return b;

	}

	

	public Product getProduct(String no) {

		Product bean = null;

		try {

			conn = ds.getConnection();

			String sql = "select * from shop_product where img=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, no);

			rs = pstmt.executeQuery();

			if(rs.next()) {

				bean = new Product();

				bean.setName(rs.getString("name"));

				bean.setPrice(rs.getString("price"));

				bean.setImg(rs.getString("img"));

			}		

		} catch (Exception e) {

			System.out.println("getProduct err:" + e);

		}finally {

			try {

				if(rs != null) rs.close();

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e2) {

				// TODO: handle exception

			}	

		}

		return bean;

	}

	public boolean updateProduct(HttpServletRequest request) {

		boolean b = false;

		try {

			String uploadDir ="C:/dami/webserver/products";

			//MultipartRequest multi=new MultipartRequest(request, savePath, sizeLimit, new DefaultFileRenamePolicy());

			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());

			

			conn = ds.getConnection();

			

			if(multi.getFilesystemName("image") == null) {

				String sql ="update shop_product set name=?, price=? where img=?";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1,multi.getParameter("name"));

				pstmt.setString(2,multi.getParameter("price"));

				pstmt.setString(3,multi.getParameter("img"));

				

			}else {

				String sql ="update shop_product set name=?, price=? where img=?";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1,multi.getParameter("name"));

				pstmt.setString(2,multi.getParameter("price"));

				pstmt.setString(5,multi.getFilesystemName("image"));

			}

			if(pstmt.executeUpdate() > 0 ) b = true;			

		} catch (Exception e) {

			System.out.println("updateProduct err:" + e);

		}finally {

			try {

				if(rs != null) rs.close();

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e2) {

				// TODO: handle exception

			}	

		}

	

	return b;

}

}