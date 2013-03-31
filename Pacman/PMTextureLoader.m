//
//  PMTextureLoader.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 20.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "PMTextureLoader.h"
#import <SBJson/SBJson.h>

@implementation PMTextureLoader

static id sharedLoader = nil;

+ (void)initialize
{
    if (self == [PMTextureLoader class]) {
        sharedLoader = [[PMTextureLoader alloc] init];
    }
}

+ (id)sharedLoader{
    return sharedLoader;
}

-(id)init{
    if(self = [super init]){
        self.textures = [[NSMutableDictionary alloc] init];
    }
    return  self;
}

-(void)loadTextureDesc:(NSString*)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    SBJsonParser *jsonParser = [[[SBJsonParser alloc] init] autorelease];
    self.textureDesc = [jsonParser objectWithString:jsonString];
}

-(id)getDataForSprite:(NSString *)name{
    return [self.textureDesc valueForKey:name];
}

- (void)loadTexture:(NSString*)fileName {
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }

    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    CGContextRelease(spriteContext);

    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    free(spriteData);

    PMTexture texture = {.texture = texName, .width = width, .height = height};
    
    NSValue*textureValue =[NSValue valueWithBytes:&texture objCType:@encode(PMTexture)];

    [self.textures setValue:textureValue forKey:fileName];
}

-(PMTexture)getTexture:(NSString*)name{
    NSValue* valueForStruct = [self.textures objectForKey:name];
    PMTexture texture;
    [valueForStruct getValue:&texture];
    return texture;
}

-(void)dealloc{
    [self.textures release];
    [self.textureDesc release];
    [super dealloc];
}

@end
