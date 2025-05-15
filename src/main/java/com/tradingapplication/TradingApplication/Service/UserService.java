package com.tradingapplication.TradingApplication.Service;

import java.util.List;  

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.Account;
import com.tradingapplication.TradingApplication.Entity.UserLogin;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.Repository.UserRepository;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;



@Service
public class UserService implements UserServiceInterface{
	
	@Autowired
	UserRepository userRepository;
	@Autowired
	UserLogRepository logRepository;
	@Override
	public String addNewUser(UserRequestDTO requestDto) {
		
//		if(requestDto.getUsername().isBlank()||requestDto.getPassword().isBlank()||requestDto.getEmail().isBlank()
//				||requestDto.getMobile()==0) throw new IncorrectDetails("Enter Valid Details . . . ");
		UserLogin userlog = new UserLogin();
		userlog.setUsername(requestDto.getUsername());
		userlog.setPassword(requestDto.getPassword());
		
		logRepository.save(userlog);
		
		UserTable user= new UserTable();
		user.setUsername(requestDto.getUsername());
		user.setEmail(requestDto.getEmail());
		user.setMobile(requestDto.getMobile());
		user.setDateOfBirth(requestDto.getDateOfBirth());
		user.setPan(requestDto.getPan());
		Account account = new Account();
		account.setBalance(0);
		user.getAccount().setBalance(0); //it is Safe to use Because we using BiDirectional relationship
		
	
		userRepository.save(user);
		
		UserResponseDTO response = new UserResponseDTO();
		
		response.setUsername(requestDto.getUsername());
				
		return response.getUsername();
	}
	
	@Override
	public ResponseEntity<?> getAllStocks(){
		return null;
	}

	@Override
	public String userLogin(UserLogin userlogin) {
		String username = userlogin.getUsername();
		String password = userlogin.getPassword();
		List<UserLogin> existingUser = logRepository.findAll();
		
		for (UserLogin userpass : existingUser) {
			if(userpass.getUsername().equals(username)&&
			userpass.getPassword().equals(password)) {
				return "UserDashboard";
			}
		}
		
		return "LoginPage";
	}



	
	
}
