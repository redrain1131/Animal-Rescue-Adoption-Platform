package com.fast.succour.domain;

import com.fast.system.general.core.domain.BaseEntity;
import lombok.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;

/**
 * 轮播图对象 banner
 *
 * @author hongyu
 * @date 2026-6-4
 */

@Data
public class Banner
{

    /** 轮播图ID */
    private String bannerId;

    /** 图片 */
    private String image;

    /** 排序 */
    private Long sort;


}
