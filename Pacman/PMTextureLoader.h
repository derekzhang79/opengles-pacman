//
//  PMTextureLoader.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 20.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMTextureLoader : NSObject

@property (nonatomic, retain) NSMutableDictionary* textures;
@property (nonatomic, retain) NSMutableDictionary* textureDesc;

+(id)sharedLoader;

-(PMTexture)getTexture:(NSString*)name;
-(id)getDataForSprite:(NSString*)name;
- (void)loadTexture:(NSString *)fileName;
-(void)loadTextureDesc:(NSString*)fileName;
@end
