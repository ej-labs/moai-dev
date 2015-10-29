//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc. 
// All Rights Reserved. 
// http://getmoai.com
//----------------------------------------------------------------//

#import <aku/AKU.h>
#import "MoaiVC.h"
#import "MoaiView.h"

extern "C" {
    #include <lua.h>
    #include <lauxlib.h>
    #include <lualib.h>
}

#define TRANSFER_SERVICE_UUID @"F457370D-61BC-47A5-8272-99A5584FC554"
#define TRANSFER_CHARACTERISTIC_UUID @"38224EC1-942E-419D-8068-985ED77392D2"

const UInt8 BLUETOOTH_CODE_TOUCH_DOWN = 1;
const UInt8 BLUETOOTH_CODE_TOUCH_UP = 2;
const UInt8 BLUETOOTH_CODE_SWIPE_UP = 3;
const UInt8 BLUETOOTH_CODE_SWIPE_DOWN = 4;
const UInt8 BLUETOOTH_CODE_SWIPE_LEFT = 5;
const UInt8 BLUETOOTH_CODE_SWIPE_RIGHT = 6;
const UInt8 BLUETOOTH_CODE_SELECT_BUTTON = 7;
const UInt8 BLUETOOTH_CODE_MENU_BUTTON = 8;
const UInt8 BLUETOOTH_CODE_PLAY_PAUSE_BUTTON = 9;
const UInt8 BLUETOOTH_CODE_DISCONNECT = 253;
const UInt8 BLUETOOTH_CODE_HELLO = 254;


//================================================================//
// MoaiVC ()
//================================================================//
@interface MoaiVC ()
{
//    UISwipeGestureRecognizer *_leftSwipeGestureRecognizer;
//    UISwipeGestureRecognizer *_rightSwipeGestureRecognizer;
//    UISwipeGestureRecognizer *_upSwipeGestureRecognizer;
//    UISwipeGestureRecognizer *_downSwipeGestureRecognizer;
}

@property (strong, nonatomic) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *upSwipeGestureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *downSwipeGestureRecognizer;

//@property (strong, nonatomic) UITapGestureRecognizer *leftTapGestureRecognizer;
//@property (strong, nonatomic) UITapGestureRecognizer *rightTapGestureRecognizer;
//@property (strong, nonatomic) UITapGestureRecognizer *upTapGestureRecognizer;
//@property (strong, nonatomic) UITapGestureRecognizer *downTapGestureRecognizer;

//@property (strong, nonatomic) UITapGestureRecognizer *leftTapGestureRecognizer;
//@property (strong, nonatomic) UITapGestureRecognizer *rightTapGestureRecognizer;
//@property (strong, nonatomic) UITapGestureRecognizer *upTapGestureRecognizer;
//@property (strong, nonatomic) UITapGestureRecognizer *downTapGestureRecognizer;


@property (strong, nonatomic) CBCentralManager *centralManager;
//@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;

@property (strong, nonatomic) NSMutableArray *discoveredPeripherals;

	//----------------------------------------------------------------//
	-( void ) updateOrientation :( UIInterfaceOrientation )orientation;

//- (void)handleLeftTapFrom:(UITapGestureRecognizer *)recognizer;
//- (void)handleRightTapFrom:(UITapGestureRecognizer *)recognizer;
//- (void)handleUpTapFrom:(UITapGestureRecognizer *)recognizer;
//- (void)handleDownTapFrom:(UITapGestureRecognizer *)recognizer;

@end

