
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenAIRequestManager : NSViewController <NSTextFieldDelegate>

@property (strong, nonatomic) IBOutlet NSTextField *questionField;
@property (strong, nonatomic) IBOutlet NSTextField *answerField;
@property (nonatomic, assign) NSInteger maxTokens;

- (IBAction)backButtonPressed:(id)sender;

- (IBAction)askButtonPressed:(id)sender;

- (void)generateRequestWithPrompt:(NSString *)prompt completionHandler:(void (^)(NSDictionary * _Nullable response, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END


