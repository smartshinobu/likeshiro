//
//  ViewController.m
//  tablesample2
//
//  Created by ビザンコムマック０７ on 2014/11/06.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"
#import "Webreturn.h"
#import "SampleTableViewCell.h"

@interface ViewController (){
    //応援している城の前後のランキングの情報をとるための配列
    NSMutableArray *likearray;
    NSArray *array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    array = [Webreturn serverdata:@"http://smartshinobu.miraiserver.com/shiro/likeshirorank.php"];
    likearray = [NSMutableArray array];
    for (int i = 0;i < [array count] ; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        NSString *shirostr = [dic objectForKey:@"shironame"];
        //気に入っている城の名前と一緒であるかどうか(今回は徳島城)
        if ([shirostr isEqualToString:@"徳島城"]) {
            //自分が気に入っている城の前後のランキング情報を取る処理
            for (int k = i - 2;k <= i + 2 ;k++ ) {
                if ((k >= 0) && (k < [array count])) {
                    NSDictionary *adddic = [array objectAtIndex:k];
                    [likearray addObject:adddic];
                }
            }
            NSLog(@"likearrayのカウントは%ld",likearray.count);
            break;
        }
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return likearray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellinentifier = @"samplecell";
    SampleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellinentifier];
    if (!cell) {
        NSLog(@"新規作成");
        cell = [[SampleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellinentifier];
    }
    
    NSDictionary *dic = likearray[indexPath.row];
    cell.ranklabel.text = [NSString stringWithFormat:@"第%@位",[dic objectForKey:@"rank"]];
    cell.shirolabel.text = [dic objectForKey:@"shironame"];
    NSString *tagcount = [dic objectForKey:@"tagcount"];
    NSString *block = [dic objectForKey:@"block"];
    cell.infolabel.text = [NSString stringWithFormat:@"ブロック:%@\nタグの投稿数:%@",block,tagcount];
    //自分が気に入っている城であるかどうか
    if ([cell.shirolabel.text isEqualToString:@"徳島城"]) {
        //文字の色を変える
        cell.ranklabel.textColor = [UIColor colorWithRed: (30.0)/255.0 green: (144.0)/255.0 blue: (255.0)/255.0 alpha: 1.0];
        cell.shirolabel.textColor = [UIColor colorWithRed: (30.0)/255.0 green: (144.0)/255.0 blue: (255.0)/255.0 alpha: 1.0];
        cell.infolabel.textColor = [UIColor colorWithRed: (30.0)/255.0 green: (144.0)/255.0 blue: (255.0)/255.0 alpha: 1.0];
    }
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    cell.imageview.image = nil;
    dispatch_async(q_global, ^{
        UIImage *img = [Webreturn WebImage:[dic objectForKey:@"imagename"]];
        dispatch_async(q_main, ^{
            cell.imageview.image = img;
        });
    });
    return cell;
}

@end
