import request from '@/utils/request'

// 查询萌宠分类列表
export function listCategory(query) {
    return request({
        url: '/succour/category/list',
        method: 'get',
        params: query
    })
}

// 获取萌宠分类详细信息
export function getCategory(categoryId) {
    return request({
        url: '/succour/category/' + categoryId,
        method: 'get'
    })
}

// 新增萌宠分类
export function addCategory(data) {
    return request({
        url: '/succour/category',
        method: 'post',
        data: data
    })
}

// 修改萌宠分类
export function updateCategory(data) {
    return request({
        url: '/succour/category',
        method: 'put',
        data: data
    })
}

// 删除萌宠分类
export function delCategory(categoryId) {
    return request({
        url: '/succour/category/' + categoryId,
        method: 'delete'
    })
}

// 查询所有萌宠分类(用于下拉选择)
export function selectAllCategory() {
    return request({
        url: '/succour/category/selectAllCategory',
        method: 'get'
    })
}
