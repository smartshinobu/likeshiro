//
//  ViewController.h
//  tablesample2
//
//  Created by ビザンコムマック０７ on 2014/11/06.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

