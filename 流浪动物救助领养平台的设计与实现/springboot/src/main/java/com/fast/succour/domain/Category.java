package com.fast.succour.domain;

import lombok.*;

/**
 * 萌宠分类对象 category
 */
@Data
public class Category {
    //分类ID
    private String categoryId;

    //分类名称
    private String name;

    //排序
    private Long sort;
}
