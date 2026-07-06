package com.fast.succour.domain;

import lombok.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;

/**
 * 救助站对象 station
 *
 * @author hongyu
 * @date 2026-6-4
 */

@Data
public class Station {
    /** 救助站ID */
    private String stationId;

    /** 救助站名称 */
    private String name;

    /** 审核状态 */
    private String status;

    /** 救助站logo */
    private String logo;

    /** 负责人姓名 */
    private String contactPerson;

    /** 联系电话 */
    private String phone;

    /** 电子邮箱 */
    private String email;

    /** 详细地址 */
    private String address;

    /** 救助站描述 */
    private String description;

    /** 营业执照 */
    private String businessLicense;

    /** 法人身份证 */
    private String idCard;

    /** 用户ID */
    private Integer userId;

    /** 认证提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    //认证用户
    private String userName;
}
