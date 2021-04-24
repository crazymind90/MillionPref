// By @CrazyMind90


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wprotocol"
#pragma GCC diagnostic ignored "-Wmacro-redefined"
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wincomplete-implementation"
#pragma GCC diagnostic ignored "-Wunknown-pragmas"
#pragma GCC diagnostic ignored "-Wformat"
#pragma GCC diagnostic ignored "-Wunused-function"

@interface UIView (MillionPref)
-(UIViewController *) NearestViewController;
-(NSMutableArray *) allSubViews;
@end

@implementation UIView (MillionPref)
- (UIViewController *) NearestViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];
    return (UIViewController *)responder;
}

- (NSMutableArray *) allSubViews {

   NSMutableArray *arr= [[NSMutableArray alloc] init];
   [arr addObject:self];
   for (UIView *subview in self.subviews)
   {
     [arr addObjectsFromArray:(NSArray*)[subview allSubViews]];
   }
   return arr;
}

@end



@interface CMManager : UIViewController

+(void) ActivateTheFollowingCodeAfter:(float)Sleep handler:(void(^_Nullable)(void))handler;
 @end

@implementation CMManager

+(void) ActivateTheFollowingCodeAfter:(float)Sleep handler:(void(^_Nullable)(void))handler {

     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

         [NSThread sleepForTimeInterval:Sleep];

         dispatch_async(dispatch_get_main_queue(), ^{


             handler();

         });

     });

 }

 @end


static UIViewController *_topMostController(UIViewController *cont) {
    // By @BandarHL
    UIViewController *topController = cont;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    if ([topController isKindOfClass:[UINavigationController class]]) {
        UIViewController *visible = ((UINavigationController *)topController).visibleViewController;
        if (visible) {
            topController = visible;
        }
    }
    return (topController != cont ? topController: nil);
}
static UIViewController *topMostController() {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *next = nil;
    while ((next = _topMostController(topController)) != nil) {
        topController = next;
    }
    return topController;
}



BOOL DownloadLink(NSString *DownloadLink ,NSString *ToPath) {

      NSString *stringURL = DownloadLink;
      NSURL  *url = [NSURL URLWithString:stringURL];
      NSData *urlData = [NSData dataWithContentsOfURL:url];

    static bool Success;

      if (urlData) {

          NSString *DownName = [DownloadLink lastPathComponent];
          NSString *Download = [ToPath stringByAppendingPathComponent:DownName];

          NSString  *filePath = [NSString stringWithFormat:@"%@",Download];
          Success = [urlData writeToFile:filePath atomically:YES];

    }

    return Success;
}


NSString *AnswerOfQuestion(NSString *Question) {

NSString *RightAnswer = nil;
NSString *File = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/result_S.json",NSHomeDirectory()] encoding:NSUTF8StringEncoding error:nil];

NSData *_Data = [File dataUsingEncoding:NSUTF8StringEncoding];
NSMutableDictionary *Dictionay = [NSJSONSerialization JSONObjectWithData:_Data options:0 error:nil];

for (NSMutableDictionary *EachDictionary in Dictionay) {

    for (NSMutableDictionary *EachDiction in EachDictionary) {

        if ([[EachDiction objectForKey:@"quest"] isEqual:Question])

            RightAnswer = [EachDiction objectForKey:@"rightanswer"];

    }
  }

  return RightAnswer;
}

%hook UIApplication
-(void)finishedTest:(id)arg1 extraResults:(id)arg2 {

  %orig;

if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Library/result_S.json",NSHomeDirectory()]])
DownloadLink(@"https://crazy90.com/Crazy/Files/result_S.json",[NSString stringWithFormat:@"%@/Library",NSHomeDirectory()]);

}

%end


%hook Million


NSString *Question = nil;

-(void)nextQuestionButton:(id)arg {

NSMutableArray *MutArray = [[NSMutableArray  alloc] init];

  %orig;

  [CMManager ActivateTheFollowingCodeAfter:0.10 handler:^{

  for (UIView *view in [topMostController().view allSubViews]) {

  if ([view isKindOfClass:[UILabel class]]) {

  UILabel *Label = (UILabel *)view;

  if (Label.text)
  [MutArray addObject:Label.text];

   }
 }

}];

  [CMManager ActivateTheFollowingCodeAfter:0.20 handler:^{

  for (UIView *view in [topMostController().view allSubViews]) {

  if ([view isKindOfClass:[UILabel class]]) {

  UILabel *Label = (UILabel *)view;

  if ([Label.text containsString:@"$"]) {

  if (Label.text.length > 6) {
  NSUInteger GetRealLength = [Label.text length];
  NSUInteger GetRealValue = GetRealLength - 6;
  Label.text = [Label.text substringWithRange:NSMakeRange(0, GetRealValue)];
  }

  Label.text = [NSString stringWithFormat:@"%@ | CM: %@",Label.text,AnswerOfQuestion([MutArray objectAtIndex:2])];


       }
     }
   }

}];

}


%end



%ctor {

  %init(Million = objc_getClass("_TtC14المليون10MainPageVC"));
};















































//
