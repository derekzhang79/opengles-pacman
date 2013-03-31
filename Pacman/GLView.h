//
//  GLView.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 15.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "PMScene.h"
#import "PMNode.h"
#import "GameController.h"

@interface GLView : UIView
{
@private
    EAGLContext* context;
    float timestamp;
}

@property (nonatomic, retain) GameController* gameController;

-(void)drawView:(CADisplayLink*) displayLink;
+ (int)tileSize;
+ (void)setTileSize:(int)size;

@end
