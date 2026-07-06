package com.fast.succour.service;

import com.fast.succour.domain.Category;
import com.fast.succour.domain.vo.CategoryVO;

import java.util.List;

/**
 * 萌宠分类Service接口
 */
public interface ICategoryService {
    /**
     * 查询萌宠分类列表
     *
     * @param category 萌宠分类对象(查询参数)
     * @return 萌宠分类列表
     */
    List<Category> selectCategoryList(Category category);

    /**
     * 查询萌宠分类
     *
     * @param categoryId 萌宠分类主键
     * @return 萌宠分类
     */
    Category selectCategoryByCategoryId(String categoryId);

    /**
     * 新增萌宠分类
     * @param category 萌宠分类
     * @return 结果
     */
    int insertCategory(Category category);

    /**
     * 修改萌宠分类
     * @param category 萌宠分类
     * @return 结果
     */
    int updateCategory(Category category);

    /**
     * 批量删除萌宠分类
     * @param categoryIds 需要删除的萌宠分类主键集合
     * @return 结果
     */
    int deleteCategoryByCategoryIds(String[] categoryIds);

    /**
     * 查询所有萌宠分类(用于下拉选择)
     * @return
     */
    List<CategoryVO> selectAllCategory();
}
