using Toybox.WatchUi;
using Toybox.Sensor;
using Toybox.Application;

class BatteryTimeDataFieldView extends WatchUi.DataField {

	hidden var mTime;
	hidden var mBattery;
	hidden var mTemp;
	
    function initialize() {
        DataField.initialize();
        mTime = "";
        mBattery = "";
        mTemp = "--°C";
    }
    
    function onLayout(dc) {
    	View.setLayout(Rez.Layouts.MainLayout(dc));
    	
        // Add padding to battery info
        var battery = View.findDrawableById("battery");
        battery.locX = dc.getWidth() - 2;
        
        return true;
    }

    function compute(info) {
        // See Activity.Info in the documentation for available information.
        var time = System.getClockTime();
        mTime = Lang.format("$1$:$2$", [time.hour.format("%02d"), time.min.format("%02d")]);
        
        var batteryStatus = System.getSystemStats().battery;
        mBattery = batteryStatus.format("%3d") + "%";

        var temperature = Application.getApp().getProperty("temperature");
        if (temperature != null) { mTemp = temperature.format("%2d") + "°C"; }
    }
    
    function onUpdate(dc) {
        // Set the background color
        View.findDrawableById("Background").setColor(getBackgroundColor());

        var time = View.findDrawableById("time");
        time.setText(mTime);
        
        var battery = View.findDrawableById("battery");
        battery.setText(mBattery);
        
        var temp = View.findDrawableById("temp");
        temp.setText(mTemp);

        
        if (getBackgroundColor() == Graphics.COLOR_BLACK) {
            time.setColor(Graphics.COLOR_WHITE);
            battery.setColor(Graphics.COLOR_WHITE);
            temp.setColor(Graphics.COLOR_WHITE);
        } else {
            time.setColor(Graphics.COLOR_BLACK);
            battery.setColor(Graphics.COLOR_BLACK);
            temp.setColor(Graphics.COLOR_BLACK);
        }

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }
}