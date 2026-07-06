package com.fast.succour.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.fast.succour.domain.Animal;

/**
 * 宠物Mapper接口
 *
 * @author hongyu
 * @date 2026-6-4
 */
@Mapper
public interface AnimalMapper
{
    /**
     * 查询宠物
     *
     * @param animalId 宠物主键
     * @return 宠物
     */
    public Animal selectAnimalByAnimalId(String animalId);

    /**
     * 查询宠物列表
     *
     * @param animal 宠物
     * @return 宠物集合
     */
    public List<Animal> selectAnimalList(Animal animal);

    /**
     * 新增宠物
     *
     * @param animal 宠物
     * @return 结果
     */
    public int insertAnimal(Animal animal);

    /**
     * 修改宠物
     *
     * @param animal 宠物
     * @return 结果
     */
    public int updateAnimal(Animal animal);

    /**
     * 批量删除宠物
     *
     * @param animalIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAnimalByAnimalIds(String[] animalIds);

    /**
     * 根据救助站ID查询该救助站的可领养动物
     * @param stationId
     * @return
     */
    List<Animal> selectAnimalListByStationId(String stationId);
}
