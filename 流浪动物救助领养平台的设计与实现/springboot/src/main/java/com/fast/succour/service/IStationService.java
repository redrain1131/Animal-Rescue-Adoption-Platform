package com.fast.succour.service;

import java.util.List;
import com.fast.succour.domain.Station;

/**
 * 救助站Service接口
 *
 * @author hongyu
 * @date 2026-6-8
 */
public interface IStationService
{
    /**
     * 查询救助站
     *
     * @param stationId 救助站主键
     * @return 救助站
     */
    public Station selectStationByStationId(String stationId);

    /**
     * 查询救助站列表
     *
     * @param station 救助站
     * @return 救助站集合
     */
    public List<Station> selectStationList(Station station);

    /**
     * 新增救助站
     *
     * @param station 救助站
     * @return 结果
     */
    public int insertStation(Station station);

    /**
     * 修改救助站
     *
     * @param station 救助站
     * @return 结果
     */
    public int updateStation(Station station);

    /**
     * 批量删除救助站
     *
     * @param stationIds 需要删除的救助站主键集合
     * @return 结果
     */
    public int deleteStationByStationIds(String[] stationIds);

    /**
     * 查询当前用户是否已经提交救助站认证
     * @return 是否已经提交救助站认证
     */
    Boolean selectIsAuth();

    /**
     * 通过认证
     * @param userId 要通过认证的用户ID
     * @return 是否通过认证
     */
    int toAuth(Integer userId);

    /**
     * 查询状态为审核通过的救助站
     * @return 救助站列表
     */
    List<Station> selectStationListByIsAuth();
}
