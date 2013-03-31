//
//  PMScene.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 16.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMScene.h"
#import <OpenGLES/ES1/gl.h>

@implementation PMScene

@synthesize backgroundColor;

static id sharedScene = nil;

+ (void)initialize
{
    if (self == [PMScene class]) {
        sharedScene = [[PMScene alloc] init];
    }
}

+ (id)sharedScene{
    return sharedScene;
}

-(void)addLayer:(NSString*)name{
    if(!self.layers){
        self.layers = [[NSMutableDictionary alloc] init];
    }
    PMNode* layer = [[[PMNode alloc] init] autorelease];
    [self.layers setObject:layer forKey:name];
    [self addChild:layer];
}

-(PMNode*)getLayer:(NSString*)name{
    return [self.layers objectForKey:name];
}

-(id)init{
    if(self = [super init]){
         backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(void)render{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
    glClearColor(red, green, blue, alpha);
    glClear(GL_COLOR_BUFFER_BIT);
    [super render];
}

-(void)dealloc{
    [self.backgroundColor release];
    [self.layers release];
    [super dealloc];
}

@end
