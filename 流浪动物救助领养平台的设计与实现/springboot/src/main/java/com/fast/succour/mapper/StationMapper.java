package com.fast.succour.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.fast.succour.domain.Station;

/**
 * 救助站Mapper接口
 *
 * @author hongyu
 * @date 2026-6-5
 */
@Mapper
public interface StationMapper
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
     * @param stationIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteStationByStationIds(String[] stationIds);

    /**
     * 查询当前用户是否已经提交救助站认证
     * @return 是否已经提交救助站认证
     */
    Boolean selectIsAuth(Long userId);

    /**
     * 用户和角色关联表中根据用户ID修改角色ID
     * @param userId 用户ID
     * @return 是否修改成功
     */
    int updateUserRoleByUserId(Integer userId);

    /**
     * 根据用户ID查询救助站ID
     * @param userId 用户ID
     * @return 救助站ID
     */
    String selectStationIdByUserId(Integer userId);

    /**
     * 查询状态为审核通过的救助站
     * @return 救助站列表
     */
    List<Station> selectStationListByIsAuth();
}
