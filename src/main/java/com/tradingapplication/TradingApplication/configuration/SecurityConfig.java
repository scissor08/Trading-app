package com.tradingapplication.TradingApplication.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.tradingapplication.TradingApplication.Security.CustomAuthenticationSuccessHandler;
import com.tradingapplication.TradingApplication.Security.UserDetailsServiceImpl;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private CustomAuthenticationSuccessHandler successHandler;
	
    @Bean
    public UserDetailsService userDetailsService() {
        return new UserDetailsServiceImpl();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    // Method 1: Try this approach first
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }

    // Method 2: If Method 1 doesn't work, try this alternative approach
    // Uncomment this and comment out Method 1
    /*
    @Bean
    public AuthenticationManager authenticationManager(
            AuthenticationManagerBuilder authManagerBuilder,
            UserDetailsService userDetailsService,
            PasswordEncoder passwordEncoder) throws Exception {
        
        authManagerBuilder
            .userDetailsService(userDetailsService)
            .passwordEncoder(passwordEncoder);
        
        return authManagerBuilder.build();
    }
    */

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/arise/login", 
                    "/arise/registration", 
                    "/arise/authenticate", 
                    "/arise/validation",
                    "/arise/verification",
                    "/arise/register", 
                    "/arise/forget", 
                    "/arise/uservalidate", 
                    "/arise/otpvalidate",
                    "/arise/updatePassword", 
                    "/arise/OTPPage", 
                    "/arise/success",
                    "/WEB-INF/views/**", 
                    "/static/**",
                    "/css/**", 
                    "/js/**", 
                    "/images/**", 
                    "/error", 
                    "/favicon.ico", 
                    "/h2-console/**"
                ).permitAll()
                .anyRequest().authenticated()
            )
            
            // Disable Spring's automatic form login since you're handling it manually
            .formLogin(form -> form
                    .loginPage("/arise/login")
                    .successHandler(successHandler) // Use custom handler
                    .failureUrl("/arise/login?error=true")
                    .permitAll()
                )            
            .logout(logout -> logout
                .logoutUrl("/arise/logout")
                .logoutSuccessUrl("/arise/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
            )
            
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
            )
            
            .headers(headers -> headers
                .frameOptions().disable()
            )
            
            .authenticationProvider(authenticationProvider());

        return http.build();
    }
}