//================================================================//
// MoaiVC
//================================================================//
@implementation MoaiVC

	//----------------------------------------------------------------//
	-( void ) willRotateToInterfaceOrientation :( UIInterfaceOrientation )toInterfaceOrientation duration:( NSTimeInterval )duration {
		
		[ self updateOrientation:toInterfaceOrientation ];
	}

	//----------------------------------------------------------------//
	- ( id ) init {
	
		self = [ super init ];
		if ( self ) {
            
		}
		return self;
	}

	//----------------------------------------------------------------//
	- ( BOOL ) shouldAutorotateToInterfaceOrientation :( UIInterfaceOrientation )interfaceOrientation {
		
        /*
            The following block of code is used to lock the sample into a Portrait orientation, skipping the landscape views as you rotate your device.
            To complete this feature, you must specify the correct Portraits as the only supported orientations in your plist under the setting,
                "Supported Device Orientations"
         */
        
        if (( interfaceOrientation == UIInterfaceOrientationPortrait ) || ( interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )) {
            return true;
        }
        
        return false;
        
        /*
            The following is used to support all view orientations.
         */
        
        //return true;
	}
	
	//----------------------------------------------------------------//
	-( void ) updateOrientation :( UIInterfaceOrientation )orientation {
		
//		MoaiView* view = ( MoaiView* )self.view;        
//		
//		if (( orientation == UIInterfaceOrientationPortrait ) || ( orientation == UIInterfaceOrientationPortraitUpsideDown )) {
//            
//            if ([ view akuInitialized ] != 0 ) {
//                AKUSetOrientation ( AKU_ORIENTATION_PORTRAIT );
//                AKUSetViewSize (( int )view.width, ( int )view.height );
//            }
//		}
//		else if (( orientation == UIInterfaceOrientationLandscapeLeft ) || ( orientation == UIInterfaceOrientationLandscapeRight )) {
//            if ([ view akuInitialized ] != 0 ) {
//                AKUSetOrientation ( AKU_ORIENTATION_LANDSCAPE );
//                AKUSetViewSize (( int )view.height, ( int )view.width);
//            }
//		}
	}

//#pragma mark - Swipe Gestures

- (void)addSwipeAndTapGestureRecognizers {
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeFrom:)];
    [self.leftSwipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeFrom:)];
    [self.rightSwipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    self.upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleUpSwipeFrom:)];
    [self.upSwipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:self.upSwipeGestureRecognizer];
    
    self.downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleDownSwipeFrom:)];
    [self.downSwipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:self.downSwipeGestureRecognizer];
    
//    self.leftTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftTapFrom:)];
//    self.leftTapGestureRecognizer.allowedPressTypes = @[@(UIPressTypeLeftArrow)];
//    self.leftTapGestureRecognizer.cancelsTouchesInView = NO;
////    self.leftTapGestureRecognizer.delaysTouchesBegan = YES;
////    self.leftTapGestureRecognizer.delaysTouchesEnded = NO;
//    [self.view addGestureRecognizer:self.leftTapGestureRecognizer];
//    
//    self.rightTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightTapFrom:)];
//    self.rightTapGestureRecognizer.allowedPressTypes = @[@(UIPressTypeRightArrow)];
//    self.rightTapGestureRecognizer.cancelsTouchesInView = NO;
////    self.rightTapGestureRecognizer.delaysTouchesBegan = YES;
////    self.rightTapGestureRecognizer.delaysTouchesEnded = NO;
//    [self.view addGestureRecognizer:self.rightTapGestureRecognizer];
//    
//    self.upTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleUpTapFrom:)];
//    self.upTapGestureRecognizer.allowedPressTypes = @[@(UIPressTypeUpArrow)];
//    self.upTapGestureRecognizer.cancelsTouchesInView = NO;
////    self.upTapGestureRecognizer.delaysTouchesBegan = YES;
////    self.upTapGestureRecognizer.delaysTouchesEnded = NO;
//    [self.view addGestureRecognizer:self.upTapGestureRecognizer];
//    
//    self.downTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDownTapFrom:)];
//    self.downTapGestureRecognizer.allowedPressTypes = @[@(UIPressTypeDownArrow)];
//    self.downTapGestureRecognizer.cancelsTouchesInView = NO;
////    self.downTapGestureRecognizer.delaysTouchesBegan = YES;
////    self.downTapGestureRecognizer.delaysTouchesEnded = NO;
//    [self.view addGestureRecognizer:self.downTapGestureRecognizer];
}

