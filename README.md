furry-bear
==========

A prototype of reviewing Western-style food.


Front end
==========

A prototype of jQuery mobile, based on an open source project named "restaurant picker".

An iOS based version is under construction named "FurryBear".

Back end
==========

Using App42(http://api.shephertz.com/cloudapidocs) BAAS solution.

Glossary 
==========

[NoSQLStorage] http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/storage_api.html

[Catalogue/Category] http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/catalogue_api.html

[GeoSptical] http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/geospatial_api.html

ItemId [Cata/Cate] == json/docID [NoSQL]

CatalogueName [Cata]  == dbName [NoSQL]

CategoryName [Cate] == collectionName [NoSQL]

geoStorageName [Geo] == ItemId [Cate]

TODO 
==========

1.Re-factory the VCFeatureItems from UIView based to UITableView with UINavigationController based;

2.Log out function implementation;

3.Using NSOperation to refactory the App42 API service calls;

4.UI screen layout re-define;

5.Using ScoreBoard/LeadBoard and QueueService to apply the send user card message function;

6.Email service for newsletter(email subscribe/unsubscribe,get/set email list);


Backlog 
==========

1.Review/Rating item can't repetive summbit by single user and it is not edit-able;

2.Should find NoSQL function to realize the "Favorite item" requirements;

3.Geo location inputment requirements;

4.One category item match along with one NoSQL document and many Reviews; 

5.Collobrative Filtering Recommandation implmentation;

6.User list with roles assignment, support add friends and send card message;

7.Gamification by design;?

8.Timestamp string converting results as required; 

Reference
==========
饭本,微博,微信

Design
==========

用户群体：美食和美食图片要求高的客户,用户评分排行榜,一行图片

启动画面：小宝宝象敲鼓一样敲碗，敲出来星星，萌

目标用户

“一道菜”，每个人心里都会有道菜，时间长不吃就会惦记。每个人心里都会有个人，时间长不见就会想念。菜想吃的时候可以去做，而人一旦失去就永远相见与梦里。所以，珍惜嘴边菜，善待身边人。


High-level design
====================

1.用户输入标准邮箱地址可以成功注册并返回注册成功提示信息;

2.用户输入标准邮箱地址可以成功登录并跳转到首页;

Low-level design
====================

1.支持用户邮件注册功能;

2.支持用户邮件登录功能;

3.支持登录用户上传图片;

4.支持登录用户添加上传图片文字描述信息;

5.支持登录用户添加上传图片打分;

6.支持登录用户添加上传图片价格;

7.支持登录用户添加上传图片其他文字描述信息(电话，地址，餐厅);

8.支持地理位置搜索;

9.支持地理位置输入(Auto Complete);

10.支持群组信息首页展示（只需要两条，图片＋评分＋评价者的vid和头像);

11.

Gist
====================
https://gist.github.com/yangboz/8917276

WeChat API
====================
http://open.weixin.qq.com/document/
