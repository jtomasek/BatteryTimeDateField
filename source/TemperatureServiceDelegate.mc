using Toybox.Background;
using Toybox.System;
using Toybox.Sensor;

// The Service Delegate is the main entry point for background processes
// our onTemporalEvent() method will get run each time our periodic event
// is triggered by the system.

(:background)
class TemperatureServiceDelegate extends Toybox.System.ServiceDelegate {
	function initialize() {
		System.ServiceDelegate.initialize();
	}
	
    function onTemporalEvent() {
        var sensorInfo = Sensor.getInfo();
        if (sensorInfo has :temperature && sensorInfo.temperature != null) {
            Background.exit(sensorInfo.temperature);
        }
    }
    

}
