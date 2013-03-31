//
//  PMSprite.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 18.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMSprite.h"
#import "GLView.h"

@implementation PMSprite

-(CGPoint*)texCoords{
    if (texCoords == nil){
        texCoords = [NSMutableData dataWithLength:sizeof(CGPoint)*4];
        [texCoords retain];
    }
    return [texCoords mutableBytes];
}

-(CGPoint*)vertices{
    if (vertexData == nil){
        vertexData = [NSMutableData dataWithLength:sizeof(CGPoint)*4];
        [vertexData retain];
    }
    return [vertexData mutableBytes];
}

-(id)initWithTexture:(PMTexture)texture andCoordsDict:(NSDictionary*)dict inDepth:(int)depth{
    if(self = [super init]){
        
        [self createVerticesFromPoints:4, ccp(0, 0),
                                            ccp(0, [GLView tileSize]),
                                            ccp([GLView tileSize], 0),
                                            ccp([GLView tileSize], [GLView tileSize])];
        
        self.texture = texture;
        
        [self setTextureCoordsByTextureWidth:texture.width textureHeight:texture.height andDict:dict];
    }
    return self;
}

-(void)setTextureCoordsByTextureWidth:(CGFloat)textureWidth textureHeight:(CGFloat)textureHeight andDict:(NSDictionary*)dict{
    CGFloat textureX = [[dict valueForKey:@"x"] floatValue];
    CGFloat textureY = [[dict valueForKey:@"y"] floatValue];
    
    self.texCoords[1] = ccp(textureX/textureWidth, (textureY)/textureHeight);
    self.texCoords[0] = ccp(textureX/textureWidth, (textureY + SPRITE_SIZE)/textureHeight);
    self.texCoords[3] = ccp((textureX + SPRITE_SIZE)/textureWidth, textureY/textureHeight);
    self.texCoords[2] = ccp((textureX +SPRITE_SIZE)/textureWidth, (textureY+SPRITE_SIZE)/textureHeight);
}

-(id)createVerticesFromPoints:(int) num, ...{
    if(self = [super init]){
        
        va_list argptr;
        
        numVertices = num;
        
        va_start( argptr, num );
        for(int i = 0 ; i<num; i++ ){
            self.vertices[i] = va_arg( argptr, CGPoint );
        }
        va_end( argptr );
        
    }
    return self;
}

-(void)updateVerticesForPosition{
    for (int i=0; i<4; i++){
        self.vertices[i].x += self.x - self.prevX;
        self.vertices[i].y += self.y - self.prevY;
    }
    self.prevX = self.x;
    self.prevY = self.y;
}

-(void)render{
    [self updateVerticesForPosition];
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
     
     glLoadIdentity();
     
     glBindTexture(GL_TEXTURE_2D, self.texture.texture);
     glVertexPointer(2, GL_FLOAT, 0, self.vertices);
     glTexCoordPointer(2, GL_FLOAT, 0, self.texCoords);
     glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
     
     glDisableClientState(GL_VERTEX_ARRAY);
     glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    [super render];
}

-(void)dealloc{
    [vertexData release];
    [texCoords release];
    [super dealloc];
}

@end
