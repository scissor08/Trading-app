//package com.tradingapplication.TradingApplication.Service;
//
//import java.io.BufferedReader;
//import java.io.InputStreamReader;
//import java.net.URL;
//
//import javax.net.ssl.HttpsURLConnection;
//
//import org.json.JSONObject;
//
//public class CaptchaValidator {
//
//    private static final String SECRET_KEY = "6Ldl-VArAAAAACpiLeSjvn58qJZbGe-BYOVahFsV"; // secret key
//
//    public static boolean verify(String response) {
//        if (response == null || response.isEmpty()) {
//            return false;
//        }
//
//        try {
//            String url = "https://www.google.com/recaptcha/api/siteverify";
//            String params = "secret=" + SECRET_KEY + "&response=" + response;
//
//            URL obj = new URL(url);
//            HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
//
//            // Add request headers
//            con.setRequestMethod("POST");
//            con.setDoOutput(true);
//            con.getOutputStream().write(params.getBytes("UTF-8"));
//
//            // Read response
//            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
//            String inputLine;
//            StringBuffer responseBuffer = new StringBuffer();
//
//            while ((inputLine = in.readLine()) != null) {
//                responseBuffer.append(inputLine);
//            }
//            in.close();
//
//            // Parse JSON
//            JSONObject json = new JSONObject(responseBuffer.toString());
//            return json.getBoolean("success");
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//}
//
