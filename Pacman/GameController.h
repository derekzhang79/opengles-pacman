//
//  GameController.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelManager.h"
#import "Player.h"
#import "Monster.h"

@interface GameController : NSObject <UIAccelerometerDelegate>{
    BOOL isGamePaused;
    NSDate* lastUpdateDate;
    float timeSinceLastUpdate;
}

@property (nonatomic, retain) LevelManager* levelManager;
@property (nonatomic, retain) Player* player;
@property (nonatomic, retain) Monster* monster;
@property int direction;

-(void)startGame;
-(void)update;

@end
