## SSRouter
- [用法](#用法)
- [描述](#描述)




### 用法
SSRouter.map("/home/goods", GoodsViewController.self)

SSRouter.execute("ssrouter://\(SSRouter.pagePush):0/home/goods", nil)


### 说明
--构建该路由借鉴了JLRouter、Routable等其他未开源的路由思路
 --没有将JLRouter通过url.path传参的思路融合进来，感觉用处不是太大，借鉴了Routable一步控制页面跳转的思路
 
 --下面附上个人思路
 --首先应该熟悉URL，请参照http://www.ietf.org/rfc/rfc1738.txt
 
 --本人思路
 --URL结构为: scheme://host/path?query#fragment
 
 scheme: 作为判断是否打开外部app的判断条件
 host: 作为执行某种操作的判断条件，例如page.push为普通页面跳转，push.modal为模态化页面跳转，action.net为网络操作...
 port: 作为控制标签栏控制器切换的条件
 path: 作为map中的key
 query: 传参
 fragment: 传参
 
 --Router用法
 --如果想用router控制页面的跳转，最便捷的方式就是将要push的页面实现SSRouterPushProtocol，使用协议的目的是控制业务工程师编码的规范性
 --当然首先你需要map需要跳转的控制器类型 -> pattern:classtype，SSRouter提供了自动跳转的功能
 --如果您需要手动实现跳转，那就只好map handler -> pattern:handler
 
 
 本人github地址：https://github.com/yoonthinker ps:新注册的账号，之前有几个开源代码，半年后的今天感觉有点low，就不再放出了
 本人邮箱：yoonthinker@gmail.com
 本人QQ：1244256397
 
 期待各位提出不同意见，也可以探讨其他问题！@O@¥IO#YO！@Y#OI！@#YI～I！#UI@U#！@*&TIU@*（¥！@&*¥&！@*¥……*（……*（！#*（
