
#import <Foundation/Foundation.h>
#import "OpenAIRequestManager.h"

@implementation OpenAIRequestManager

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self adjustTextField:self.questionField];
    
    [self adjustTextField:self.answerField];
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
}

- (void)adjustTextField:(NSTextField *)textField {
    textField.cell.wraps = YES;
    textField.cell.scrollable = YES;
    textField.cell.truncatesLastVisibleLine = YES;
}

static NSString *const kEndpoint = @"https://api.openai.com/v1/completions";
static NSString *const kModelName = @"gpt-3.5-turbo-instruct";

- (void)generateRequestWithPrompt:(NSString *)prompt completionHandler:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completionHandler {
    
    NSURL *url = [NSURL URLWithString:kEndpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *apiKey = [[[NSProcessInfo processInfo] environment] objectForKey:@"OPENAI_API_KEY"];
    if (!apiKey) {
        NSLog(@"OPENAI_API_KEY environment variable not set.");
        return;
    }
    [request setValue:[NSString stringWithFormat:@"Bearer %@", apiKey] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *body = @{
        @"prompt": prompt,
        @"max_tokens": @(200),
        @"temperature": @(0.7),
        @"top_p": @(1.0),
        @"n": @(1),
        @"stop": @"",
        @"model": kModelName
    };
    
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    [request setHTTPBody:requestData];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0; // Set a reasonable timeout interval
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completionHandler(nil, jsonError);
            return;
        }
        
        NSLog(@"Response: %@", json);
        
        completionHandler(json, nil);
    }];
    
    [task resume];
}

- (IBAction)askButtonPressed:(id)sender {
    NSString *prompt = self.questionField.stringValue;
    
    NSLog(@"Prompt: %@", prompt);
    
    [self generateRequestWithPrompt:prompt completionHandler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error generating request: %@", error.localizedDescription);
            return;
        }
        
        NSArray *choices = response[@"choices"];
        if ([choices isKindOfClass:[NSArray class]] && choices.count > 0) {
            NSString *answer = choices[0][@"text"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.answerField.stringValue = answer;
            });
        } else {
            NSLog(@"Invalid response format: %@", response);
        }
    }];
}

- (IBAction)backButtonPressed:(id)sender {
}

@end









