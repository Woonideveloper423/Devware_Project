package com.oracle.devwareProject.controller.GH;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.devwareProject.domain.Authority;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.EmpList;
import com.oracle.devwareProject.domain.Page;
import com.oracle.devwareProject.domain.Position;
import com.oracle.devwareProject.domain.Status;
import com.oracle.devwareProject.service.GH.AuthorityService;
import com.oracle.devwareProject.service.GH.DeptService;
import com.oracle.devwareProject.service.GH.EmpService;
import com.oracle.devwareProject.service.GH.Paging;
import com.oracle.devwareProject.service.GH.PosService;
import com.oracle.devwareProject.service.GH.StatusService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EmpController 
{
	
	private final EmpService empService;
	private final DeptService deptService;
	private final AuthorityService authService;
	private final PosService posService;
	private final StatusService statusService;
	
	//암호화 하기 위한 객체 선언
	BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
	/*
	 * //루트 입력시 이동되는 페이지를 설정
	 * 
	 * @GetMapping("/") public String root() { return "/member/index"; }
	 */
	
	//관리자이니 일반 유저인지 확인하기 위한 메소드
	@GetMapping("/auth_finder")
	public String auth_finder(HttpSession session,Model model)
	{
		Emp emp = (Emp) session.getAttribute("emp"); //"로그인시" 세션을 설정해 놓은 값을 가져온다.
		
		EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch"); //JPA 외래키를 설정해 놓은 값을 받아오기 위해서 조회용 객체에 저장한 세션값을 가져온다.
		
		System.out.println(emp.getEmp_name()+"님은 "+empForSearch.getAuth_name()+" 입니다");
		
		//관리자 일 경우 
		if(empForSearch.getAuth_num() == 0)
		{
			model.addAttribute("emp",emp);
			model.addAttribute("empForSearch",empForSearch);
			return "/member/admin/adminMain";
		}
		//일반 유저 일 경우 
		else
		{	
			model.addAttribute("emp",emp);
			model.addAttribute("empForSearch",empForSearch);
			return "/member/user/userMain";
		}
	}
	
	//일반 유저 메인 페이지 정보를 보여주는 메소드 
	@RequestMapping("/userMyPageForm")
	public String myPageForm(HttpSession session,Model model)
	{
		Emp emp = (Emp) session.getAttribute("emp");
		System.out.println("EmpService myPageForm Start");
		
		System.out.println("Name : "+emp.getEmp_name());
		
		model.addAttribute(emp);
		return "/member/user/userMyPageForm";
	}
	
	//관리자 유저 메인 페이지 정보를 보여주는 메소드 
	@RequestMapping("/adminMyPageForm")
	public String AdminMyPageForm(HttpSession session,Model model)
	{
		System.out.println("EmpService adminMyPageForm Start");
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		
		List <Dept> deptlist = new ArrayList<Dept>();
		deptlist = deptService.getDeptInfo();
		
		List <Authority> authlist = new ArrayList<Authority>();
		authlist = authService.getAuthInfo();
		
		List <Position> poslist = new ArrayList<Position>();
		poslist = posService.getPosInfo();
		
		List <Status> statuslist = new ArrayList<Status>();
		statuslist = statusService.getStatusInfo();
		
		model.addAttribute("deptlist",deptlist);
		model.addAttribute("authlist",authlist);
		model.addAttribute("poslist",poslist);
		model.addAttribute("statuslist",statuslist);
		model.addAttribute("emp",emp);
		return "/member/admin/adminMyPageForm";
	}
	
	//로그아웃 
	@RequestMapping("/logoutForm")
	public String logout(HttpSession session)
	{
		session.invalidate();
		return "/member/logoutForm";
	}
	
	//회원 가입 뷰 출력
	@GetMapping("/signUpForm")
	public String signUp() {
		return "/member/signUpForm";
	}
	
	//로그인 뷰 출력
	@GetMapping("/loginForm")
	public String loginForm() {
		return "/member/loginForm";
	}
	
	//아이디, 비밀번호 찾기 뷰 출력
	@GetMapping("/findIdPwForm")
	public String findIdPwForm() {

		return "/member/findIdPwForm";
	}
	
	//아이디 찾기 메소드 [AJAX]
	@ResponseBody
	@RequestMapping("/findId")
	public Emp findId(@RequestParam int emp_num, @RequestParam String emp_name, @RequestParam String emp_email) 
	{
		System.out.println("EmpService login Start");
		Emp emp = new Emp();
		
		System.out.println("Parameter Test 1 Num : "+emp_num);
		System.out.println("Parameter Test 2 Name : "+emp_name);
		System.out.println("Parameter Test 3 Email: "+emp_email);
		
		try {
			emp = empService.getInfo(emp_num); //찾기를 원하는 아이디의 사번을 가져온다.
			System.out.println("쿼리문 실행 후 ");
			
			//찾으려는 사번에 해당하는 유저의 이름과 이메일 일치한 경우 
			if(emp_name.equals(emp.getEmp_name()) && emp_email.equals(emp.getEmp_email()))
			{
				System.out.println("정보가 모두 일치 되었습니다.");
				System.out.println("당신의 아이디는 " + emp.getEmp_id() + " 입니다.");
				emp.setMsg(emp.getEmp_name()+"의 아이디는 "+emp.getEmp_id()+" 입니다."); //결과 메시지에 저장한다.
				emp.setResult(1); //결과 값을 저장한다.
			} else { 
				System.out.println("정보가 일치하지 않습니다."); //찾으려는 사번에 해당하는 유저의 이름과 이메일 일치하지 않은 경우 
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return emp;
	}
	
	//비밀번호 찾기 메소드 [AJAX]
	@ResponseBody
	@RequestMapping("/findPw")
	public Emp findPw(@RequestParam int emp_num, @RequestParam String emp_name, @RequestParam String emp_id, @RequestParam String emp_email) 
	{
		System.out.println("EmpService login Start");
		Emp emp = new Emp();
		
		//파라미터 확인을 위한 로그
		System.out.println("Parameter Test 1 Num : "+ emp_num);
		System.out.println("Parameter Test 2 Name : "+ emp_name);
		System.out.println("Parameter Test 3 Email: "+ emp_email);
		System.out.println("Parameter Test 4 Id: "+ emp_id);
		
		try {
			//사번에 해당하는 유저 정보를 호출한다. 
			emp = empService.getInfo(emp_num);
			
			// 이름 & 이메일 & 아이디를 찾아온 사번에 유저 정보와 일치한 경우
			if(emp_name.equals(emp.getEmp_name()) && emp_email.equals(emp.getEmp_email()) && emp_id.equals(emp.getEmp_id()) )
			{
				System.out.println("정보가 모두 일치 되었습니다.");
				System.out.println("당신의 아이디는 " + emp.getEmp_id() + " 입니다.");
				emp.setMsg("비밀 번호를 수정합니다. <br><h5>비밀 번호를 입력해주세요</h5></br>"); //결과 메시지를 저장한다.
				emp.setResult(1); //결과 값을 저장한다.
			}
			else { // 일치하지 않은 경우
				System.out.println("정보가 일치하지 않습니다.");
				emp = new Emp();
				emp.setMsg("비밀번호 찾기에 실패하셨습니다.");
				emp.setResult(0);
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return emp;
	}
	
	//로그인 메소드 [AJAX]
	@ResponseBody
	@RequestMapping("/login")
	public Emp login(@RequestParam String emp_id, @RequestParam String emp_passwd, HttpServletRequest request) {
		System.out.println("EmpService login Start");
		
		Emp emp = new Emp();
		
		//현재 로그인을 요청한 Emp Id를 가져오기
		try {
			emp = empService.login(emp_id);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		// 위 단계에서 조회한 암호화된 데이터베이스에 존재하는 Emp의 비밀번호와 현재 로그인을 요청한 비밀번호와 비교 
		if(encoder.matches(emp_passwd,emp.getEmp_passwd()))
		{
			HttpSession session =request.getSession();	//세션에 저장하기 위한 객체를 생성
			System.out.println("로그인 성공");
			emp.setMsg(emp.getEmp_name()+"님 환영합니다.");
			emp.setAuth_num(emp.getAuth().getAuth_num());
			emp.setResult(1);
			
			//조회용 empForSearch에 값을 넣기
			EmpForSearch empForSearch = new EmpForSearch();
			empForSearch.setAuth_name(emp.getAuth().getAuth_name());
			empForSearch.setAuth_num(emp.getAuth().getAuth_num());
			
			empForSearch.setDept_name(emp.getDept().getDept_name());
			empForSearch.setDept_num(emp.getDept().getDept_num());
			
			empForSearch.setPosition_name(emp.getPosition().getPosition_name());
			empForSearch.setPosition_num(emp.getPosition().getPosition_num());
			
			empForSearch.setStatus_name(emp.getStatus().getStatus_name());
			empForSearch.setStatus_num(emp.getStatus().getStatus_num());
			
			empForSearch.setEmp_num(emp.getEmp_num());
			empForSearch.setEmp_name(emp.getEmp_name());
			empForSearch.setEmp_id(emp.getEmp_id());
			empForSearch.setEmp_address(emp.getEmp_address());
			empForSearch.setEmp_passwd(emp.getEmp_passwd());
			empForSearch.setEmp_email(emp.getEmp_email());
			empForSearch.setEmp_gender(emp.getEmp_gender());
			empForSearch.setEmp_hireDate(emp.getEmp_hireDate());
			
			//세션에 저장하기 위한 절차 
			session.setAttribute("empForSearch", empForSearch);
			session.setAttribute("emp", emp);
		}
		else
		{
			System.out.println("로그인 실패");
			emp.setMsg("로그인에 실패하셨습니다.");
			emp.setResult(0);
		}
		
		return emp;
	}
	
	//해당 사번을 가진 계정이 존재하는 지 확인하기 위한 메소드 [AJAX]
	@ResponseBody
	@PostMapping("/checkSignEmp")
	public int checkSignEmp(int emp_num)
	{
		System.out.println("EmpService checkSignEmp Start");
		int result = empService.checkSignEmp(emp_num);
		String res = "";
		
		if(result > 0)
		{
			res = "이미 계정이 존재";
		}
		else {
			res = "회원  가입 가능";
		}
		
		System.out.println(res);
		
		return result;
	}
	
	//미리 저장된 사원 정보와 비교를 통해서 회원 가입을 생성할 수 있는 여부를 확인하기 위한 메소드 [AJAX]
	@ResponseBody
	@PostMapping("/getEmpData")
	public EmpList getEmpData(int emp_num, String emp_name)
	{
		System.out.println("EmpService getEmpData Start");
		System.out.println("Emp_num : "+emp_num);
		System.out.println("Emp_name : "+emp_name);
		
		EmpList emplist = new EmpList();
		
		try {
			emplist = empService.getEmpData(emp_num);
			System.out.println("emplist Emp_num : "+emplist.getEmp_num());
			System.out.println("emplist Emp_name : "+emplist.getEmp_name());
			System.out.println("emplist 권한: " + emplist.getAuth_num());

			if(emplist.getEmp_name().equals(emp_name)) //사원 리스트에 [사번&이름]이 일치한 경우 [가입 가능]
			{
				System.out.println("사용자 확인 성공");
				emplist.setMsg("사원 조회에 성공했습니다.");
				emplist.setResult(1);
			}
			else { 									//사원 리스트에 [사번&이름]이 일치하지 못한 경우 [가입 불가능]
				System.out.println("사용자 확인 실패");
				emplist.setMsg("사원 조회에 실패했습니다.");
				emplist.setResult(0);
			}
		} catch (Exception e) //사원 리스트에 [사번&이름]이 일치하지 못한 경우 예외 [가입 불가능]
		{
			System.out.println(e.getMessage());
			emplist = new EmpList();
			System.out.println("사용자 확인 실패");
			emplist.setMsg("사원 조회에 실패했습니다.");
			emplist.setResult(0);
		}
		
		return emplist;
	}
	
	@RequestMapping(value = "/empSave" ) //사원 정보를 저장하기 위한 절차 [JPA 사용하여 다소 복잡]
	public String empSave(Emp emp,@RequestParam int position_num,@RequestParam int status_num, @RequestParam int auth_num, @RequestParam int dept_num)
	{
		Position position = new Position(); //직책 
		position.setPosition_num(position_num);
		emp.setPosition(position);
		
		Status status = new Status(); //직원 근무 상태
		status.setStatus_num(status_num);
		emp.setStatus(status);
		
		Authority authority = new Authority(); //계정 권한
		authority.setAuth_num(auth_num);
		emp.setAuth(authority);
		
		Dept dept = new Dept(); //부서
		dept.setDept_num(dept_num);
		emp.setDept(dept);
		
		System.out.println("EmpController EnCrypt Start");
		
		String securePassword = encoder.encode(emp.getEmp_passwd()); //비밀 번호 암호화 작업
		emp.setEmp_passwd(securePassword);
		
		System.out.println("암호화된 비밀번호: "+securePassword);
		 
		System.out.println("EmpController empSave Start...");
		int result = empService.empSave(emp);
		 
		if (result>0) //저장이 성공한 경우
		{
			System.out.println("Emp 테이블 직원 저장 완료");
		}
		else //저장이 실패한 경우 
		{
			System.out.println("Emp 테이블 직원 저장 실패");
		}
		return "/member/loginForm";
	}
	
	@ResponseBody
	@PostMapping("checkEmpId") //아이디 중복을 확인하기 위한 메소드 [AJAX]
	public int checkEmpId(String emp_id)
	{
		System.out.println("EmpService checkEmpId Start");
		int result = empService.checkEmpId(emp_id);
		String res = "";
		
		if(result > 0) //아이디가 중복되는 경우
		{
			res = "중복";
		}
		else	//아이디가 중복되지 않는 경우 
		{
			res = "사용 가능";
		}
		
		System.out.println(res); //로그용 메시지 출력 
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/changePw") //비밀번호 찾기에 비밀번호 변동이 생긴 경우  [AJAX]
	public int changePw(@RequestParam String emp_passwd, @RequestParam int emp_num)
	{
		int result = 0;
		System.out.println("EmpService changePw Start");
		
		System.out.println("emp_num : "+ emp_num);
		System.out.println("emp_passwd : "+emp_passwd);
		
		Emp emp = new Emp();
		try {
			emp = empService.getInfo(emp_num); //해당 사번의 정보 가져오기
			emp.setResult(1);
			System.out.println("암호화된 비밀번호: "+encoder.encode(emp_passwd));
			emp.setEmp_passwd(encoder.encode(emp_passwd)); //새로 입력값으로 받아온 비밀번호 암호화
			result = empService.changePw(emp.getEmp_passwd(),emp_num); //비밀번호 변동에 대한 결과값 저장
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			emp.setResult(0);
		}
		
		
		return result;
	}
		
	@RequestMapping("/userlist")
	public String userlist(Model model, HttpSession session, String currentPage)
	{
		Emp emp = (Emp) session.getAttribute("emp");
		//EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch");
		System.out.println("EmpService userlist [모든 유저 조회 기능] Start");
		
		//직원 조회를 위한 리스트
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		
		Page pg = new Page();
		
		//전체 직원수를 체크
		int totalEmp = empService.getEmpCount();
		
		//부서 이름 조회를 위한 리스트
		List<Dept> deptlist = new ArrayList<Dept>();
		
		System.out.println("모든 사용자의 수 : "+ totalEmp);
		
		Paging page = new Paging(totalEmp, currentPage);
		pg.setStart(page.getStart());
		pg.setEnd(page.getEnd());
		
		try {
			//직원 조회 기능 수행
			emplist = empService.getAllUserInfo(pg);
			
			//부서 선택 조회 기능을 위해 부서 이름 가져오기 수행
			deptlist = deptService.getDeptInfo();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		model.addAttribute("emplist",emplist);
		model.addAttribute("emp",emp);
		model.addAttribute("page", page);
		model.addAttribute("deptlist",deptlist);
		
		int deptnum = 0; 
		model.addAttribute("deptnum",deptnum);
		
		return "/member/admin/userlist";
	}
	
	@RequestMapping("/userlistDeptSearch")
	public String userlistDeptSearch(@RequestParam int deptnum, Model model, HttpSession session, String currentPage)
	{
		System.out.println("Current Page: "+currentPage);
		
		if(deptnum == 0)
		{
			return userlist(model, session, currentPage);
		}
		
		Emp emp = (Emp) session.getAttribute("emp");
		System.out.println("EmpService userlist ['부서별 유저 조회 기능'] Start");
		
		//직원 조회를 위한 리스트
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		
		Page pg = new Page();
		
		//전체 직원수를 체크
		int totalEmp = empService.getEmpCount(deptnum);
		
		//부서 이름 조회를 위한 리스트
		List<Dept> deptlist = new ArrayList<Dept>();
		
		System.out.println("모든 사용자의 수 : "+ totalEmp);
		
		Paging page = new Paging(totalEmp, currentPage);
		pg.setStart(page.getStart());
		pg.setEnd(page.getEnd());
		
		try {
			//직원 조회 기능 수행
			emplist = empService.getUserInfo(pg,deptnum);
			//부서 조회 기능 수행
			deptlist = deptService.getDeptInfo();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		model.addAttribute("emplist",emplist);
		model.addAttribute("emp",emp);
		model.addAttribute("page", page);
		model.addAttribute("deptlist",deptlist);
		model.addAttribute("deptnum",deptnum);
		
		return "/member/admin/userlist";
	}
	
	
	@PostMapping("/editInfo")
	public String upDateUser(Emp new_emp, Model model, HttpSession session)
	{
		Emp emp = (Emp) session.getAttribute("emp");
		System.out.println("EmpService editInfo Start");
		int result = 0;
		
		try {
			//이름 변경
			emp.setEmp_name(new_emp.getEmp_name());
			System.out.println("이름: "+new_emp.getEmp_name());
			
			//비밀번호 수정한 경우 암호화 한 후 다시 변경 
			if(emp.getEmp_passwd().equals(new_emp.getEmp_passwd()))
			{
				emp.setEmp_passwd(new_emp.getEmp_passwd());
			}
			
			else {
				String temp = new_emp.getEmp_passwd();
				temp = encoder.encode(temp);
				emp.setEmp_passwd(temp);
			}
			
			System.out.println("비밀번호: "+emp.getEmp_passwd());
			
			//이메일 변경
			emp.setEmp_email(new_emp.getEmp_email());
			
			System.out.println("이메일: "+new_emp.getEmp_email());
			
			//주소 변경
			emp.setEmp_address(new_emp.getEmp_address());
			
			System.out.println("주소: " + new_emp.getEmp_address());
			
			//변경 사항을 반영한 update문 
			result = empService.updateEmp(emp);
			
			if(result == 1)
			{
				System.out.println("회원 정보 변경에 성공하였습니다.");
			}
			else if(result == 2)
			{
				System.out.println("회원 정보 변경에 실패하였습니다.");
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		model.addAttribute("emp",emp);
		model.addAttribute("result",result);
		
		return "/member/user/userMyPageForm";
	}
	
	@PostMapping("/adminEditInfo")
	public String upDateUserAdmin(EmpForSearch new_emp, Model model, HttpSession session)
	{
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		System.out.println("EmpService adminEditInfo Start");
		int result = 0;
		
		try {
			//이름 변경
			emp.setEmp_name(new_emp.getEmp_name());
			System.out.println("이름: "+new_emp.getEmp_name());
			
			
			//비밀번호 변경
			//비밀번호 수정한 경우 암호화 한 후 다시 변경 
			if(emp.getEmp_passwd().equals(new_emp.getEmp_passwd()))
			{
				emp.setEmp_passwd(new_emp.getEmp_passwd());
			} else {
				String temp = new_emp.getEmp_passwd();
				temp = encoder.encode(temp);
				emp.setEmp_passwd(temp);
			}
			System.out.println("비밀번호: "+emp.getEmp_passwd());
			
			//이메일 변경
			emp.setEmp_email(new_emp.getEmp_email());
			System.out.println("이메일: "+new_emp.getEmp_email());
			
			//권한 등급 변경
			emp.setAuth_num(new_emp.getAuth_num());
			System.out.println("권한 등급: "+new_emp.getAuth_num());
			
			//부서 변경
			emp.setDept_num(new_emp.getDept_num());
			System.out.println("부서: "+new_emp.getDept_num());
			
			//직책 변경
			emp.setPosition_num(new_emp.getPosition_num());
			System.out.println("직책: "+new_emp.getPosition_num());
			
			//상태 변경
			emp.setStatus_num(new_emp.getStatus_num());
			System.out.println("상태: "+new_emp.getStatus_num());
			
			//주소 변경
			emp.setEmp_address(new_emp.getEmp_address());
			System.out.println("주소: " + new_emp.getEmp_address());
			
			//변경 사항을 반영한 update문 
			result = empService.updateEmpWithAdmin(emp);
			
			if(result == 1)
			{
				System.out.println("회원 정보 변경에 성공하였습니다.");
			}
			else if(result == 2)
			{
				System.out.println("회원 정보 변경에 실패하였습니다.");
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		List <Dept> deptlist = new ArrayList<Dept>();
		deptlist = deptService.getDeptInfo();
		
		List <Authority> authlist = new ArrayList<Authority>();
		authlist = authService.getAuthInfo();
		
		List <Position> poslist = new ArrayList<Position>();
		poslist = posService.getPosInfo();
		
		List <Status> statuslist = new ArrayList<Status>();
		statuslist = statusService.getStatusInfo();
		
		model.addAttribute("deptlist",deptlist);
		model.addAttribute("authlist",authlist);
		model.addAttribute("poslist",poslist);
		model.addAttribute("statuslist",statuslist);
		
		model.addAttribute("emp",emp);
		model.addAttribute("result",result);
		
		return "/member/admin/adminMyPageForm";
	}
	
}
