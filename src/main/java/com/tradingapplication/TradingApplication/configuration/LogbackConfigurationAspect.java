package com.tradingapplication.TradingApplication.configuration;



import ch.qos.logback.classic.Level; 
import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.encoder.PatternLayoutEncoder;
import ch.qos.logback.classic.filter.LevelFilter;
import ch.qos.logback.core.rolling.RollingFileAppender;
import ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP;
import ch.qos.logback.core.rolling.TimeBasedRollingPolicy;
import ch.qos.logback.core.spi.FilterReply;
import ch.qos.logback.core.util.FileSize;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;



@Component
public class LogbackConfigurationAspect {

    private static final String LOG_HOME = "logs";
    private static final String ARCHIVE_HOME = "D:/archived-logs";
    
   
    public void configureLogback() {
        LoggerContext loggerContext = (LoggerContext) LoggerFactory.getILoggerFactory();
        
        // Clear existing configuration
        loggerContext.reset();
        
        // Create appenders
        RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> infoAppender = createInfoAppender(loggerContext);
        RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> debugAppender = createDebugAppender(loggerContext);
        RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> warnAppender = createWarnAppender(loggerContext);
        RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> errorAppender = createErrorAppender(loggerContext);
        
        // Start appenders
        infoAppender.start();
        debugAppender.start();
        warnAppender.start();
        errorAppender.start();
        
        // Configure root logger
        Logger rootLogger = loggerContext.getLogger(Logger.ROOT_LOGGER_NAME);
        rootLogger.setLevel(Level.DEBUG);
        rootLogger.addAppender(infoAppender);
        rootLogger.addAppender(debugAppender);
        rootLogger.addAppender(warnAppender);
        rootLogger.addAppender(errorAppender);
    }
    
    private RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> createInfoAppender(LoggerContext loggerContext) {
        RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> appender = new RollingFileAppender<>();
        appender.setContext(loggerContext);
        appender.setName("INFO_APPENDER");
        appender.setFile(LOG_HOME + "/info.log");
        
        // Configure rolling policy
        TimeBasedRollingPolicy<ch.qos.logback.classic.spi.ILoggingEvent> rollingPolicy = new TimeBasedRollingPolicy<>();
        rollingPolicy.setContext(loggerContext);
        rollingPolicy.setParent(appender);
        rollingPolicy.setFileNamePattern(ARCHIVE_HOME + "/info.%d{yyyy-MM-dd}.%i.log");
        rollingPolicy.setCleanHistoryOnStart(true);
        rollingPolicy.setMaxHistory(30);
        rollingPolicy.setTotalSizeCap(FileSize.valueOf("100MB"));
        
        SizeAndTimeBasedFNATP<ch.qos.logback.classic.spi.ILoggingEvent> triggeringPolicy = new SizeAndTimeBasedFNATP<>();
        triggeringPolicy.setMaxFileSize(FileSize.valueOf("5MB"));
        rollingPolicy.setTimeBasedFileNamingAndTriggeringPolicy(triggeringPolicy);
        rollingPolicy.start();
        
        appender.setRollingPolicy(rollingPolicy);
        
        // Configure encoder
        PatternLayoutEncoder encoder = new PatternLayoutEncoder();
        encoder.setContext(loggerContext);
        encoder.setPattern("%d{yyyy-MM-dd HH:mm:ss} [INFO] %logger{36} - %msg%n");
        encoder.start();
        appender.setEncoder(encoder);
        
        // Configure filter
        LevelFilter levelFilter = new LevelFilter();
        levelFilter.setLevel(Level.INFO);
        levelFilter.setOnMatch(FilterReply.ACCEPT);
        levelFilter.setOnMismatch(FilterReply.DENY);
        levelFilter.start();
        appender.addFilter(levelFilter);
        
        return appender;
    }
    
    private RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> createDebugAppender(LoggerContext loggerContext) {
        RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> appender = new RollingFileAppender<>();
        appender.setContext(loggerContext);
        appender.setName("DEBUG_APPENDER");
        appender.setFile(LOG_HOME + "/debug.log");
        
        // Configure rolling policy
        TimeBasedRollingPolicy<ch.qos.logback.classic.spi.ILoggingEvent> rollingPolicy = new TimeBasedRollingPolicy<>();
        rollingPolicy.setContext(loggerContext);
        rollingPolicy.setParent(appender);
        rollingPolicy.setFileNamePattern(ARCHIVE_HOME + "/debug.%d{yyyy-MM-dd}.%i.log");
        rollingPolicy.setMaxHistory(30);
        rollingPolicy.setTotalSizeCap(FileSize.valueOf("100MB"));
        
        SizeAndTimeBasedFNATP<ch.qos.logback.classic.spi.ILoggingEvent> triggeringPolicy = new SizeAndTimeBasedFNATP<>();
        triggeringPolicy.setMaxFileSize(FileSize.valueOf("2MB"));
        rollingPolicy.setTimeBasedFileNamingAndTriggeringPolicy(triggeringPolicy);
        rollingPolicy.start();
        
        appender.setRollingPolicy(rollingPolicy);
        
        // Configure encoder
        PatternLayoutEncoder encoder = new PatternLayoutEncoder();
        encoder.setContext(loggerContext);
        encoder.setPattern("%d{yyyy-MM-dd HH:mm:ss} [DEBUG] %logger{36} - %msg%n");
        encoder.start();
        appender.setEncoder(encoder);
        
        // Configure filter
        LevelFilter levelFilter = new LevelFilter();
        levelFilter.setLevel(Level.DEBUG);
        levelFilter.setOnMatch(FilterReply.ACCEPT);
        levelFilter.setOnMismatch(FilterReply.DENY);
        levelFilter.start();
        appender.addFilter(levelFilter);
        
        return appender;
    }
    
