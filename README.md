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

Backlog 
==========

1.Review/Rating item can't repetive summbit by single user and it is not edit-able;

2.Should find NoSQL function to realize the "Favorite item" requirements;

3.Geo location inputment requirements;

4.One category item match along with one NoSQL document and many Reviews; 

5.Collobrative Filtering Recommandation implmentation;

6.User list with roles assignment, support add friends and send card message;

7.Timestamp string converting results as required; 
