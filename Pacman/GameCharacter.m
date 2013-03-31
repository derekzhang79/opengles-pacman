//
//  GameCharacter.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "GameCharacter.h"
#import "Monster.h"
#import "GLView.h"

#define SPEED 1

@implementation GameCharacter


@synthesize levelManager;

-(id)initWithSpriteName:(NSString*)name{
    if(self = [super init]){
        PMTexture texture = [[PMTextureLoader sharedLoader] getTexture:@"sprites.png"];
        NSArray* frames = [[PMTextureLoader sharedLoader] getDataForSprite:name];
        self.asset = [[PMAnimatedSprite alloc] initWithTexture:texture andCoordsArray:frames inDepth:1];
        [[[PMScene sharedScene] getLayer:PLAYER_LAYER] addChild:self.asset];
    }
    return self;
}

-(CGPoint)positionPoint{
    return positionPoint;
}

-(void)setPositionPoint:(CGPoint)point{
    positionPoint = point;
    self.asset.x = point.x;
    self.asset.y = point.y;
}

-(void)updateWithDirection:(int)direction{
        CGPoint directionVector = [self directionVectorByDirection:direction];
        if (CGPointEqualToPoint(self.targetPoint, CGPointZero)){
        if ([self canMoveFromPosition:self.positionPoint withDirectionVector:directionVector]){
            self.prevDirectionVector = directionVector;
            self.targetPoint = ccp(positionPoint.x + directionVector.x * [GLView tileSize],
                                   positionPoint.y + directionVector.y * [GLView tileSize]);
            
        }else if ([self canMoveFromPosition:self.positionPoint withDirectionVector:self.prevDirectionVector]){
            self.targetPoint = ccp(positionPoint.x + self.prevDirectionVector.x * [GLView tileSize],
                                   positionPoint.y + self.prevDirectionVector.y * [GLView tileSize]);
            
        }
    }else{
        if([self moveToPoint:self.targetPoint]){
            self.targetPoint = CGPointZero;
            [self performActionsOnTargetPoint];
        }
    }
}

-(void)reset{
    self.targetPoint = CGPointZero;
    self.prevDirectionVector = CGPointZero;
}

-(void)performActionsOnTargetPoint{
}

-(CGPoint)directionVectorByDirection:(int)direction{
    switch (direction) {
        case UP:
                return ccp(0, 1);
            break;
        case DOWN:
                return ccp(0, -1);
            break;
        case LEFT:
                return ccp(-1, 0);
            break;
        case RIGHT:
                return ccp(1, 0);
            break;
        default:
            return ccp(0, 0);
            break;
    }
}

-(BOOL)moveToPoint:(CGPoint)destPoint {
    if (CGPointEqualToPoint(destPoint, self.positionPoint)){
        return true;
    }
    float signX = [self numberSign:(destPoint.x - self.positionPoint.x)];
    float signY = [self numberSign:(destPoint.y - self.positionPoint.y)];
    
    [self setAnimationBySignX:signX andSignY:signY];
    
    float tileSizeIndependentSpeed = (SPEED*([GLView tileSize]/SPRITE_SIZE));
    [self setPositionPoint:ccp(self.positionPoint.x+tileSizeIndependentSpeed*signX,
                               self.positionPoint.y+tileSizeIndependentSpeed*signY)];
    
    return CGPointEqualToPoint(destPoint, self.positionPoint);
}

-(BOOL)canMoveFromPosition:(CGPoint)position withDirectionVector:(CGPoint)direction{
    int destX = position.x/[GLView tileSize] + direction.x;
    int destY = position.y/[GLView tileSize] + direction.y;
    return [self.levelManager isFreeAtX:destX andY:destY];
}

-(int)numberSign:(float)n {
    return (n < 0) ? -1 : (n > 0) ? +1 : 0;
}

-(void)setAnimationBySignX:(int)signX andSignY:(int)signY{
}

-(void)dealloc{
    [self.asset release];
    [super dealloc];
}

@end
