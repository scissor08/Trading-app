package com.tradingapplication.TradingApplication.Controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Service.IndexService;
import com.tradingapplication.TradingApplication.dto.IndexDTO;

@Controller
@RequestMapping("/api/indices")
public class IndexController {

    @Autowired
    private IndexService indexService;

    @GetMapping("/live")
    public List<IndexDTO> getLiveIndices() {
        return indexService.getLiveIndices();
    }
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        List<IndexDTO> indices = indexService.getLiveIndices();
        System.out.println("Indices: " + indices);
        model.addAttribute("indices", indices);
        return "live-indices";
    }

    
    
}
