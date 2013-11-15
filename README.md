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

Backlog 
==========

1.Review/Rating item can't repetive summbit by single user and it is not edit-able;

2.Should find NoSQL function to realize the "Favorite item" requirements;

3.Geo location inputment requirements;
