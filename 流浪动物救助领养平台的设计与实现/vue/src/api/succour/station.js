import request from '@/utils/request'

// 查询救助站列表
export function listStation(query) {
    return request({
        url: '/succour/station/list',
        method: 'get',
        params: query
    })
}

// 查询救助站详细
export function getStation(stationId) {
    return request({
        url: '/succour/station/' + stationId,
        method: 'get'
    })
}

// 新增救助站
export function addStation(data) {
    return request({
        url: '/succour/station',
        method: 'post',
        data: data
    })
}

// 修改救助站
export function updateStation(data) {
    return request({
        url: '/succour/station',
        method: 'put',
        data: data
    })
}

// 删除救助站
export function delStation(stationId) {
    return request({
        url: '/succour/station/' + stationId,
        method: 'delete'
    })
}

// 查询当前用户是否已经提交救助站认证
export function selectIsAuth() {
    return request({
        url: '/succour/station/selectIsAuth',
        method: 'get'
    })
}

// 通过认证
export function toAuth(userId) {
    return request({
        url: '/succour/station/toAuth/' + userId,
        method: 'put'
    })
}

// 查询状态为审核通过的救助站
export function selectStationListByIsAuth() {
    return request({
        url: '/succour/station/selectStationListByIsAuth',
        method: 'get'
    })
}
