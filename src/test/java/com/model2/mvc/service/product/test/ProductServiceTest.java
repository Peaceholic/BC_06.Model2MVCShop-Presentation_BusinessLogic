package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;


/*
 *	FileName :  UserServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })

public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Test
	public void testAddProduct() throws Exception {
		
		Product product = new Product();
		product.setProdName("oName");
		product.setProdDetail("oDetail");
		product.setManuDate("20150103");
		product.setPrice(123);
		product.setFileName("oFile");
		
		productService.addProduct(product);
		
		product = productService.getProduct(10014);
	
		//==> console 확인
		System.out.println("add : " +product);
		
		//==> API 확인
		Assert.assertEquals("oName", product.getProdName());
		Assert.assertEquals("oDetail", product.getProdDetail());
		Assert.assertEquals("20150101", product.getManuDate());
		Assert.assertEquals(123, product.getPrice());
		Assert.assertEquals("oFile", product.getFileName());
	}
	
	@Test
	public void testGetProduct() throws Exception {
		
		Product product = new Product();
			
		product = productService.getProduct(10010);
		
		System.out.println("get : " +product);
		
		Assert.assertEquals("oName", product.getProdName());
		Assert.assertEquals("oDetail", product.getProdDetail());
		Assert.assertEquals("20150101", product.getManuDate());
		Assert.assertEquals(123, product.getPrice());
		Assert.assertEquals("oFile", product.getFileName());
	}
	
	@Test
	public void testUpdateProduct() throws Exception {
		
		Product product = new Product();
		product.setProdNo(10008);
		product.setProdName("uName");
		product.setProdDetail("uDetail");
		product.setManuDate("20000101");
		product.setPrice(1234);
		product.setFileName("uFile");
		
		productService.updateProduct(product);
		
		product = productService.getProduct(10008);		
		
		Assert.assertEquals("uName", product.getProdName());
		Assert.assertEquals("uDetail", product.getProdDetail());
		Assert.assertEquals("20000101", product.getManuDate());
		Assert.assertEquals(1234, product.getPrice());
		Assert.assertEquals("uFile", product.getFileName());

	}
	
	@Test
	public void testGetProductList() throws Exception {
		
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(20);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("pName");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	}	
}