- (void)sendDirectionSignalWithSensorId:(MoaiInputDeviceSensorId)sensorId {
    bool buttonPressed = true;
    AKUEnqueueButtonEvent(MoaiInputDeviceId::MoaiInputDeviceIdTvRemote, sensorId, buttonPressed);
    buttonPressed = false;
    AKUEnqueueButtonEvent(MoaiInputDeviceId::MoaiInputDeviceIdTvRemote, sensorId, buttonPressed);
}

- (void)handleLeftSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Left Swipe");
    [self sendDirectionSignalWithSensorId:MoaiInputDeviceSensorIdSwipeLeft];
}

- (void)handleRightSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Right Swipe");
    [self sendDirectionSignalWithSensorId:MoaiInputDeviceSensorIdSwipeRight];
}

- (void)handleUpSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Up Swipe");
    [self sendDirectionSignalWithSensorId:MoaiInputDeviceSensorIdSwipeUp];
}

- (void)handleDownSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Down Swipe");
    [self sendDirectionSignalWithSensorId:MoaiInputDeviceSensorIdSwipeDown];
}

//- (void)handleLeftTapFrom:(UITapGestureRecognizer *)recognizer {
//    NSLog(@"Left tap.");
//    [self sendDirectionSignalWithSensorId:(MoaiInputDeviceSensorIdLeftArrow)];
//}
//
//- (void)handleRightTapFrom:(UITapGestureRecognizer *)recognizer {
//    NSLog(@"Right tap.");
//    [self sendDirectionSignalWithSensorId:(MoaiInputDeviceSensorIdRightArrow)];
//}
//
//- (void)handleUpTapFrom:(UITapGestureRecognizer *)recognizer {
//    NSLog(@"Up tap.");
//    [self sendDirectionSignalWithSensorId:(MoaiInputDeviceSensorIdUpArrow)];
//}
//
//- (void)handleDownTapFrom:(UITapGestureRecognizer *)recognizer {
//    NSLog(@"Down tap.");
//    [self sendDirectionSignalWithSensorId:(MoaiInputDeviceSensorIdDownArrow)];
//}


#pragma mark - Newer Bluetooth

- (void)addBluetoothStuff {
    self.discoveredPeripherals = [NSMutableArray array];
    
    // Start up the CBCentralManager
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    // And somewhere to store the incoming data
//    _data = [[NSMutableData alloc] init];
//    _data = [NSMutableData dataWithBytes:&BLUETOOTH_CODE_UNSET length:sizeof(BLUETOOTH_CODE_UNSET)];
}

//We *should* stop scanning when the view disappears... but Moai.
//- (void)viewWillDisappear:(BOOL)animated {
//    // Don't keep it going while we're not showing.
//    [self.centralManager stopScan];
//    NSLog(@"Scanning stopped");
//    
//    [super viewWillDisappear:animated];
//}

/** centralManagerDidUpdateState is a required protocol method.
 *  Usually, you'd check for other states to make sure the current device supports LE, is powered on, etc.
 *  In this instance, we're just using it to wait for CBCentralManagerStatePoweredOn, which indicates
 *  the Central is ready to be used.
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        // In a real app, you'd deal with all the states correctly
        return;
    }
    
    // The state must be CBCentralManagerStatePoweredOn...
    
    // ... so start scanning
    [self scan];
    
}

/** Scan for peripherals - specifically for our service's 128bit CBUUID
 */
- (void)scan
{
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]
                                                options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    NSLog(@"Scanning started");
}

