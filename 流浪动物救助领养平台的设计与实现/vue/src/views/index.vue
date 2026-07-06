<template>
    <div style="padding: 20px;">
        <el-row :gutter="20">
            <el-col :span="8">
                <div class="card">
                    <div>
                        <div class="title">动物总数</div>
                        <div class="value">{{ animalCount }}</div>
                    </div>
                    <div class="icon animal-icon">
                        <el-icon>
                            <Medal />
                        </el-icon>
                    </div>
                </div>
            </el-col>

            <el-col :span="8">
                <div class="card">
                    <div>
                        <div class="title">救助站数量</div>
                        <div class="value">{{ stationCount }}</div>
                    </div>
                    <div class="icon station-icon">
                        <el-icon>
                            <OfficeBuilding/>
                        </el-icon>
                    </div>
                </div>
            </el-col>

            <el-col :span="8">
                <div class="card">
                    <div>
                        <div class="title">领养申请数</div>
                        <div class="value">{{ adoptCount }}</div>
                    </div>
                    <div class="icon adopt-icon">
                        <el-icon>
                            <User/>
                        </el-icon>
                    </div>
                </div>
            </el-col>
        </el-row>

        <el-row :gutter="20" class="chart-container">
            <el-col :span="12">
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">数据统计</div>
                    </div>
                    <div class="chart-body">
                        <div ref="chartRef" class="chart"></div>
                    </div>
                </div>
            </el-col>

            <el-col :span="12">
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">动物种类分布</div>
                    </div>
                    <div class="chart-body">
                        <div ref="pieChartRef" class="chart"></div>
                    </div>
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script setup>
import {onMounted, ref} from 'vue'
import * as animalApi from '@/api/succour/animal'
import * as stationApi from '@/api/succour/station'
import * as adoptApi from '@/api/succour/adopt'
import * as echarts from 'echarts'
import {Medal, Monitor, OfficeBuilding, User} from "@element-plus/icons-vue";

const animalCount = ref(0)
const stationCount = ref(0)
const adoptCount = ref(0)
const chartRef = ref(null)
const pieChartRef = ref(null)
let chart = null
let pieChart = null

// 获取统计数据
const fetchStatistics = async () => {
    try {
        // 获取动物总数
        const animalRes = await animalApi.listAnimal({})
        if (animalRes.code === 200) {
            animalCount.value = animalRes.rows.length

            // 处理动物种类分布数据
            processAnimalCategoryData(animalRes.rows)
        }

        // 获取救助站数量
        const stationRes = await stationApi.listStation({})
        if (stationRes.code === 200) {
            stationCount.value = stationRes.rows.length
        }

        // 获取领养申请数
        const adoptRes = await adoptApi.listAdopt({})
        if (adoptRes.code === 200) {
            adoptCount.value = adoptRes.rows.length
        }

        // 初始化图表
        initChart()
    } catch (error) {
        console.error('获取统计数据失败:', error)
    }
}

// 处理动物种类分布数据
const processAnimalCategoryData = (animals) => {
    const categoryMap = {}
    animals.forEach(animal => {
        const category = animal.categoryName || '未知'
        categoryMap[category] = (categoryMap[category] || 0) + 1
    })

    const categoryData = []
    Object.keys(categoryMap).forEach(key => {
        categoryData.push({
            name: key,
            value: categoryMap[key]
        })
    })

    initPieChart(categoryData)
}

// 初始化柱状图
const initChart = () => {
    if (!chartRef.value) return

    chart = echarts.init(chartRef.value)

    const option = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        legend: {
            data: ['动物数量', '救助站数量', '领养申请']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                data: ['总数']
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '动物数量',
                type: 'bar',
                barGap: 0,
                data: [animalCount.value]
            },
            {
                name: '救助站数量',
                type: 'bar',
                data: [stationCount.value]
            },
            {
                name: '领养申请',
                type: 'bar',
                data: [adoptCount.value]
            }
        ]
    }

    chart.setOption(option)
}

// 初始化饼图
const initPieChart = (categoryData) => {
    if (!pieChartRef.value) return

    pieChart = echarts.init(pieChartRef.value)

    const option = {
        tooltip: {
            trigger: 'item'
        },
        legend: {
            top: '5%',
            left: 'center'
        },
        series: [
            {
                name: '动物种类分布',
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: false,
                itemStyle: {
                    borderRadius: 10,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false,
                    position: 'center'
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '18',
                        fontWeight: 'bold'
                    }
                },
                labelLine: {
                    show: false
                },
                data: categoryData
            }
        ]
    }

    pieChart.setOption(option)
}

// 页面加载完成后获取数据
onMounted(() => {
    fetchStatistics()
})
</script>

<style scoped>
.card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 120px;
    padding: 20px;
    background: #fff;
    border-radius: 4px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.title {
    font-size: 16px;
    color: #666;
    margin-bottom: 10px;
}

.value {
    font-size: 28px;
    font-weight: bold;
}

.icon {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 30px;
}

.animal-icon {
    background-color: #e8f4ff;
    color: #409eff;
}

.station-icon {
    background-color: #f0f9eb;
    color: #67c23a;
}

.adopt-icon {
    background-color: #fdf5e6;
    color: #e6a23c;
}

.chart-container {
    margin-top: 20px;
}

.chart-card {
    background: #fff;
    border-radius: 4px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.chart-header {
    padding: 20px;
    border-bottom: 1px solid #eee;
}

.chart-title {
    font-size: 18px;
    font-weight: bold;
    color: #333;
}

.chart-body {
    padding: 20px;
}

.chart {
    width: 100%;
    height: 550px;
}
</style>
