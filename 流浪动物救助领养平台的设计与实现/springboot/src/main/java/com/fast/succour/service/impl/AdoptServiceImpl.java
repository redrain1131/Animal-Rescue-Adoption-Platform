package com.fast.succour.service.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.fast.succour.domain.Animal;
import com.fast.succour.service.IAnimalService;
import com.fast.system.mapper.SysRoleMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fast.succour.mapper.AdoptMapper;
import com.fast.succour.domain.Adopt;
import com.fast.succour.service.IAdoptService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import static com.fast.system.general.utils.SecurityUtils.getUserId;

/**
 * 领养申请Service业务层处理
 *
 * @author hongyu
 * @date 2026-6-5
 */
@Service
public class AdoptServiceImpl implements IAdoptService {
    @Resource
    private AdoptMapper adoptMapper;

    @Resource
    private SysRoleMapper roleMapper;

    @Resource
    private IAnimalService animalService;

    /**
     * 查询领养申请
     *
     * @param adoptId 领养申请主键
     * @return 领养申请
     */
    @Override
    public Adopt selectAdoptByAdoptId(String adoptId) {
        return adoptMapper.selectAdoptByAdoptId(adoptId);
    }

    /**
     * 查询领养申请列表
     *
     * @param adopt 领养申请
     * @return 领养申请
     */
    @Override
    public List<Adopt> selectAdoptList(Adopt adopt) {
        return adoptMapper.selectAdoptList(adopt);
    }

    /**
     * 新增领养申请
     *
     * @param adopt 领养申请
     * @return 结果
     */
    @Override
    @Transactional
    public int insertAdopt(Adopt adopt) {
        adopt.setCreateTime(new Date());
        adopt.setAdoptId(String.valueOf(UUID.randomUUID()));
        adopt.setDescription("您的申请已被救助站接受，工作人员会尽快与您联系安排后续事宜");
        adopt.setUserId(Math.toIntExact(getUserId()));

        //萌宠提交领养申请后应当将萌宠状态变更为审核中
        String animalId = adopt.getAnimalId();
        Animal animal = new Animal();
        animal.setAnimalId(animalId);
        animal.setStatus("审核中");
        animalService.updateAnimal(animal);

        return adoptMapper.insertAdopt(adopt);
    }

    /**
     * 修改领养申请
     *
     * @param adopt 领养申请
     * @return 结果
     */
    @Override
    public int updateAdopt(Adopt adopt) {
        return adoptMapper.updateAdopt(adopt);
    }

    /**
     * 批量删除领养申请
     *
     * @param adoptIds 需要删除的领养申请主键
     * @return 结果
     */
    @Override
    public int deleteAdoptByAdoptIds(String[] adoptIds) {
        return adoptMapper.deleteAdoptByAdoptIds(adoptIds);
    }

    /**
     * 撤销申请
     * @param adoptId 领养申请Id
     * @return 是否撤销成功
     */
    @Override
    public int revoke(String adoptId) {
        //根据申请ID查询萌宠ID
        String animalId = adoptMapper.selectAdoptByAdoptId(adoptId).getAnimalId();
        //将萌宠状态修改回为可领养
        Animal animal = new Animal();
        animal.setAnimalId(animalId);
        animal.setStatus("可领养");
        animalService.updateAnimal(animal);

        //将adoptId转换为string[]
        String[] adoptIds = {adoptId};

        //删除申请信息
        return adoptMapper.deleteAdoptByAdoptIds(adoptIds);
    }
}
