//
//  Prefs.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-12-27.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#ifndef FurryBear_iOS_Prefs_h
#define FurryBear_iOS_Prefs_h
//Segue names
#define SEGUE_NAME_LOGIN @"UserLogin"
#define SEGUE_NAME_IMAGE_CATE_ITEM @"segue_image_cate_item"
#define SEGUE_NAME_REVIEW @"segue_review"
#define SEGUE_NAME_SIGNUP @"segue_signup"
#define SEGUE_NAME_EMAIL_SETTING @"segue_email_setting"
#define SEGUE_NAME_EMAIL_SEND @"segue_email_send"//for NewsLetter
#define SEGUE_NAME_ITEM_DETAIL @"segue_item_detail"
//NO SQL keys
#define KEY_NAME_ADDRESS @"address"
#define KEY_NAME_TELPHONE @"telphone"
#define KEY_NAME_RESTAURANT @"restaurant"
#define KEY_NAME_AGREE_NEXT_TIME @"agreeNextTime"
#define KEY_NAME_OWNERNAME @"ownername"
#define KEY_NAME_FAV_ITEM @"favoriteItem"
//Email Service-GmailAccount
#define GMAIL_HOST @"smtp.gmail.com"
#define GMAIL_PORT 465
#define GMAIL_ID @"YoungWelle@gmail.com"
#define GMAIL_PWD @"7740321"
#define GMAIL_IS_SSL YES
//Notification name
#define NOTIFY_NAME_CATE_ITEM_ADDED @"categoryItemsAdded"
//CategoryDictionaryKey
#define DICT_KEY_REVIEW_COUNT @"reviewCount"
#define DICT_KEY_COMMENT_COUNT @"commentCount"
#define DICT_KEY_USER_NAME @"username"
#define DICT_KEY_TIME_STAMP @"timestamp"
#define DICT_KEY_RATING @"rating"
#define DICT_KEY_CATE_ITEM @"cateItem"
//User PreferenceKey
#define PREFERENCE_KEY_USER_NAME @"userName"
#define PREFERENCE_KEY_PASS_WORD @"passWord"
#define PREFERENCE_KEY_AUTO_SIGN_IN @"autoSignin_preference"
#define PREFERENCE_KEY_INTRO_VIEWED @"introViewed_preference"
//EAIntro descriptions
#define INTRO_DESCRIPTION_00 @"品尝一道菜!";
#define INTRO_DESCRIPTION_01 @"留住一道菜!";
#define INTRO_DESCRIPTION_02 @"回味一道菜!";
#define INTRO_DESCRIPTION_03 @"分享一道菜!";

#endif
