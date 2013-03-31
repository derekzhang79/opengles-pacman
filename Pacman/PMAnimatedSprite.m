//
//  PMAnimatedSprite.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 24.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMAnimatedSprite.h"
#import "PMTextureLoader.h"

@implementation PMAnimatedSprite

-(id)initWithTexture:(PMTexture)texture andCoordsArray:(NSArray *)array inDepth:(int)depth{
    if(self = [super initWithTexture:texture andCoordsDict:array[0] inDepth:depth]){
        self.animationArray = array;
        self.lastKeyframeTime = [NSDate timeIntervalSinceReferenceDate];
    }
    return self;
}

-(void)updateFrame{
    NSTimeInterval timeSinceLastKeyFrame = [NSDate timeIntervalSinceReferenceDate] - self.lastKeyframeTime;
    if (timeSinceLastKeyFrame > ANIMATION_DURATION) {
        self.currentFrame++;
        if(self.currentFrame >= [self.animationArray count]){
            self.currentFrame = 0;
        }
        [super setTextureCoordsByTextureWidth:self.texture.width textureHeight:self.texture.height andDict:self.animationArray[self.currentFrame]];
        timeSinceLastKeyFrame = timeSinceLastKeyFrame - ANIMATION_DURATION;
        self.lastKeyframeTime = [NSDate timeIntervalSinceReferenceDate];
    }
}

-(void)playAnimationByName:(NSString*)name{
    self.animationArray = [[PMTextureLoader sharedLoader] getDataForSprite:name];
    if(self.currentFrame <= [self.animationArray count]){
        [super setTextureCoordsByTextureWidth:self.texture.width textureHeight:self.texture.height andDict:self.animationArray[self.currentFrame]];
    }
}

-(void)render{
    [self updateFrame];
    [super render];
}

-(void)dealloc{
    [self.animationArray release];
    [super dealloc];
}

@end
