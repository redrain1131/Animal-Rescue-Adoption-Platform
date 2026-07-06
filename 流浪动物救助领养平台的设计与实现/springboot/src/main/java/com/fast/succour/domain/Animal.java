package com.fast.succour.domain;

import com.fast.system.general.core.domain.BaseEntity;
import lombok.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;

/**
 * 宠物对象 animal
 *
 * @author hongyu
 * @date 2026-6-3
 */

@Data
public class Animal
{

    /** 宠物ID */
    private String animalId;

    /** 宠物名字 */
    private String name;

    /** 分类ID */
    private String categoryId;

    /** 年龄 */
    private String age;

    /** 性别 */
    private String gender;

    /** 状态 */
    private String status;

    /** 照片 */
    private String image;

    /** 介绍 */
    private String description;

    /** 救助站ID */
    private String stationId;

    /** 救助过程 */
    private String process;

    /** 认证提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    //萌宠分类
    private String categoryName;

    //救助站名称
    private String stationName;

    //发布萌宠的救助站的用户ID
    private Long stationForUserId;


}
