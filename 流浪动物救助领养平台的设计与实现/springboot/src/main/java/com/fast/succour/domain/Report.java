package com.fast.succour.domain;

import com.fast.system.general.core.domain.BaseEntity;
import lombok.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;

/**
 * 动物救助对象 report
 *
 * @author hongyu
 * @date 2026-6-4
 */

@Data
public class Report
{

    /** 救助ID */
    private String reportId;

    /** 联系人 */
    private String name;

    /** 联系电话 */
    private String phone;

    /** 详细地址 */
    private String address;

    /** 动物情况 */
    private String situation;

    /** 现场图片 */
    private String image;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;


}
