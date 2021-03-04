using Toybox.Application;
using Toybox.Background;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;

const FIVE_MINUTES = new Time.Duration(5 * 60);

(:background)
class BatteryTimeDataFieldApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        if (System has :ServiceDelegate) {
    		Background.registerForTemporalEvent(FIVE_MINUTES);
    	} else {
    		System.println("**** background not available on this device ****");
    	}

        return [ new BatteryTimeDataFieldView() ];
    }

    function getServiceDelegate() {
        return [ new TemperatureServiceDelegate() ];
    }

    function onBackgroundData(data) {
        Application.getApp().setProperty("temperature", data);
    }   
}