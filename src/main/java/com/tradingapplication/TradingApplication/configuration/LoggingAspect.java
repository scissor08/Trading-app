package com.tradingapplication.TradingApplication.configuration;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.*;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Aspect
@Component
public class LoggingAspect {

    private static final Logger logger = LoggerFactory.getLogger(LoggingAspect.class);

    @Around("execution(* com.tradingapplication.TradingApplication.*(..))")
    public Object logBuyServiceMethods(ProceedingJoinPoint joinPoint) throws Throwable {
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();

        String className = methodSignature.getDeclaringType().getSimpleName();
        String methodName = methodSignature.getName();
        Object[] args = joinPoint.getArgs();

        logger.info("▶️ {}.{}() called with args: {}", className, methodName, Arrays.toString(args));

        long start = System.currentTimeMillis();
        try {
            Object result = joinPoint.proceed();
            long duration = System.currentTimeMillis() - start;

            logger.info("✅ {}.{}() completed in {} ms with result: {}", className, methodName, duration, result);
            return result;

        } catch (Throwable ex) {
            logger.error("❌ Exception in {}.{}() - {}", className, methodName, ex.getMessage(), ex);
            throw ex;
        }
    }
}
