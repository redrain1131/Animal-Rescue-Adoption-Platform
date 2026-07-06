import { createWebHistory, createRouter } from 'vue-router'
import Layout from '@/layout'

// 公共路由
export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login'),
    hidden: true
  },
  {
    path: '/register',
    component: () => import('@/views/register'),
    hidden: true
  },
  {
    path: "/:pathMatch(.*)*",
    component: () => import('@/views/error/404'),
    hidden: true
  },
  {
    path: '/401',
    component: () => import('@/views/error/401'),
    hidden: true
  },
  {
    path: '/',
    component: Layout,
    redirect: 'index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/index'),
        name: 'Index',
        meta: { title: '首页', icon: '首页', affix: true }
      }
    ]
  },
  {
    path: '/user',
    component: () => import('@/views/userPage/index'),
    redirect: '/user/home',
    hidden: true,
    children: [
      {
        path: 'home',
        component: () => import('@/views/userPage/home'),
        hidden: true,
      },
      {
        path: 'self',
        component: () => import('@/views/system/user/profile/index'),
        hidden: true,
      },
      {
        path: 'auth',
        component: () => import('@/views/userPage/auth'),
        hidden: true,
      },
      {
        path: 'animalDetail/:id',
        component: () => import('@/views/userPage/animalDetail'),
        hidden: true,
      },
      {
        path: 'animal',
        component: () => import('@/views/userPage/animal'),
        hidden: true,
      },
      {
        path: 'station',
        component: () => import('@/views/userPage/station'),
        hidden: true,
      },
      {
        path: 'stationDetail/:id',
        component: () => import('@/views/userPage/stationDetail'),
        hidden: true,
      },
      {
        path: 'donate',
        component: () => import('@/views/userPage/donate'),
        hidden: true,
      },
      {
        path: 'record',
        component: () => import('@/views/userPage/record'),
        hidden: true,
      },
      {
        path: 'urgent',
        component: () => import('@/views/userPage/urgent'),
        hidden: true,
      },
    ]
  },
  {
    path: '/user',
    component: Layout,
    hidden: true,
    children: [
      {
        path: 'profile',
        component: () => import('@/views/system/user/profile/index'),
        name: 'Profile',
        meta: { title: '个人中心', icon: 'user' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes: constantRoutes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    }
    return { top: 0 }
  },
})

export default router
