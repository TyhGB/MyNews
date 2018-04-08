//
//  NewsModel.h
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
/*****一条新闻json
 votecount: 2088,
 docid: "D6GQU683000189FH",
 lmodify: "2017-12-25 15:54:24",
 url_3w: "http://news.163.com/17/1225/14/D6GQU683000189FH.html",
 source: "新华网",
 postid: "D6GQU683000189FH",
 priority: 310,
 title: "习近平：把农村公路建好管好护好运营好",
 mtime: "2017-12-25 14:51:15",
 url: "http://3g.163.com/news/17/1225/14/D6GQU683000189FH.html",
 replyCount: 2886,
 ltitle: "习近平：把农村公路建好管好护好运营好",
 subtitle: "",
 digest: "习近平对“四好农村路”建设作出重要指示强调把农村公路建好管好护好运营好为广大农民致富奔小康加快推进农业农村现代化提供更好保障李克强作出批示新华社北京12月25日",
 boardid: "news2_bbs",
 imgsrc: "http://cms-bucket.nosdn.127.net/029a616e45eb4fc78c5aa89258ff269420171225145018.png",
 ptime: "2017-12-25 14:42:53",
 daynum: "17525"
 *****/

@property (nonatomic,strong) NSString *imgsrc;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *source;
@property (nonatomic,assign) NSUInteger replyCount;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *url_3w;
/*详情新闻拼接符号*/
@property (nonatomic,strong) NSString *docid;
@end
