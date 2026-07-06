package com.fast.succour.service.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fast.succour.mapper.StationMapper;
import com.fast.succour.domain.Station;
import com.fast.succour.service.IStationService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import static com.fast.system.general.utils.SecurityUtils.getUserId;

/**
 * 救助站Service业务层处理
 *
 * @author hongyu
 * @date 2026-6-5
 */
@Service
public class StationServiceImpl implements IStationService {
    @Resource
    private StationMapper stationMapper;

    /**
     * 查询救助站
     *
     * @param stationId 救助站主键
     * @return 救助站
     */
    @Override
    public Station selectStationByStationId(String stationId) {
        return stationMapper.selectStationByStationId(stationId);
    }

    /**
     * 查询救助站列表
     *
     * @param station 救助站
     * @return 救助站
     */
    @Override
    public List<Station> selectStationList(Station station) {
        return stationMapper.selectStationList(station);
    }

    /**
     * 新增救助站
     *
     * @param station 救助站
     * @return 结果
     */
    @Override
    public int insertStation(Station station) {
        station.setCreateTime(new Date());
        station.setStationId(String.valueOf(UUID.randomUUID()));
        station.setUserId(Math.toIntExact(getUserId()));
        return stationMapper.insertStation(station);
    }

    /**
     * 修改救助站
     *
     * @param station 救助站
     * @return 结果
     */
    @Override
    public int updateStation(Station station) {
        return stationMapper.updateStation(station);
    }

    /**
     * 批量删除救助站
     *
     * @param stationIds 需要删除的救助站主键
     * @return 结果
     */
    @Override
    public int deleteStationByStationIds(String[] stationIds) {
        return stationMapper.deleteStationByStationIds(stationIds);
    }

    /**
     * 查询当前用户是否已经提交救助站认证
     * @return 是否已经提交救助站认证
     */
    @Override
    public Boolean selectIsAuth() {
        Long userId = getUserId();
        return stationMapper.selectIsAuth(userId);
    }

    /**
     * 通过认证
     * @param userId 要通过认证的用户ID
     * @return 是否通过认证
     */
    @Override
    @Transactional
    public int toAuth(Integer userId) {
        //用户和角色关联表中根据用户ID修改角色ID
        stationMapper.updateUserRoleByUserId(userId);

        //根据用户ID查询救助站ID
        String stationId = stationMapper.selectStationIdByUserId(userId);

        //将审核状态修改为已通过
        Station station = new Station();
        station.setStationId(stationId);
        station.setStatus("审核通过");

        return stationMapper.updateStation(station);
    }

    /**
     * 查询状态为审核通过的救助站
     * @return 救助站列表
     */
    @Override
    public List<Station> selectStationListByIsAuth() {
        return stationMapper.selectStationListByIsAuth();
    }
}
