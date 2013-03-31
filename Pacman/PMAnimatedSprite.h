//
//  PMAnimatedSprite.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 24.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMSprite.h"

@interface PMAnimatedSprite : PMSprite

@property (nonatomic, retain) NSArray* animationArray;
@property int currentFrame;
@property NSTimeInterval lastKeyframeTime;

-(id)initWithTexture:(PMTexture)texture andCoordsArray:(NSArray*)array inDepth:(int)depth;
-(void)playAnimationByName:(NSString*)name;

@end
