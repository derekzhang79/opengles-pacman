//
//  Player.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)init{
    if(self = [super initWithSpriteName:PACMAN_UP]){
        
    }
    return self;
}

-(void)setAnimationBySignX:(int)signX andSignY:(int)signY{
    if(signY>0){
        [self.asset playAnimationByName:PACMAN_UP];
    }else if(signY<0){
        [self.asset playAnimationByName:PACMAN_DOWN];
    }
    if(signX>0){
        [self.asset playAnimationByName:PACMAN_RIGHT];
    }else if(signX<0){
        [self.asset playAnimationByName:PACMAN_LEFT];
    }
}

-(void)performActionsOnTargetPoint{
    [self.levelManager collectPelletAtPoint:ccp(self.asset.x, self.asset.y)];
}

@end
