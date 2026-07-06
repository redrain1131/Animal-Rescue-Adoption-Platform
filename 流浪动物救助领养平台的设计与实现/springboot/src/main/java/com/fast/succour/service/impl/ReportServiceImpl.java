package com.fast.succour.service.impl;

import com.fast.succour.domain.Report;
import com.fast.succour.mapper.ReportMapper;
import com.fast.succour.service.IReportService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 动物救助Service业务层处理
 *
 * @author hongyu
 * @date 2026-6-5
 */
@Service
public class ReportServiceImpl implements IReportService {
    @Resource
    private ReportMapper reportMapper;

    /**
     * 查询动物救助
     *
     * @param reportId 动物救助主键
     * @return 动物救助
     */
    @Override
    public Report selectReportByReportId(String reportId) {
        return reportMapper.selectReportByReportId(reportId);
    }

    /**
     * 查询动物救助列表
     *
     * @param report 动物救助
     * @return 动物救助
     */
    @Override
    public List<Report> selectReportList(Report report) {
        return reportMapper.selectReportList(report);
    }

    /**
     * 新增动物救助
     *
     * @param report 动物救助
     * @return 结果
     */
    @Override
    public int insertReport(Report report) {
        report.setCreateTime(new Date());
        report.setReportId(String.valueOf(UUID.randomUUID()));
        return reportMapper.insertReport(report);
    }

    /**
     * 修改动物救助
     *
     * @param report 动物救助
     * @return 结果
     */
    @Override
    public int updateReport(Report report) {
        return reportMapper.updateReport(report);
    }

    /**
     * 批量删除动物救助
     *
     * @param reportIds 需要删除的动物救助主键
     * @return 结果
     */
    @Override
    public int deleteReportByReportIds(String[] reportIds) {
        return reportMapper.deleteReportByReportIds(reportIds);
    }
}
