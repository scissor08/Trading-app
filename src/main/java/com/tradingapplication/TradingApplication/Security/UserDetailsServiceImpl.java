package com.tradingapplication.TradingApplication.Security;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserLogRepository userrepo;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserLog user = userrepo.findById(username)
                .orElseThrow(() -> new UsernameNotFoundException("User Not Found")); // Ensure Spring Security expected exception
        log.info("User {} assigned role: {}", user.getUsername(), user.getRole());

        return org.springframework.security.core.userdetails.User
                .withUsername(user.getUsername())
                .password(user.getPassword()) // Ensure this is BCrypt hashed
                .authorities(Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + user.getRole())))                .build();
        		
    }  
}

