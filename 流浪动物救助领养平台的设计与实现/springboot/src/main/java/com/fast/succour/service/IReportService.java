package com.fast.succour.service;

import java.util.List;
import com.fast.succour.domain.Report;

/**
 * 动物救助Service接口
 *
 * @author hongyu
 * @date 2026-6-8
 */
public interface IReportService
{
    /**
     * 查询动物救助
     *
     * @param reportId 动物救助主键
     * @return 动物救助
     */
    public Report selectReportByReportId(String reportId);

    /**
     * 查询动物救助列表
     *
     * @param report 动物救助
     * @return 动物救助集合
     */
    public List<Report> selectReportList(Report report);

    /**
     * 新增动物救助
     *
     * @param report 动物救助
     * @return 结果
     */
    public int insertReport(Report report);

    /**
     * 修改动物救助
     *
     * @param report 动物救助
     * @return 结果
     */
    public int updateReport(Report report);

    /**
     * 批量删除动物救助
     *
     * @param reportIds 需要删除的动物救助主键集合
     * @return 结果
     */
    public int deleteReportByReportIds(String[] reportIds);
}
