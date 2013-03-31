//
//  PMScene.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 16.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMNode.h"

@interface PMScene : PMNode

@property (nonatomic, retain) UIColor* backgroundColor;
@property GLuint texture;
@property GLfloat width;
@property GLfloat height;

@property (nonatomic, retain) NSMutableDictionary* layers;

+(id)sharedScene;

-(void)render;
-(PMNode*)getLayer:(NSString*)name;
-(void)addLayer:(NSString*)name;

@end
