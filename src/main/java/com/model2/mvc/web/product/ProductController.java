package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

//==> 상품관리 Controller
@Controller
public class ProductController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음

	public ProductController() {
		System.out.println(this.getClass());
	}

	// ==> classpath:config/common.properties , classpath:config/commonservice.xml
	// 참조 할것
	// ==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	@RequestMapping("/addProduct.do")
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/addProduct.do");

		String manuDate = product.getManuDate();
		String replaceManuDate = manuDate.replace("-", "");

		product.setManuDate(replaceManuDate);

		// Business Logic
		productService.addProduct(product);

		return "forward:/product/getProduct.jsp";
	}

	@RequestMapping("/getProduct.do")
	public String getProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, Model model) throws Exception {

		System.out.println("/getProduct.do");
	
		// Business Logic
		Product product = productService.getProduct(prodNo);

		// Model 과 View 연결		
		model.addAttribute("product", product);
		
		if (menu.equals("manage")) {
			return "redirect:/updateProductView.do?prodNo=" + prodNo + "&menu=" + menu;
		} else {
			
			return "forward:/product/getProductDetail.jsp";
		}
	}

	
	
	@RequestMapping("/updateProductView.do")
	public String updateProductView(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, Model model) throws Exception{
		
		System.out.println("/updateProductView.do");
	
		// Business Logic
		Product product = productService.getProduct(prodNo);

		// Model 과 View 연결		
		model.addAttribute("product", product);
	
		return "forward:/product/updateProduct.jsp?menu=" + menu;
			
	}
	
	@RequestMapping("/updateProduct.do")
	public String updateProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, @ModelAttribute("product") Product product) throws Exception{
		
		System.out.println("/updateProduct.do");
	
		product.setProdNo(prodNo);
		productService.updateProduct(product);
		
		return "redirect:/getProduct.do?prodNo=" + prodNo + "&menu=yes";
			
	}
	
	@RequestMapping("/listProduct.do")
	public String listProduct(@ModelAttribute("search") Search search, Model model, HttpServletRequest request)
			throws Exception {

		System.out.println("/listProduct.do");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,	pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/product/listProduct.jsp";
	}
}