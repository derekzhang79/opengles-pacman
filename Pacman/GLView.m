//
//  GLView.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 15.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "GLView.h"
#import "PMSprite.h"
#import "PMAnimatedSprite.h"
#import "PMTextureLoader.h"
#import <SBJson/SBJson.h>
#import "GameController.h"

@implementation GLView

static CGFloat tileSize;

+(Class)layerClass{
    return [CAEAGLLayer class];
}

+ (int)tileSize { return tileSize; }
+ (void)setTileSize:(int)size { tileSize = size; }

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        CAEAGLLayer * eaglLayer = (CAEAGLLayer*) super.layer;
        eaglLayer.opaque = YES;
        
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context]){
            [self release];
            return nil;
        }
        GLfloat screenWidth = CGRectGetWidth(frame);
        GLfloat screenHeight = CGRectGetHeight(frame);
        
        //calculating tileSize for different screen sizes, 
        [GLView setTileSize:screenHeight/NUMBER_OF_VERTICAL_TILES];
        float gameSceneWidth = NUMBER_OF_HORIZONTAL_TILES*[GLView tileSize];
        [[PMScene sharedScene] setX:(screenWidth/2)-(gameSceneWidth)/2];
        
        GLuint framebuffer, renderbuffer;
        
        glGenFramebuffersOES(1, &framebuffer);
        glGenRenderbuffersOES(1, &renderbuffer);
        
        glBindFramebufferOES(GL_FRAMEBUFFER_OES, framebuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderbuffer);
        [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, renderbuffer);
        
        glViewport(0, 0, screenWidth, screenHeight);
        glMatrixMode(GL_PROJECTION);
        glOrthof(0, screenWidth, 0, screenHeight, 1.0, -1.0);
        glMatrixMode(GL_MODELVIEW);
        
        glEnable(GL_TEXTURE_2D);
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glEnable(GL_BLEND);
        
        glEnable(GL_DEPTH_TEST);
        glDepthFunc(GL_LEQUAL);
        
        [[PMTextureLoader sharedLoader] loadTexture:@"sprites.png"];
        [[PMTextureLoader sharedLoader] loadTextureDesc:@"spritesDesc"];
        
        [[PMScene sharedScene] addLayer:BACKGROUND_LAYER];
        [[PMScene sharedScene] addLayer:PELLET_LAYER];
        [[PMScene sharedScene] addLayer:PLAYER_LAYER];
        
        [self drawView: nil];
        timestamp = CACurrentMediaTime();
        CADisplayLink* displayLink;
        displayLink = [CADisplayLink displayLinkWithTarget:self
                                                  selector:@selector(drawView:)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        self.gameController = [[GameController alloc] init];
        [self.gameController startGame];
    }
    return self;
}

-(void)drawView:(CADisplayLink*) displayLink{
    
    [self.gameController update];
    [[PMScene sharedScene] render];
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

-(void)dealloc{
    if([EAGLContext currentContext] == context){
        [EAGLContext setCurrentContext:nil];
    }
    [self.gameController release];
    [context release];
    [super dealloc];
}

@end
