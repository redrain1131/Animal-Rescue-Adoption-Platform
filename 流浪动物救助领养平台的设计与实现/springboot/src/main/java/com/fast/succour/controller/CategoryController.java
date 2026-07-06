package com.fast.succour.controller;

import com.fast.succour.domain.Category;
import com.fast.succour.domain.vo.CategoryVO;
import com.fast.succour.service.ICategoryService;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.general.core.page.TableDataInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 萌宠分类Controller
 */
@RestController
@RequestMapping("/succour/category")
public class CategoryController extends BaseController {
    @Resource
    private ICategoryService categoryService;

    /**
     * 查询萌宠分类列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Category category) {
        startPage();
        List<Category> list = categoryService.selectCategoryList(category);
        return getDataTable(list);
    }

    /**
     * 获取萌宠分类详细信息
     */
    @GetMapping("/{categoryId}")
    public AjaxResult getInfo(@PathVariable String categoryId) {
        return success(categoryService.selectCategoryByCategoryId(categoryId));
    }

    /**
     * 新增萌宠分类
     */
    @PostMapping
    public AjaxResult insertCategory(@RequestBody Category category) {
        return toAjax(categoryService.insertCategory(category));
    }

    /**
     * 修改萌宠分类
     */
    @PutMapping
    public AjaxResult edit(@RequestBody Category category) {
        return toAjax(categoryService.updateCategory(category));
    }

    /**
     * 删除萌宠分类
     */
    @DeleteMapping("/{categoryIds}")
    public AjaxResult remove(@PathVariable String[] categoryIds) {
        return toAjax(categoryService.deleteCategoryByCategoryIds(categoryIds));
    }

    /**
     * 查询所有萌宠分类(用于下拉选择)
     */
    @GetMapping("/selectAllCategory")
    public AjaxResult selectAllCategory() {
        List<CategoryVO> list = categoryService.selectAllCategory();
        return success(list);
    }

}
