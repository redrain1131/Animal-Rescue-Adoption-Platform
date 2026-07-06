package com.fast.succour.service.impl;

import com.fast.succour.domain.Banner;
import com.fast.succour.mapper.BannerMapper;
import com.fast.succour.service.IBannerService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

/**
 * 轮播图Service业务层处理
 *
 * @author hongyu
 * @date 2026-6-5
 */
@Service
public class BannerServiceImpl implements IBannerService {
    @Resource
    private BannerMapper bannerMapper;

    /**
     * 查询轮播图
     *
     * @param bannerId 轮播图主键
     * @return 轮播图
     */
    @Override
    public Banner selectBannerByBannerId(String bannerId) {
        return bannerMapper.selectBannerByBannerId(bannerId);
    }

    /**
     * 查询轮播图列表
     *
     * @param banner 轮播图
     * @return 轮播图
     */
    @Override
    public List<Banner> selectBannerList(Banner banner) {
        return bannerMapper.selectBannerList(banner);
    }

    /**
     * 新增轮播图
     *
     * @param banner 轮播图
     * @return 结果
     */
    @Override
    public int insertBanner(Banner banner) {
        banner.setBannerId(String.valueOf(UUID.randomUUID()));
        return bannerMapper.insertBanner(banner);
    }

    /**
     * 修改轮播图
     *
     * @param banner 轮播图
     * @return 结果
     */
    @Override
    public int updateBanner(Banner banner) {
        return bannerMapper.updateBanner(banner);
    }

    /**
     * 批量删除轮播图
     *
     * @param bannerIds 需要删除的轮播图主键
     * @return 结果
     */
    @Override
    public int deleteBannerByBannerIds(String[] bannerIds) {
        return bannerMapper.deleteBannerByBannerIds(bannerIds);
    }
}
