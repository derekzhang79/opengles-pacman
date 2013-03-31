//
//  Monster.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "Monster.h"

@implementation Monster

-(id)init{
    if(self = [super initWithSpriteName:PINKY_UP]){
        
    }
    return self;
}

-(void)update{
    [super updateWithDirection:monsterDirection];
}

-(void)performActionsOnTargetPoint{
    if([self canMoveInDirection:[self rotationRight]]){
        monsterDirection = [self rotationRight];
    }else{
        if(![self canMoveInDirection:monsterDirection]){
            if([self canMoveInDirection:[self rotationLeft]]){
                monsterDirection = [self rotationLeft];
            }else{
                monsterDirection = [self rotationLeft];
                monsterDirection = [self rotationLeft];
            }
        }
    }
}

-(int)rotationRight{
    int rotation = monsterDirection+1;
    if(rotation>3){
        rotation = 0;
    }
    return rotation;
}

-(int)rotationLeft{
    int rotation = monsterDirection-1;
    if(rotation<0){
        rotation = 3;
    }
    return rotation;
}


-(BOOL)canMoveInDirection:(int)direction{
    CGPoint directionVector = [super directionVectorByDirection:direction];
    return [super canMoveFromPosition:positionPoint withDirectionVector:directionVector];
}

-(void)setAnimationBySignX:(int)signX andSignY:(int)signY{
    if(signY>0){
        [self.asset playAnimationByName:PINKY_UP];
    }else if(signY<0){
        [self.asset playAnimationByName:PINKY_DOWN];
    }
    
    if(signX>0){
        [self.asset playAnimationByName:PINKY_RIGHT];
    }else if(signX<0){
        [self.asset playAnimationByName:PINKY_LEFT];
    }
}

@end
