## 系统模块

~~~
com.wujie     
├── knight-ui              // 前端框架 [80]
├── knight-gateway         // 网关模块 [8080]
├── knight-auth            // 认证中心 [9200]
├── knight-api             // 接口模块
│       └── knight-api-system                          // 系统接口
├── knight-common          // 通用模块
│       └── knight-common-core                         // 核心模块
│       └── knight-common-datascope                    // 权限范围
│       └── knight-common-log                          // 日志记录
│       └── knight-common-redis                        // 缓存服务
│       └── knight-common-security                     // 安全模块
│       └── knight-common-swagger                      // 系统接口
├── knight-modules         // 业务模块
│       └── knight-system                              // 系统模块 [9201]
│       └── knight-gen                                 // 代码生成 [9202]
│       └── knight-job                                 // 定时任务 [9203]
│       └── knight-file                                // 文件服务 [9300]
├── knight-visual          // 图形化管理模块
│       └── knight-visual-monitor                      // 监控中心 [9100]
├──pom.xml                // 公共依赖
~~~


## 内置功能

1.  用户管理：用户是系统操作者，该功能主要完成系统用户配置。
2.  部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。
3.  岗位管理：配置系统用户所属担任职务。
4.  菜单管理：配置系统菜单，操作权限，按钮权限标识等。
5.  角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。
6.  字典管理：对系统中经常使用的一些较为固定的数据进行维护。
7.  参数管理：对系统动态配置常用参数。
8.  通知公告：系统通知公告信息发布维护。
9.  操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。
10. 登录日志：系统登录日志记录查询包含登录异常。
11. 在线用户：当前系统中活跃用户状态监控。
12. 定时任务：在线（添加、修改、删除)任务调度包含执行结果日志。
13. 代码生成：前后端代码的生成（java、html、xml、sql）支持CRUD下载 。
14. 系统接口：根据业务代码自动生成相关的api接口文档。
15. 服务监控：监视当前系统CPU、内存、磁盘、堆栈等相关信息。
16. 在线构建器：拖动表单元素生成相应的HTML代码。
17. 连接池监视：监视当前系统数据库连接池状态，可进行分析SQL找出系统性能瓶颈。


## 项目部署
JDK >= 1.8 (推荐1.8版本)
Mysql >= 5.7.0 (推荐5.7版本)
Redis >= 3.0
Maven >= 3.0
Node >= 10
nacos >= 1.1.0
sentinel >= 1.6.0

##步骤
1、创建数据库knight-cloud并导入数据脚本knight_2021xxxx.sql（必须），quartz.sql（可选）
2、创建数据库knight-config并导入数据脚本knight_config.sql（必须）
3、配置nacos持久化，修改conf/application.properties文件，增加支持mysql数据源配置

# db mysql
spring.datasource.platform=mysql
db.num=1
db.url.0=jdbc:mysql://localhost:3306/knight-config?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true
db.user=root
db.password=password（数据库密码）

提示

配置文件application.properties是在下载的nacos-server包conf目录下。
默认配置单机模式，nacos也集群/多集群部署模式参考 (Nacos支持三种部署模式 (opens new window))

4、打开运行基础模块（启动没有先后顺序,注意：运行前需要先启动nacos .redis）
GatewayApplication （网关模块 必须）
AuthApplication （认证模块 必须）
SystemApplication （系统模块 必须）
MonitorApplication （监控中心 可选）
GenApplication （代码生成 可选）
JobApplication （定时任务 可选）
FileApplication （文件服务 可选）

##前端的部署
提示

因为本项目是前后端完全分离的，所以需要前后端都单独启动好，才能进行访问。
前端安装完node后，最好设置下淘宝的镜像源，不建议使用cnpm（可能会出现奇怪的问题）

# 进入项目目录
cd knight-ui

# 安装依赖
npm install

# 强烈建议不要用直接使用 cnpm 安装，会有各种诡异的 bug，可以通过重新指定 registry 来解决 npm 安装速度慢的问题。
npm install --registry=https://registry.npm.taobao.org

# 本地开发 启动项目
npm run dev


##*******************打包****************
 后台打包工程文件

在knight-cloud项目的bin目录下执行package.bat打包Web工程，生成war/jar包文件。
然后会在项目下生成target文件夹包含war或jar

提示

不同模块版本会生成在knight/knight-xxxx模块下target文件夹

    部署工程文件

1、jar部署方式
使用命令行执行：java –jar knight-xxxx.jar 或者执行脚本：knight/bin/run-xxxx.bat

2、war部署方式
knight-cloud/pom.xml中的packaging修改为war，放入tomcat服务器webapps

   <packaging>war</packaging>

提示

不同模块版本在knight/knight-xxxx模块下修改pom.xml

    SpringBoot去除内嵌Tomcat（PS：此步骤不重要，因为不排除也能在容器中部署war）

<!-- 排除内置tomcat -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-web</artifactId>
	<exclusions>
		<exclusion>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-tomcat</artifactId>
		</exclusion>
	</exclusions>
</dependency>

#
前端部署

当项目开发完毕，只需要运行一行命令就可以打包你的应用

# 打包正式环境
npm run build:prod

# 打包预发布环境
npm run build:stage

构建打包成功之后，会在根目录生成 dist 文件夹，里面就是构建打包好的文件，通常是 ***.js 、***.css、index.html 等静态文件。

通常情况下 dist 文件夹的静态文件发布到你的 nginx 或者静态服务器即可，其中的 index.html 是后台服务的入口页面。

outputDir 提示

如果需要自定义构建，比如指定 dist 目录等，则需要通过 config (opens new window)的 outputDir 进行配置。

publicPath 提示

部署时改变页面js 和 css 静态引入路径 ,只需修改 vue.config.js 文件资源路径即可。

publicPath: './' //请根据自己路径来配置更改

export default new Router({
  mode: 'hash', // hash模式
})
