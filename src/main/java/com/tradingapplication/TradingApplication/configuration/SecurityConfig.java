package com.tradingapplication.TradingApplication.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.tradingapplication.TradingApplication.Security.CustomAuthenticationSuccessHandler;
import com.tradingapplication.TradingApplication.Security.JwtAuthenticationFilter;
import com.tradingapplication.TradingApplication.Security.JwtUtil;
import com.tradingapplication.TradingApplication.Security.OAuth2LoginSuccessHandler;
import com.tradingapplication.TradingApplication.Security.UserDetailsServiceImpl;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private OAuth2LoginSuccessHandler oAuth2LoginSuccessHandler;
	@Autowired
	private JwtUtil jwtUtil;
	@Autowired
	CustomAuthenticationSuccessHandler successHandler;

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

	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
		return authConfig.getAuthenticationManager();
	}


	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.csrf(csrf -> csrf.disable())
				.authorizeHttpRequests(auth -> auth
						.requestMatchers("/arise/login", "/arise/registration", "/arise/authenticate",
								"/arise/validation", "/arise/verification", "/arise/register", "/arise/forget",
								"/arise/uservalidate", "/arise/otpvalidate", "/arise/updatePassword", "/arise/OTPPage",
								"/arise/success", "/WEB-INF/views/**", "/static/**", "/css/**", "/js/**", "/images/**",
								"/error", "/favicon.ico", "/h2-console/**", "/oauth2/**")
						.permitAll()
						.anyRequest().authenticated())
				.headers(headers -> headers.frameOptions().sameOrigin())
				.formLogin(form -> form
						.loginPage("/arise/login") 
						.loginProcessingUrl("/arise/login") 
						.successHandler(successHandler) 
						.failureUrl("/arise/login?error=true").permitAll())
				.oauth2Login(oauth2 -> oauth2
						.loginPage("/arise/login")
						.successHandler(oAuth2LoginSuccessHandler))
				.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
				.authenticationProvider(authenticationProvider())
				.addFilterBefore(new JwtAuthenticationFilter(jwtUtil, userDetailsService()),
						UsernamePasswordAuthenticationFilter.class);


		return http.build();
	}
}