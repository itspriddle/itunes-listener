#import "PluginController.h"

WebScriptObject *webScriptObject = nil;

@implementation PluginController

-(id)initWithWebView:(WebView*)w {
	self = [super init];
	srand(time(NULL));

	[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRecieved:) name: @"com.apple.iTunes.playerInfo" object: nil];

	return self;
}

-(void)dealloc {
	[super dealloc];
}

-(void)windowScriptObjectAvailable:(WebScriptObject*)wso {
	[wso setValue:self forKey:@"iTunesListener"];
	webScriptObject = wso;
}


- (void)notificationRecieved:(NSNotification *)notification
{
	[webScriptObject evaluateWebScript:@"itunes_notification_recieved()"];
}

@end
