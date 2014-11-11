//
//  Webreturn.h
//  nominikoi
//
//  Created by ビザンコムマック０７ on 2014/10/10.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//  ウェブのデータを返すメソッド実装したクラス

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Webreturn : NSObject
//JSONのデータをarray型で返すメソッド
+(NSArray*)JSONArrayData:(NSString*)url;
//url先にあるデータを返すメソッド
+(NSData*)webdata:(NSString*)url;
//JSONのデータをNSDictionary型で返すメソッド
+(NSDictionary*)JSONDictinaryData:(NSString*)url;
//url先にある画像のデータを返すメソッド
+(UIImage*)WebImage:(NSString*)url;
//自分のサーバーにあるJSONデータを返すメソッド
+(NSArray*)serverdata:(NSString*)url;
@end
