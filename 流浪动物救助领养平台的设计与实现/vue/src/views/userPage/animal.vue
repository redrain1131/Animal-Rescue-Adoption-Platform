<template>
    <div class="adopt-page">

        <div class="content-wrapper">
            <!-- 筛选器 -->
            <div class="filter-section">
                <div class="filter-tabs">
                  <span
                          v-for="category in categoryList"
                          :key="category.categoryId"
                          :class="['filter-tab', { active: animalFilter === category.categoryId }]"
                          @click="animalFilter = category.categoryId"
                  >
                    {{ category.name }}
                  </span>
                </div>
            </div>

            <!-- 动物列表 -->
            <div class="animals-grid">
                <div
                        v-for="animal in animalList"
                        :key="animal.animalId"
                        class="pet-card"
                        @click="goToDetail(animal)"
                >
                    <div class="pet-img-wrapper">
                        <img :src="baseUrl + animal.image" :alt="animal.name" loading="lazy">
                        <div class="pet-status-badge">
                          <el-tag type="primary">{{ animal.status }}</el-tag>
                        </div>
                    </div>
                    <div class="pet-info">
                        <div class="pet-header">
                            <h3>{{ animal.name }}</h3>
                            <span class="gender-icon male" v-if="animal.gender === '公'">
                              <el-icon>
                                <Male />
                              </el-icon>
                            </span>
                            <span class="gender-icon female" v-else>
                              <el-icon>
                                <Female />
                              </el-icon>
                            </span>
                        </div>
                        <div class="pet-tags">
                            <span class="tag">{{ animal.age }}</span>
                            <span class="tag station-tag" @click.stop="goToStation(animal.stationId)">
                              <el-icon><House/></el-icon>
                              {{ animal.stationName }}
                            </span>
                        </div>
                        <p class="pet-desc">{{ animal.description }}</p>
                    </div>
                </div>
            </div>

            <!-- 分页 -->
            <div style="display: flex; justify-content: center;">
              <pagination
                  :pageSizes="[8,16,32]"
                  v-show="total>0"
                  :total="total"
                  v-model:page="query.pageNum"
                  v-model:limit="query.pageSize"
                  @pagination="getList"
              />
            </div>
        </div>
    </div>
</template>

<script setup>
import {computed, ref} from 'vue'
import {useRouter} from 'vue-router'
import {Female, House, Male} from '@element-plus/icons-vue'
import {listAnimal} from "@/api/succour/animal.js";
import {selectAllCategory} from "@/api/succour/category.js";

const baseUrl = import.meta.env.VITE_APP_BASE_API

const router = useRouter()

// 筛选相关状态
const animalFilter = ref('all')

// 跳转到救助站详情
const goToStation = (stationId) => {
    router.push(`/user/stationDetail/${stationId}`)
}

// 显示动物详情
const goToDetail = (animal) => {
    router.push(`/user/animalDetail/${animal.animalId}`)
}

//查询参数
const query = ref({
  pageNum: 1,
  pageSize: 8,
  categoryId: null,
  status: '可领养'
})

// 动物列表数据
const animalList = ref([])

//数据总数
const total = ref(0)

//查询数据
const getList = () => {
  // 处理查询参数，如果选择了"全部伙伴"(categoryId为'all')，则不传categoryId参数
  const queryParams = {...query.value}
  if (queryParams.categoryId === 'all') {
    delete queryParams.categoryId
  }

  listAnimal(queryParams).then(res => {
    total.value = res.total
    animalList.value = res.rows
  })
}

const categoryList = ref([
  {name: '全部伙伴', categoryId: 'all'},
  {name: '汪星人', categoryId: '汪星人'},
  {name: '喵星人', categoryId: '喵星人'},
  {name: '其他宠物', categoryId: '其他宠物'}
])

// 监听筛选条件变化，重新获取数据
watch(animalFilter, (newVal) => {
  query.value.categoryId = newVal === 'all' ? null : newVal
  query.value.pageNum = 1
  getList()
})

//组件挂载完成后执行
onMounted(() => {
  getList()

  //查询分类数据
  selectAllCategory().then(res => {
    // 在获取到的实际分类数据前添加"全部伙伴"选项
    categoryList.value = [{name: '全部伙伴', categoryId: 'all'}, ...res.data]
  })
})

</script>

<style scoped>
.adopt-page {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    min-height: calc(100vh - 60px);
}

.content-wrapper {
    display: flex;
    flex-direction: column;
    gap: 30px;
}

/* --- Filter Section --- */
.filter-section {
    display: flex;
    justify-content: center;
}

.filter-tabs {
    display: inline-flex;
    background: #f0f0f0;
    padding: 5px;
    border-radius: 40px;
    gap: 5px;
}

.filter-tab {
    padding: 10px 25px;
    border-radius: 30px;
    cursor: pointer;
    font-weight: 600;
    color: #64748b;
    transition: all 0.3s;
}

.filter-tab.active {
    background: #ffffff;
    color: #2c3e50;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* --- Animal Cards --- */
.animals-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 30px;
}

.pet-card {
    background: #ffffff;
    border-radius: 24px;
    overflow: hidden;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
    cursor: pointer;
}

.pet-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

.pet-img-wrapper {
    height: 240px;
    position: relative;
    overflow: hidden;
}

.pet-img-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s;
}

.pet-card:hover .pet-img-wrapper img {
    transform: scale(1.05);
}

.pet-status-badge {
    position: absolute;
    top: 15px;
    left: 15px;
    padding: 4px 12px;
    border-radius: 10px;
    font-size: 12px;
    font-weight: bold;
    color: #ffffff;
}

.pet-card:hover .pet-overlay {
    opacity: 1;
}

.pet-info {
    padding: 20px;
}

.pet-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.pet-header h3 {
    font-size: 20px;
    margin: 0;
}

.gender-icon {
    width: 24px;
    height: 24px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    color: #ffffff;
}

.gender-icon.male {
    background: #89CFF0;
}

.gender-icon.female {
    background: #FFB7B2;
}

.pet-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin-bottom: 12px;
}

.tag {
    background: #f8f9fa;
    padding: 4px 10px;
    border-radius: 8px;
    font-size: 12px;
    color: #64748b;
}

.station-tag {
    background: #e6f7ff;
    color: #1890ff;
    cursor: pointer;
}

.station-tag:hover {
    background: #bae7ff;
}

.pet-desc {
    font-size: 13px;
    color: #64748b;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>
