package com.fast.succour.service.impl;

import com.fast.succour.domain.Animal;
import com.fast.succour.mapper.AnimalMapper;
import com.fast.succour.mapper.StationMapper;
import com.fast.succour.service.IAnimalService;
import com.fast.system.mapper.SysRoleMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import static com.fast.system.general.utils.SecurityUtils.getUserId;

/**
 * 宠物Service业务层处理
 *
 * @author hongyu
 * @date 2026-6-5
 */
@Service
public class AnimalServiceImpl implements IAnimalService {
    @Resource
    private AnimalMapper animalMapper;

    @Resource
    private StationMapper stationMapper;

    @Resource
    private SysRoleMapper roleMapper;

    /**
     * 查询宠物
     *
     * @param animalId 宠物主键
     * @return 宠物
     */
    @Override
    public Animal selectAnimalByAnimalId(String animalId) {
        return animalMapper.selectAnimalByAnimalId(animalId);
    }

    /**
     * 查询宠物列表
     *
     * @param animal 宠物
     * @return 宠物
     */
    @Override
    public List<Animal> selectAnimalList(Animal animal) {
        return animalMapper.selectAnimalList(animal);
    }

    /**
     * 新增宠物
     *
     * @param animal 宠物
     * @return 结果
     */
    @Override
    public int insertAnimal(Animal animal) {
        animal.setCreateTime(new Date());
        animal.setAnimalId(String.valueOf(UUID.randomUUID()));

        //根据用户ID查询当前的角色, 如果不是救助站角色就不能新增
        Integer roleId = roleMapper.selectRoleIdByUserId(getUserId());

        if (roleId != 102) {
            throw new RuntimeException("您的账号不是救助站角色, 请登录救助站账号发布萌宠~");
        }

        //根据用户ID查询救助站ID
        String stationId = stationMapper.selectStationIdByUserId(Math.toIntExact(getUserId()));
        animal.setStationId(stationId);

        return animalMapper.insertAnimal(animal);
    }

    /**
     * 修改宠物
     *
     * @param animal 宠物
     * @return 结果
     */
    @Override
    public int updateAnimal(Animal animal) {
        return animalMapper.updateAnimal(animal);
    }

    /**
     * 批量删除宠物
     *
     * @param animalIds 需要删除的宠物主键
     * @return 结果
     */
    @Override
    public int deleteAnimalByAnimalIds(String[] animalIds) {
        return animalMapper.deleteAnimalByAnimalIds(animalIds);
    }

    /**
     * 根据救助站ID查询该救助站的可领养动物
     * @param stationId
     * @return
     */
    @Override
    public List<Animal> selectAnimalListByStationId(String stationId) {
        return animalMapper.selectAnimalListByStationId(stationId);
    }
}
