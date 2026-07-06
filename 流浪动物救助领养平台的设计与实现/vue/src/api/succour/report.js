import request from '@/utils/request'

// 查询动物救助列表
export function listReport(query) {
    return request({
        url: '/succour/report/list',
        method: 'get',
        params: query
    })
}

// 查询动物救助详细
export function getReport(reportId) {
    return request({
        url: '/succour/report/' + reportId,
        method: 'get'
    })
}

// 新增动物救助
export function addReport(data) {
    return request({
        url: '/succour/report',
        method: 'post',
        data: data
    })
}

// 修改动物救助
export function updateReport(data) {
    return request({
        url: '/succour/report',
        method: 'put',
        data: data
    })
}

// 删除动物救助
export function delReport(reportId) {
    return request({
        url: '/succour/report/' + reportId,
        method: 'delete'
    })
}
