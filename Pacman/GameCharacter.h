//
//  GameCharacter.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMAnimatedSprite.h"
#import "PMTextureLoader.h"
#import "PMScene.h"
#import "LevelManager.h"

@interface GameCharacter : NSObject{
    CGPoint positionPoint;
}

@property (nonatomic, retain) PMAnimatedSprite* asset;
@property (nonatomic, assign) LevelManager* levelManager;

@property CGPoint prevDirectionVector;
@property CGPoint targetPoint;

-(id)initWithSpriteName:(NSString*)name;
-(void)setPositionPoint:(CGPoint)point;
-(void)updateWithDirection:(int)direction;
-(CGPoint)positionPoint;
-(void)setAnimationBySignX:(int)signX andSignY:(int)signY;
-(CGPoint)directionVectorByDirection:(int)direction;
-(BOOL)canMoveFromPosition:(CGPoint)position withDirectionVector:(CGPoint)direction;
-(void)performActionsOnTargetPoint;
-(void)reset;
@end
