//
//  PMSprite.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 18.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMNode.h"

@interface PMSprite : PMNode {
    NSMutableData *vertexData;
    NSMutableData *texCoords;
    @private
    int numVertices;
}

-(id)initWithTexture:(PMTexture)texture andCoordsDict:(NSDictionary*)dict inDepth:(int)depth;
-(void)setTextureCoordsByTextureWidth:(CGFloat)textureWidth textureHeight:(CGFloat)textureHeight andDict:(NSDictionary*)dict;

@property float prevX;
@property float prevY;

@property PMTexture texture;
@property (readonly) CGPoint *texCoords;
@property (readonly) CGPoint *vertices;

@end