    private RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> createWarnAppender(LoggerContext loggerContext) {
        RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> appender = new RollingFileAppender<>();
        appender.setContext(loggerContext);
        appender.setName("WARN_APPENDER");
        appender.setFile(LOG_HOME + "/warn.log");
        
        // Configure rolling policy
        TimeBasedRollingPolicy<ch.qos.logback.classic.spi.ILoggingEvent> rollingPolicy = new TimeBasedRollingPolicy<>();
        rollingPolicy.setContext(loggerContext);
        rollingPolicy.setParent(appender);
        rollingPolicy.setFileNamePattern(ARCHIVE_HOME + "/warn.%d{yyyy-MM-dd}.%i.log");
        rollingPolicy.setMaxHistory(30);
        rollingPolicy.setTotalSizeCap(FileSize.valueOf("100MB"));
        
        SizeAndTimeBasedFNATP<ch.qos.logback.classic.spi.ILoggingEvent> triggeringPolicy = new SizeAndTimeBasedFNATP<>();
        triggeringPolicy.setMaxFileSize(FileSize.valueOf("2MB"));
        rollingPolicy.setTimeBasedFileNamingAndTriggeringPolicy(triggeringPolicy);
        rollingPolicy.start();
        
        appender.setRollingPolicy(rollingPolicy);
        
        // Configure encoder
        PatternLayoutEncoder encoder = new PatternLayoutEncoder();
        encoder.setContext(loggerContext);
        encoder.setPattern("%d{yyyy-MM-dd HH:mm:ss} [WARN] %logger{36} - %msg%n");
        encoder.start();
        appender.setEncoder(encoder);
        
        // Configure filter
        LevelFilter levelFilter = new LevelFilter();
        levelFilter.setLevel(Level.WARN);
        levelFilter.setOnMatch(FilterReply.ACCEPT);
        levelFilter.setOnMismatch(FilterReply.DENY);
        levelFilter.start();
        appender.addFilter(levelFilter);
        
        return appender;
    }
    
    private RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> createErrorAppender(LoggerContext loggerContext) {
        RollingFileAppender<ch.qos.logback.classic.spi.ILoggingEvent> appender = new RollingFileAppender<>();
        appender.setContext(loggerContext);
        appender.setName("ERROR_APPENDER");
        appender.setFile(LOG_HOME + "/error.log");
        
        // Configure rolling policy
        TimeBasedRollingPolicy<ch.qos.logback.classic.spi.ILoggingEvent> rollingPolicy = new TimeBasedRollingPolicy<>();
        rollingPolicy.setContext(loggerContext);
        rollingPolicy.setParent(appender);
        rollingPolicy.setFileNamePattern(ARCHIVE_HOME + "/error.%d{yyyy-MM-dd}.%i.log");
        rollingPolicy.setMaxHistory(30);
        rollingPolicy.setTotalSizeCap(FileSize.valueOf("100MB"));
        
        SizeAndTimeBasedFNATP<ch.qos.logback.classic.spi.ILoggingEvent> triggeringPolicy = new SizeAndTimeBasedFNATP<>();
        triggeringPolicy.setMaxFileSize(FileSize.valueOf("2MB"));
        rollingPolicy.setTimeBasedFileNamingAndTriggeringPolicy(triggeringPolicy);
        rollingPolicy.start();
        
        appender.setRollingPolicy(rollingPolicy);
        
        // Configure encoder
        PatternLayoutEncoder encoder = new PatternLayoutEncoder();
        encoder.setContext(loggerContext);
        encoder.setPattern("%d{yyyy-MM-dd HH:mm:ss} [ERROR] %logger{36} - %msg%n");
        encoder.start();
        appender.setEncoder(encoder);
        
        // Configure filter
        LevelFilter levelFilter = new LevelFilter();
        levelFilter.setLevel(Level.ERROR);
        levelFilter.setOnMatch(FilterReply.ACCEPT);
        levelFilter.setOnMismatch(FilterReply.DENY);
        levelFilter.start();
        appender.addFilter(levelFilter);
        
        return appender;
    }
}