package com.fast.succour.service.impl;

import com.fast.succour.domain.Category;
import com.fast.succour.domain.vo.CategoryVO;
import com.fast.succour.mapper.CategoryMapper;
import com.fast.succour.service.ICategoryService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

/**
 * 萌宠分类Service业务层处理
 */
@Service
public class CategoryServiceImpl implements ICategoryService {
    @Resource
    private CategoryMapper categoryMapper;

    /**
     * 查询萌宠分类列表
     * @param category 萌宠分类对象(查询参数)
     * @return 萌宠分类列表
     */
    @Override
    public List<Category> selectCategoryList(Category category) {
        return categoryMapper.selectCategoryList(category);
    }

    /**
     * 查询萌宠分类
     *
     * @param categoryId 萌宠分类主键
     * @return 萌宠分类
     */
    @Override
    public Category selectCategoryByCategoryId(String categoryId) {
        return categoryMapper.selectCategoryByCategoryId(categoryId);
    }

    /**
     * 新增萌宠分类
     * @param category 萌宠分类
     * @return 结果
     */
    @Override
    public int insertCategory(Category category) {
        //生成一个UUID并插入至对象中
        category.setCategoryId(String.valueOf(UUID.randomUUID()));
        return categoryMapper.insertCategory(category);
    }

    /**
     * 修改萌宠分类
     * @param category 萌宠分类
     * @return 结果
     */
    @Override
    public int updateCategory(Category category) {
        return categoryMapper.updateCategory(category);
    }

    /**
     * 批量删除萌宠分类
     * @param categoryIds 需要删除的萌宠分类主键
     * @return 结果
     */
    @Override
    public int deleteCategoryByCategoryIds(String[] categoryIds) {
        return categoryMapper.deleteCategoryByCategoryIds(categoryIds);
    }

    /**
     * 查询所有萌宠分类(用于下拉选择)
     * @return
     */
    @Override
    public List<CategoryVO> selectAllCategory() {
        return categoryMapper.selectAllCategory();
    }

}
