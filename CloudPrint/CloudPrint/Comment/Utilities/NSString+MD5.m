//
//  NSString+MD5.m
//  LastHistory
//
//  Created by Frederik Seiffert on 28.11.08.
//  Copyright 2008 Frederik Seiffert. All rights reserved.
//

#import "NSString+MD5.h"
#import "GTMBase64.h"       

@implementation NSString (MD5)

- (NSString *)md5
{
	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5(cStr, strlen(cStr), result);
	
	NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[resultStr appendFormat:@"%02x", result[i]];
	}
	return [[resultStr copy] autorelease];
}

+ (NSData *)desData:(NSData *)data key:(NSString *)keyString CCOperation:(CCOperation)op
{
	// Byte *buffer;
	char buffer [1024] ;
	memset(buffer, 0, sizeof(buffer));
	// memset(buffer, 0, 1024);
	size_t bufferNumBytes;
	CCCryptorStatus cryptStatus = CCCrypt(op, 
										  
										  kCCAlgorithmDES, 
										  
										  kCCOptionPKCS7Padding | kCCOptionECBMode,
										  
										  [keyString UTF8String], 
										  
										  kCCKeySizeDES,
										  
										  NULL, 
										  
										  [data bytes], 
										  
										  [data length],
										  
										  buffer, 
										  
										  1024,
										  
										  &bufferNumBytes);
	if(cryptStatus == kCCSuccess)
	{
		NSData *returnData = [NSData dataWithBytes:buffer length:bufferNumBytes];
		return returnData;
		// NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding]autorelease];
	}
	NSLog(@"des failed！");
	return nil;
	
}


+ (NSString *)tripleDES:(NSString*)dataString encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key 
{
    const void *vdataString;
    size_t dataStringBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData = [GTMBase64 decodeData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
        dataStringBufferSize = [EncryptData length];
        vdataString = [EncryptData bytes];
    }
    else
    {
        NSData* data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        dataStringBufferSize = [data length];
        vdataString = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (dataStringBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    //    NSString *key = @"123456789012345678901234";
    NSString *initVec = @"init Vec";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySize3DES,
                       vinitVec, //"init Vec", //iv,
                       vdataString, //"Your Name", //dataString,
                       dataStringBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
	 else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
	 else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
	 else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
	 else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
	 else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr 
                                                                length:(NSUInteger)movedBytes] 
                                        encoding:NSUTF8StringEncoding] 
                  autorelease];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
} 

/*
调用示例代码

NSString* req = @"234234234234234中国";
NSString* key = @"888fdafdakfjak;";

NSString* ret1 = [NSString TripleDES:req encryptOrDecrypt:kCCEncrypt key:key];        
NSLog(@"3DES/Base64 Encode Result=%@", ret1);

NSString* ret2 = [NSString TripleDES:ret1 encryptOrDecrypt:kCCDecrypt key:key];
NSLog(@"3DES/Base64 Decode Result=%@", ret2);
*/

@end


@implementation UIColor (Color)

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert{
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	if([cString length]==3){
		
		NSString *c1 = [cString substringWithRange:NSMakeRange(0,1)];
		NSString *c2 = [cString substringWithRange:NSMakeRange(1,1)];
		NSString *c3 = [cString substringWithRange:NSMakeRange(2,1)];
		
		cString = [NSString stringWithFormat:@"%@%@%@%@%@%@",c1,c1,c2,c2,c3,c3,nil];
	}
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return [UIColor blackColor];
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
		if ([cString length] != 6) return [UIColor blackColor];
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}

//颜色转字符串
- (NSMutableArray *) changeUIColorToRGB:(UIColor *)color {
    const CGFloat *cs = CGColorGetComponents(color.CGColor);
    
    NSString *r = [NSString stringWithFormat:@"%@", [self ToHex:cs[0] * 255]];
    NSString *g = [NSString stringWithFormat:@"%@", [self ToHex:cs[1] * 255]];
    NSString *b = [NSString stringWithFormat:@"%@", [self ToHex:cs[2] * 255]];
    return [NSString stringWithFormat:@"#%@%@%@", r, g, b];
}

//十进制转十六进制
- (NSString *)ToHex:(int)tmpid {
    NSString *endtmp = @"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig = tmpid % 16;
    int tmp = tmpid / 16;
    switch (ttmpig) {
                case 10:
                    nLetterValue = @"A"; break;
                case 11:
                    nLetterValue = @"B"; break;
                case 12:
                    nLetterValue = @"C"; break;
                case 13:
                    nLetterValue = @"D"; break;
                case 14:
                    nLetterValue = @"E"; break;
                case 15:
                    nLetterValue = @"F"; break;
                default:nLetterValue = [[NSString alloc] initWithFormat:@"%i", ttmpig];
        }
    switch (tmp) {
                case 10:
                    nStrat = @"A"; break;
                case 11:
                    nStrat = @"B"; break;
                case 12:
                    nStrat = @"C"; break;
                case 13:
                    nStrat = @"D"; break;
                case 14:
                    nStrat = @"E"; break;  
                case 15:  
                    nStrat = @"F"; break;  
                default:nStrat = [[NSString alloc] initWithFormat:@"%i", tmp];  
        }  
    endtmp = [[NSString alloc] initWithFormat:@"%@%@", nStrat, nLetterValue];  
    return endtmp;  
}

@end

@implementation UIColor (Document)
+ (NSString *)documentsDirectory{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documents = [paths objectAtIndex:0];
	
	return documents;
}



@end