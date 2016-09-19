//
//  ViewController.m
//  test5
//
//  Created by kunren-n1 on 2015/04/02.
//  Copyright (c) 2015年 TakeuchiSyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
 //   int id01 ;//名前id
  //  NSMutableArray *imagebank;
    
    arrayandid *aa;
    arrayandid *ab;
}
@property (weak ,nonatomic)NSTimer *tm1;//タイマーカウント
@property (weak ,nonatomic)NSTimer *tm2;//タイマーカウント
@end

@implementation ViewController

- (void)viewDidLoad {
 //   id01 = 0;//id初期化
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    aa =[[arrayandid alloc]init];
    ab =[[arrayandid alloc]init];
    // self.imagebank= [[NSMutableArray alloc] init];
    
    self.tm1=
    [NSTimer
     scheduledTimerWithTimeInterval:0.5f
     target:self
     selector:@selector(dropF:)
     userInfo:aa
     repeats:YES];
    self.tm2=
    [NSTimer
     scheduledTimerWithTimeInterval:0.6f
     target:self
     selector:@selector(dropF:)
     userInfo:ab
     repeats:YES];

    
    [self.tm1 fire];
    [self.tm2 fire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView*)LoadtoImage:(NSString*)title X:(float)Xpoint Y:(float)Ypoint wide:(int)wide height:(int)height{
    UIImageView * image =[[UIImageView alloc]init];
    image.image =[UIImage imageNamed:title];
    [image setFrame:CGRectMake(Xpoint, Ypoint, wide, height)];
    return image;
}



-(void) dropF:(NSTimer*)timer{
    CGRect CO1 = [[UIScreen mainScreen] bounds];//画面サイズ用
    float gazoupointX =arc4random_uniform(CO1.size.width);//画像初期位置
    int ramdombrone =arc4random_uniform(2); //生成判定
    arrayandid *as =timer.userInfo;
    NSMutableArray *bank =[as getbank];
    int id00 = [as getid];
    UIImageView *gazou;
    
    //画像ロードと初期位置セット
    if (ramdombrone == 1) {
        
        
        gazou = [[UIImageView alloc] init];
        gazou = [self LoadtoImage:@"t02200275_0708088611887392541.png"
                                X:gazoupointX
                                Y:0.0
                             wide:10
                           height:15];
        
        [self.view addSubview:gazou];
        
        
        //アニメーション設定
        float ramroteX = (arc4random_uniform(3)-1.0);
        if (ramroteX==0) {
            ramroteX=2;
        }
        float ramroteY = (arc4random_uniform(3)-1.0);
        if (ramroteY==0) {
            ramroteY=2;
        }
        float ramtime = arc4random_uniform(10)+10.0;
        
        [self settoanime:gazou
                topointX:gazoupointX
                topointY:CO1.size.height
                   roteX:ramroteX*M_PI*4
                   roteY:ramroteY*M_PI*4
                   roteZ:0.0
               animetime:ramtime
              anititleid:id00];
        [bank addObject:gazou];
        if (id00 >= 50) {
            UIImageView *gazou2 = [bank objectAtIndex:id00-50];
            [self deleteanim:gazou2 animeid:id00-50];
              NSLog(@"%lu",(unsigned long)bank.count);
        }
        id00++;//idをインクリメント
        [as setid:id00];
        //      NSLog(@"%d",ramdombrone);
    }
}
//アニメーションセット
-(void)settoanime:(UIImageView*)image topointX:(float)topointX topointY:(float)topointY roteX:(float)roteX roteY:(float)roteY roteZ:(float)roteZ animetime:(float)anitime anititleid:(int)aniid{
    //落下するアニメーション
    CABasicAnimation *ani =[CABasicAnimation animationWithKeyPath:@"position"];
    //設定（変化値）
    ani.fromValue =[NSNumber valueWithCGPoint:image.layer.position];
    ani.toValue = [NSNumber valueWithCGPoint:CGPointMake(image.layer.position.x, topointY)];
    //設定(アニメーション時間）単位秒
    ani.duration = anitime;
    //設定（リピート設定）
    //    ani.repeatCount = HUGE_VALF;//無限リピート
    ani.repeatCount = 1;
    //アニメーションセット
    //   NSString *animeid  = [NSString stringWithFormat:@"%d00",aniid];
    //   [image.layer addAnimation:ani forKey:animeid];
    
    //回転するアニメーションX軸
    CABasicAnimation *ani2 =[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    //設定（変化値）
    ani2.fromValue =[NSNumber numberWithDouble:0.0];
    ani2.toValue = [NSNumber numberWithDouble:roteX];
    //設定(アニメーション時間）単位秒
    ani2.duration = 5.0;
    //設定（リピート設定）
    //    ani.repeatCount = HUGE_VALF;//無限リピート
    ani2.repeatCount = HUGE_VALF;
    
    //回転するアニメーションY軸
    CABasicAnimation *ani3 =[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    //設定（変化値）
    ani3.fromValue =[NSNumber numberWithDouble:0.0];
    ani3.toValue = [NSNumber numberWithDouble:roteY];
    //設定(アニメーション時間）単位秒
    ani3.duration = 5.0;
    //設定（リピート設定）
    //    ani.repeatCount = HUGE_VALF;//無限リピート
    ani3.repeatCount = HUGE_VALF;
    
    //回転するアニメーションZ軸
    CABasicAnimation *ani4 =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //設定（変化値）
    ani4.fromValue =[NSNumber numberWithDouble:0.0];
    ani4.toValue = [NSNumber numberWithDouble:roteZ];
    //設定(アニメーション時間）単位秒
    ani4.duration = 5.0;
    //設定（リピート設定）
    //    ani.repeatCount = HUGE_VALF;//無限リピート
    ani4.repeatCount = HUGE_VALF;
    
    //統合アニメーション
    CAAnimationGroup *agroup = [CAAnimationGroup animation];
    //統合の属性設定と収納
    agroup.repeatCount =1;
    agroup.duration = anitime;
    agroup.animations=[NSArray arrayWithObjects:ani, ani2, ani3, ani4, nil];
    agroup.removedOnCompletion = NO;
    agroup.fillMode = kCAFillModeForwards;
    
    NSString *animeid  = [NSString stringWithFormat:@"%d",aniid];
    [image.layer addAnimation:agroup forKey:animeid];
    
    
}

-(void)deleteanim:(UIImageView*)image animeid:(int) animeid{
    
    //アニメーション削除
    [image.layer removeAnimationForKey:[NSString stringWithFormat:@"%d",animeid]];
    //サブビュー削除
    [image removeFromSuperview];
}


@end


@interface arrayandid (){}
@property (strong ,nonatomic)NSMutableArray *imagebank;
@property (nonatomic) int id01;


@end
@implementation arrayandid
-(id)init{
    self.id01 =0;
    self.imagebank =[[NSMutableArray alloc]init];
    self.imagebank=[NSMutableArray array];
    return self;
}
-(NSMutableArray*)getbank{return self.imagebank;}
-(int)getid{return self.id01;}
-(void)setid:(int)toid{self.id01=toid;}


@end
