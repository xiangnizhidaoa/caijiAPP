//
//  TaskModel.h
//  caijishuju
//
//  Created by 牛方路 on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskByModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskModel : NSObject

@property (nonatomic, strong) NSString *arrIDS;

@property (nonatomic, strong) NSString *chaoxiang;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) TaskByModel *createBy;

@property (nonatomic, strong) NSString *createDate;

@property (nonatomic, strong) NSString *dikuaizpid;

@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *endtime;

@property (nonatomic, strong) NSString *filecode;

@property (nonatomic, strong) NSString *fileid;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *isNewRecord;

@property (nonatomic, strong) NSString *isfugai;

@property (nonatomic, strong) NSString *isnew;

@property (nonatomic, strong) NSString *jingdu;

@property (nonatomic, strong) NSString *jingdu1;

@property (nonatomic, strong) NSString *jingdu2;

@property (nonatomic, strong) NSString *jingduzhi;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *remarks;

@property (nonatomic, strong) NSString *renwuid;

@property (nonatomic, strong) NSString *renwumc;

@property (nonatomic, strong) NSString *starttime;

@property (nonatomic, strong) NSString *updateDate;

@property (nonatomic, strong) NSString *weidu;

@property (nonatomic, strong) NSString *weidu1;

@property (nonatomic, strong) NSString *weidu2;

@property (nonatomic, strong) NSString *yepianzpid;

@property (nonatomic, strong) NSString *zhizhuzpid;

@property (nonatomic, strong) NSString *zhuangtai;

@property (nonatomic, strong) NSString *zuowumc;

@end

NS_ASSUME_NONNULL_END