/** This callback comes whenever a peripheral that is advertising the TRANSFER_SERVICE_UUID is discovered.
 *  We check the RSSI, to make sure it's close enough that we're interested in it, and if it is,
 *  we start the connection process
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    // Reject any where the value is above reasonable range
//    if (RSSI.integerValue > -15) {
//        return;
//    }
    
    // Reject if the signal strength is too low to be close enough (Close is around -22dB)
    //    if (RSSI.integerValue < -35) {
    //        return;
    //    }
    
//    NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
    
    // Ok, it's in range - have we already seen it?
//    if (self.discoveredPeripheral != peripheral) {
    if (![self.discoveredPeripherals containsObject:peripheral]) {
        
        BOOL buzzPeripheralManagerAcceptedConnection = [self notifyBuzzPeripheralManagerPeripheralConnected:peripheral];
        if (buzzPeripheralManagerAcceptedConnection) {
            // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
    //        self.discoveredPeripheral = peripheral;
            [self.discoveredPeripherals addObject:peripheral];
            
            // And connect
            NSLog(@"Connecting to peripheral %@", peripheral);
            [self.centralManager connectPeripheral:peripheral options:nil];
        }
    }
}

/** If the connection fails for whatever reason, we need to deal with it.
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
    [self cleanup];
}

/** We've connected to the peripheral, now we need to discover the services and characteristics to find the 'transfer' characteristic.
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
//    NSLog(@"Peripheral Connected");
    
    // Stop scanning
//    [self.centralManager stopScan];
//    NSLog(@"Scanning stopped");
    
    // Make sure we get the discovery callbacks
    peripheral.delegate = self;
    
    // Search only for services that match our UUID
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}

/** The Transfer Service was discovered
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    
    // Discover the characteristic we want...
    
    // Loop through the newly filled peripheral.services array, just in case there's more than one.
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:service];
    }
}

/** The Transfer characteristic was discovered.
 *  Once this has been found, we want to subscribe to it, which lets the peripheral know we want the data it contains
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    // Deal with errors (if any)
    if (error) {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    
    // Again, we loop through the array, just in case.
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        // And check if it's the right one
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
            
            // If it is, subscribe to it
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
    
    // Once this is complete, we just need to wait for the data to come in.
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
    }
    
    UInt8 receivedBytes[1];
    [characteristic.value getBytes:&receivedBytes length:1];
    UInt8 signalByte = receivedBytes[0];
    NSLog(@"IT GOT A BYTE: %d", signalByte);
    
    if (signalByte == BLUETOOTH_CODE_DISCONNECT) {
        NSLog(@"Got disconnect byte.  Disconnecting...");
        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
        [self.centralManager cancelPeripheralConnection:peripheral];
    } else {
        [self notifyBuzzPeripheralManagerPeripheral:peripheral sentInput:signalByte];
    }
}

/** The peripheral letting us know whether our subscribe/unsubscribe happened or not
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    // Exit if it's not the transfer characteristic
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    // Notification has started
    if (characteristic.isNotifying) {
        NSLog(@"Notification began on %@", characteristic);
    }
    
}

/** Once the disconnection happens, we need to clean up our local copy of the peripheral
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
//    NSLog(@"Peripheral Disconnected");
    [self notifyBuzzPeripheralManagerPeripheralDisconnected:peripheral];
    
//    self.discoveredPeripheral = nil;
    [self.discoveredPeripherals removeObject:peripheral];
    
    // We're disconnected, so start scanning again
//    [self scan];
}

- (void)cleanupPeripheral:(CBPeripheral *)discoveredPeripheral {
    // Don't do anything if we're not connected
    if (discoveredPeripheral.state != CBPeripheralStateConnected) {
        return;
    }
    
    // See if we are subscribed to a characteristic on the peripheral
    if (discoveredPeripheral.services != nil) {
        for (CBService *service in discoveredPeripheral.services) {
            if (service.characteristics != nil) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
                        if (characteristic.isNotifying) {
                            // It is notifying, so unsubscribe
                            [discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                            
                            // And we're done.
                            return;
                        }
                    }
                }
            }
        }
    }
    
    // If we've got this far, we're connected, but we're not subscribed, so we just disconnect
    [self.centralManager cancelPeripheralConnection:discoveredPeripheral];
}

/** Call this when things either go wrong, or you're done with the connection.
 *  This cancels any subscriptions if there are any, or straight disconnects if not.
 *  (didUpdateNotificationStateForCharacteristic will cancel the connection if a subscription is involved)
 */
