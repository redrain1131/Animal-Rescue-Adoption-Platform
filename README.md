# 流浪动物救助与领养平台

## 项目简介
为校园流浪动物救助社团开发的信息化管理平台，解决救助信息分散、领养流程不规范的问题。实现动物信息发布、领养申请审批、图片上传等核心功能。

## 技术栈
- 前端：Vue 3 + Element Plus + Vue Router + Axios
- 后端：Spring Boot + MyBatis-Plus + Maven
- 数据库：MySQL 8.0
## 功能模块
-用户注册/登录（JWT认证）
-动物信息的增删改查（支持图片自行上传）
-领养申请提交与审批
-管理员后台（用户管理、数据统计）
--救助站的审核

## 动物列表页面
<img width="945" height="500" alt="12cff2b0a426b9a3df7e3798cb79e2a0" src="https://github.com/user-attachments/assets/f8587ad7-bd5c-4f9f-893b-cd6c93d7fa8a" />

## 领养申请与审批页面
<img width="945" height="401" alt="e956d4b735b2383ff76614291a1d6653" src="https://github.com/user-attachments/assets/91b8411e-563b-43d6-b3e0-4ee98a71d818" />

## 救助站审核页面
<img width="945" height="536" alt="image" src="https://github.com/user-attachments/assets/95f68347-3249-4b97-9efb-66028627f8da" />

## 快速开始

### 1.克隆项目
```bash
git clone https://github.com/redrain1131/Animal-Rescue-Adoption-Platform.git
cd Animal-Rescue-Adoption-Platform
```
### 2.创建您的数据库，名为animal_succour，将animal-succour.sql文件导入

### 3.修改 application.yml 中的数据库配置（用户名、密码），并使用“mvn spring-boot:run”启动后端

### 4.使用“npm run dev”启动前端

