import request from '@/utils/request'

// 查询宠物列表
export function listAnimal(query) {
    return request({
        url: '/succour/animal/list',
        method: 'get',
        params: query
    })
}

// 查询宠物详细
export function getAnimal(animalId) {
    return request({
        url: '/succour/animal/' + animalId,
        method: 'get'
    })
}

// 新增宠物
export function addAnimal(data) {
    return request({
        url: '/succour/animal',
        method: 'post',
        data: data
    })
}

// 修改宠物
export function updateAnimal(data) {
    return request({
        url: '/succour/animal',
        method: 'put',
        data: data
    })
}

// 删除宠物
export function delAnimal(animalId) {
    return request({
        url: '/succour/animal/' + animalId,
        method: 'delete'
    })
}

// 根据救助站ID查询该救助站的可领养动物
export function selectAnimalListByStationId(stationId) {
    return request({
        url: '/succour/animal/selectAnimalListByStationId/' + stationId,
        method: 'get'
    })
}
