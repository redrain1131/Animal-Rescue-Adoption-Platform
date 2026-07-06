package com.fast.succour.controller;

import com.fast.succour.domain.Report;
import com.fast.succour.service.IReportService;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.general.core.page.TableDataInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 动物救助Controller
 *
 * @author hongyu
 * @date 2026-6-3
 */
@RestController
@RequestMapping("/succour/report")
public class ReportController extends BaseController {
    @Resource
    private IReportService reportService;

    /**
     * 查询动物救助列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Report report) {
        startPage();
        List<Report> list = reportService.selectReportList(report);
        return getDataTable(list);
    }

    /**
     * 获取动物救助详细信息
     */
    @GetMapping(value = "/{reportId}")
    public AjaxResult getInfo(@PathVariable("reportId") String reportId) {
        return success(reportService.selectReportByReportId(reportId));
    }

    /**
     * 新增动物救助
     */
    @PostMapping
    public AjaxResult add(@RequestBody Report report) {
        return toAjax(reportService.insertReport(report));
    }

    /**
     * 修改动物救助
     */
    @PutMapping
    public AjaxResult edit(@RequestBody Report report) {
        return toAjax(reportService.updateReport(report));
    }

    /**
     * 删除动物救助
     */
    @DeleteMapping("/{reportIds}")
    public AjaxResult remove(@PathVariable String[] reportIds) {
        return toAjax(reportService.deleteReportByReportIds(reportIds));
    }
}
