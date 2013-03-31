//
//  GameController.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "GameController.h"
#import "GLView.h"

@implementation GameController

-(id)init{
    if(self = [super init]){
        lastUpdateDate = [[NSDate alloc] init];
        timeSinceLastUpdate = 0.0;
        self.levelManager = [[LevelManager alloc] init];
        self.player = [[Player alloc] init];
        self.monster = [[Monster alloc] init];
        self.player.levelManager = self.levelManager;
        self.monster.levelManager = self.levelManager;
        UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
        accel.delegate = self;
        accel.updateInterval = 1.0f/10.0f;
    }
    return self;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer
		didAccelerate:(UIAcceleration *)acceleration {
    if(fabs(acceleration.y)> fabs(acceleration.x)){
        if (acceleration.y>0) {
            self.direction = UP;
        }else{
            self.direction = DOWN;
        }
    }else{
        if (acceleration.x>0) {
            self.direction = RIGHT;
        }else{
            self.direction = LEFT;
        }
    }
}

-(void)setMonsterAndPlayerPositions{
    [self.player setPositionPoint:ccp([GLView tileSize]*self.levelManager.playerPoint.x,
                                      [GLView tileSize]*self.levelManager.playerPoint.y)];
    [self.monster setPositionPoint:ccp([GLView tileSize]*self.levelManager.monsterPoint.x,
                                       [GLView tileSize]*self.levelManager.monsterPoint.y)];
}

-(void)startGame{
    [self.levelManager loadLevelFromFile:@"level"];
    [self setMonsterAndPlayerPositions];
}

-(void)restartGame{
    [self.levelManager clearLevel];
    [self.levelManager loadLevelFromFile:@"level"];
    [self.player reset];
    [self.monster reset];
    [self setMonsterAndPlayerPositions];
}

-(void)update{
    if (!isGamePaused)
    {
        NSDate *newDate = [NSDate date];
        timeSinceLastUpdate += [newDate timeIntervalSinceDate:lastUpdateDate];
        
        while (timeSinceLastUpdate > 1.0/60.0){
            [self updateGame];
            timeSinceLastUpdate -= 1.0/60.0;
        }
        [lastUpdateDate release];
        lastUpdateDate = [newDate retain];
    }
}

-(void)updateGame{
    [self.player updateWithDirection:self.direction];
    [self.monster update];
    if(CGRectIntersectsRect(CGRectMake(self.monster.positionPoint.x, self.monster.positionPoint.y, [GLView tileSize], [GLView tileSize]),
                            CGRectMake(self.player.positionPoint.x, self.player.positionPoint.y, [GLView tileSize], [GLView tileSize]))){
        [self restartGame];
    }
    if([self.levelManager.pellets count] == 0){
        [self restartGame];
    }
}

-(void)dealloc{
    [self.monster release];
    [self.player release];
    [self.levelManager release];
    [lastUpdateDate release];
    [super dealloc];
}

@end
