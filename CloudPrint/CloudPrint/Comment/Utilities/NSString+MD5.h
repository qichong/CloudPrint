//
//  NSString+MD5.h
//  LastHistory
//
//  Created by Frederik Seiffert on 28.11.08.
//  Copyright 2008 Frederik Seiffert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString (MD5)

- (NSString *)md5;
+ (NSData *)desData:(NSData *)data key:(NSString *)keyString CCOperation:(CCOperation)op;
//3des+base64
+ (NSString *)tripleDES:(NSString*)dataString encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;

@end

@interface UIColor (Color)

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end


@interface UIColor (Document)

+ (NSString *)documentsDirectory;

@end
