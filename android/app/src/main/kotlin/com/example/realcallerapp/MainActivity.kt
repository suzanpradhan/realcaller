package com.example.realcallerapp

import android.Manifest
import android.annotation.SuppressLint
import android.app.ActivityManager
import android.app.role.RoleManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import android.telecom.TelecomManager
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import androidx.core.content.PermissionChecker
import androidx.core.net.toUri
import com.example.realcallerapp.call.PhoneStateReceiver
import com.example.realcallerapp.call.CallService
import com.example.realcallerapp.call.RestartService
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    var mServiceIntent: Intent? = null
    private var mService: CallService? = null
    val CHANNEL_ID = "exampleServiceChannel"
    @SuppressLint("BatteryLife")
    override fun onStart() {
        super.onStart()

        checkDefaultDialer()
        mService = CallService()
        val mServiceIntent = Intent(this, mService!!::class.java)
//        if (!isMyServiceRunning(mService!!::class.java)) {
            ContextCompat.startForegroundService(this, mServiceIntent)
//        }

        // val intent = Intent()
        // val packageName = context.packageName
        // val pm: PowerManager = context.getSystemService(POWER_SERVICE) as PowerManager

        // if (!pm.isIgnoringBatteryOptimizations(packageName)){
        //     intent.action = Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS
        //     intent.data = Uri.parse("package:$packageName")
        // }
        // context.startActivity(intent)
    }




//    private fun createNotificationChannel() {
//        Toast.makeText(this, "Here", Toast.LENGTH_SHORT).show()
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            Toast.makeText(this, "Notification Creating", Toast.LENGTH_SHORT).show()
//            val serviceChannel = NotificationChannel(
//                    CHANNEL_ID,
//                    "Example Service Channel",
//                    NotificationManager.IMPORTANCE_DEFAULT
//            )
//            val manager: NotificationManager = getSystemService(NotificationManager::class.java)
//            manager.createNotificationChannel(serviceChannel)
//            Toast.makeText(this, "Notification Created", Toast.LENGTH_SHORT).show()
//
//            val serviceIntent = Intent(this, CallService::class.java)
//            ContextCompat.startForegroundService(this, serviceIntent)
//            Toast.makeText(this, "Service Enabled", Toast.LENGTH_SHORT).show()
//        }
//    }

//    private fun test (){
//        Toast.makeText(this, "Here", Toast.LENGTH_SHORT).show()
//    }

    

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        when (requestCode) {
            REQUEST_CODE_SET_DEFAULT_DIALER -> checkSetDefaultDialerResult(resultCode)
        }
    }

    private var type: Int = 0

    companion object {
        private const val REQUEST_CODE_SET_DEFAULT_DIALER = 123
        const val CHANNEL = "flutter_native_channel"
        const val Call_Method = "makeCall"
        

        var phoneNumber = ""
        
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { flutterMethod, result ->
            if (flutterMethod.method == Call_Method) {
                val argument = flutterMethod.arguments<Map<String, Any>>()
                phoneNumber = (argument["phoneNumber"] as String?).toString()
                makeCall()
            }
            else {
                result.notImplemented()
            }
        }
    }

    ///make call function
    private fun makeCall() {
        if (PermissionChecker.checkSelfPermission(this, Manifest.permission.CALL_PHONE) == PermissionChecker.PERMISSION_GRANTED) {
            
            val uri:android.net.Uri = "tel:${phoneNumber}".toUri()
            startActivity(Intent(Intent.ACTION_CALL, uri))
        }

    }

    private fun isMyServiceRunning(serviceClass: Class<*>): Boolean {
        val manager: ActivityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        for (service in manager.getRunningServices(Int.MAX_VALUE)) {
            if (serviceClass.name == service.service.getClassName()) {
                Log.i("isMyServiceRunning?", true.toString() + "")
                return true
            }
        }
        Log.i("isMyServiceRunning?", false.toString() + "")
        return false
    }

    private fun checkDefaultDialer() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            Toast.makeText(this, "Notification Creating", Toast.LENGTH_SHORT).show()
//            val serviceChannel = NotificationChannel(
//                    CHANNEL_ID,
//                    "Example Service Channel",
//                    NotificationManager.IMPORTANCE_DEFAULT
//            )
//            val manager: NotificationManager = getSystemService(NotificationManager::class.java)
//            manager.createNotificationChannel(serviceChannel)
//            Toast.makeText(this, "Notification Created", Toast.LENGTH_SHORT).show()
//
//            val serviceIntent = Intent(this, CallService::class.java)
//            if (!isMyServiceRunning(serviceIntent::class.java)) {
//                ContextCompat.startForegroundService(this, serviceIntent)
//            }
////            ContextCompat.startForegroundService(this, serviceIntent)
//            Toast.makeText(this, "Service Enabled", Toast.LENGTH_SHORT).show()
//        }
//        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            Toast.makeText(this, "Role manager Starting", Toast.LENGTH_SHORT).show()
            val roleManager: RoleManager = getSystemService(RoleManager::class.java)
            // check if the app is having permission to be as default SMS app
            val isRoleAvailable: Boolean = roleManager.isRoleAvailable(RoleManager.ROLE_DIALER)
            if (isRoleAvailable) {
                // check whether your app is already holding the default SMS app role.
                val isRoleHeld: Boolean = roleManager.isRoleHeld(RoleManager.ROLE_DIALER)
                Toast.makeText(this, "Role Status: $isRoleHeld", Toast.LENGTH_SHORT).show()
                if (!isRoleHeld) {
                    val roleRequestIntent: Intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_DIALER)
                    startActivityForResult(roleRequestIntent, 1)
                    Toast.makeText(this, "Role Status: $isRoleHeld", Toast.LENGTH_SHORT).show()
                }
            }
        } else {
//            Toast.makeText(this, "Telecom manager Starting", Toast.LENGTH_SHORT).show()
            val telecomManager = getSystemService(TELECOM_SERVICE) as TelecomManager
            val isAlreadyDefaultDialer = packageName == telecomManager.defaultDialerPackage
            if (isAlreadyDefaultDialer) return

            val intent = Intent(TelecomManager.ACTION_CHANGE_DEFAULT_DIALER)
                    .putExtra(TelecomManager.EXTRA_CHANGE_DEFAULT_DIALER_PACKAGE_NAME, packageName)
            startActivityForResult(intent, REQUEST_CODE_SET_DEFAULT_DIALER)
        }

    }

    private fun checkSetDefaultDialerResult(resultCode: Int) {
        val message = when (resultCode) {
            RESULT_OK -> "User accepted request to become default dialer"
            RESULT_CANCELED -> "User declined request to become default dialer"
            else -> "Unexpected result code $resultCode"
        }

        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }

    override fun onDestroy() {
//        val broadcast = Intent(this, PhoneStateReceiver::class.java)
//        sendBroadcast(broadcast)
    //    val serviceIntent = Intent(this, CallService::class.java)
    //    ContextCompat.startForegroundService(this, serviceIntent)
        Log.d("on destroy called", "gps state on destroy called first");
        Log.d("on destroy called", "gps state on destroy called second");

       val broadcastIntent = Intent()
       broadcastIntent.action = "restartservice"
       broadcastIntent.setClass(this, RestartService::class.java)
       this.sendBroadcast(broadcastIntent)
        super.onDestroy()
    }


}