- (void)cleanup
{
    for (CBPeripheral *peripheral in self.discoveredPeripherals) {
        [self cleanupPeripheral:peripheral];
    }
    
    //Do we need this?
//    [self.discoveredPeripherals removeAllObjects];
}

- (BOOL)notifyBuzzPeripheralManagerPeripheralConnected:(CBPeripheral *)peripheral {
    lua_State *l = AKUGetLuaState();
    
    lua_getglobal(l, "BuzzPeripheralManager");
    lua_getfield(l, -1, "onPeripheralConnected");
    
    unsigned int argumentsCount = 1;
    lua_pushstring(l, [peripheral.identifier.UUIDString UTF8String]);
    
    unsigned int returnedValuesCount = 1;
    lua_pcall(l, argumentsCount, returnedValuesCount, 0);
    
    bool buzzPeripheralManagerAcceptedConnection = lua_toboolean(l, -1);
    lua_pop(l, 2);
    
    return buzzPeripheralManagerAcceptedConnection;
}

- (void)notifyBuzzPeripheralManagerPeripheralDisconnected:(CBPeripheral *)peripheral {
    lua_State *l = AKUGetLuaState();
    
    lua_getglobal(l, "BuzzPeripheralManager");
    lua_getfield(l, -1, "onPeripheralDisconnected");
    
    unsigned int argumentsCount = 1;
    lua_pushstring(l, [peripheral.identifier.UUIDString UTF8String]);
    
    lua_pcall(l, argumentsCount, 0, 0);
    lua_pop(l, 1);
}

- (void)notifyBuzzPeripheralManagerPeripheral:(CBPeripheral *)peripheral sentInput:(NSInteger)bluetoothCode {
    lua_State *l = AKUGetLuaState();
    
    lua_getglobal(l, "BuzzPeripheralManager");
    lua_getfield(l, -1, "onPeripheralSentInput");
    
    unsigned int argumentsCount = 2;
    lua_pushstring(l, [peripheral.identifier.UUIDString UTF8String]);
    lua_pushinteger(l, bluetoothCode);
    
    lua_pcall(l, argumentsCount, 0, 0);
    lua_pop(l, 1);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.leftSwipeGestureRecognizer) {
        return (otherGestureRecognizer != self.rightSwipeGestureRecognizer);
    } else if (gestureRecognizer == self.rightSwipeGestureRecognizer) {
        return (otherGestureRecognizer != self.leftSwipeGestureRecognizer);
    } else if (gestureRecognizer == self.upSwipeGestureRecognizer) {
        return (otherGestureRecognizer != self.downSwipeGestureRecognizer);
    } else if (gestureRecognizer == self.downSwipeGestureRecognizer) {
        return (otherGestureRecognizer != self.upSwipeGestureRecognizer);
//    } else if (gestureRecognizer == self.leftTapGestureRecognizer) {
//        return (otherGestureRecognizer != self.rightTapGestureRecognizer);
//    } else if (gestureRecognizer == self.rightTapGestureRecognizer) {
//        return (otherGestureRecognizer != self.leftTapGestureRecognizer);
//    } else if (gestureRecognizer == self.upTapGestureRecognizer) {
//        return (otherGestureRecognizer != self.downTapGestureRecognizer);
//    } else if (gestureRecognizer == self.downTapGestureRecognizer) {
//        return (otherGestureRecognizer != self.upTapGestureRecognizer);
    } else {
        return NO;
    }
}

@end