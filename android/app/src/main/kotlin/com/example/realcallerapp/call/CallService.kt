package com.example.realcallerapp.call
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.os.*
import android.telecom.Call
import android.telecom.InCallService
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.example.realcallerapp.R
import io.flutter.Log
import java.util.*


class CallService : InCallService() {
    var counter = 0


    override fun onCreate() {
        super.onCreate()
//        val broadcastIntent = Intent()
//        broadcastIntent.action = "restartservice"
//        broadcastIntent.setClass(this, RestartService::class.java)
//        this.sendBroadcast(broadcastIntent)
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.O) startMyOwnForeground() else startForeground(1, Notification())

    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun startMyOwnForeground() {
        val CHANNEL_ID = "exampleServiceChannel"
                    Toast.makeText(this, "Notification Creating", Toast.LENGTH_SHORT).show()
            val serviceChannel = NotificationChannel(
                    CHANNEL_ID,
                    "Example Service Channel",
                    NotificationManager.IMPORTANCE_LOW
            )
            val manager: NotificationManager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(serviceChannel)
            Toast.makeText(this, "Notification Created", Toast.LENGTH_SHORT).show()
        val notificationBuilder: Notification.Builder = Notification.Builder(this, CHANNEL_ID)
        val notification: Notification = notificationBuilder.setOngoing(true)
                .setContentTitle("RealCaller")
                .setContentText("Spam Protection on Process.")
                .setSmallIcon(R.drawable.ic_android)
                .setCategory(Notification.CATEGORY_SERVICE)
                .build()

        startForeground(2, notification)

//        val handlerThread = HandlerThread("MyHandlerThread")
//        handlerThread.start()
//        val looper: Looper = handlerThread.getLooper()
//        val handler = Handler(looper)
//        handler.post(Runnable { StartSync() })
    }
//    private fun StartSync() {
//        //Your code here which runs for a long while..
////        while (true){
////            Toast.makeText(this, "Running", Toast.LENGTH_SHORT).show()
////        }
//
//        //After you are done, stop the service and foreground notification
//        stopForeground(true)
//        stopSelf()
//    }

    override fun onDestroy() {
        super.onDestroy()
        val broadcast = Intent(this, RestartService::class.java)

        sendBroadcast(broadcast)

//        val broadcast = Intent(this, PhoneStateReceiver::class.java)
//
//        sendBroadcast(broadcast)
//        stoptimertask()

//        val broadcastIntent = Intent()
//        broadcastIntent.action = "restartservice"
//        broadcastIntent.setClass(this, RestartService::class.java)
//        this.sendBroadcast(broadcastIntent)
    }


    @RequiresApi(Build.VERSION_CODES.O)
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
//        return super.onStartCommand(intent, flags, startId)
//
//        val notificationIntent = Intent(this, MainActivity::class.java)
//        val pendingIntent: PendingIntent = PendingIntent.getActivity(this,
//                0, notificationIntent, 0)
//        val notification: Notification = Notification.Builder(this, "exampleServiceChannel")
//                .setContentTitle("Example Service")
//                .setContentText("test")
//                .setSmallIcon(R.drawable.ic_android)
//                .setContentIntent(pendingIntent)
//                .build()
//        startForeground(1, notification)
//        startTimer();
        return START_STICKY;
    }

    private var timer: Timer? = null
    private var timerTask: TimerTask? = null
    fun startTimer() {
        timer = Timer()
        timerTask = object : TimerTask() {
            override fun run() {
                Log.i("Count", "=========  " + counter++)
            }
        }
        timer!!.schedule(timerTask, 1000, 1000) //
    }

    fun stoptimertask() {
        if (timer != null) {
            timer!!.cancel()
            timer = null
        }
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
//        stoptimertask()
        val broadcast = Intent(this, RestartService::class.java)

        sendBroadcast(broadcast)
//        val broadcast = Intent(this, PhoneStateReceiver::class.java)
//
//        sendBroadcast(broadcast)

//        val broadcastIntent = Intent()
//        broadcastIntent.action = "restartservice"
//        broadcastIntent.setClass(this, RestartService::class.java)
//        this.sendBroadcast(broadcastIntent)
//        val restartServiceIntent = Intent(applicationContext, this.javaClass)
//        val restartServicePendingIntent = PendingIntent.getService(
//                applicationContext, 1, restartServiceIntent, PendingIntent.FLAG_ONE_SHOT)
//        val alarmService: AlarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
//        alarmService.set(AlarmManager.ELAPSED_REALTIME, elapsedRealtime() + 500,
//                restartServicePendingIntent)
//        Log.d("taskremoved", "task removed ")
        super.onTaskRemoved(rootIntent)
    }

    override fun onCallAdded(call: Call) {
         Toast.makeText(this, "Call Added", Toast.LENGTH_SHORT).show()
        // val broadcast = Intent(this, PhoneStateReceiver::class.java)
// request code and flags not added for demo purposes
        val destination = CallActivity::class.java
        val intent = Intent(this, destination)

//        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.O){
//            val notifChannel = NotificationChannel(
//                    "notifChannel",
//                    "Example Service Channel",
//                    NotificationManager.IMPORTANCE_HIGH
//            )
//            val manager: NotificationManager = getSystemService(NotificationManager::class.java)
//            manager.createNotificationChannel(notifChannel)
//            val builder = NotificationCompat.Builder(this, "notifChannel")
//                    .setSmallIcon(android.R.drawable.arrow_up_float)
//                    .setContentTitle("Title")
//                    .setContentText("Description")
//                    .setDefaults(Notification.DEFAULT_ALL)
//            val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT, )
//            builder.setContentIntent(pendingIntent);
//            builder.setFullScreenIntent(pendingIntent, true)
//            manager.notify(115, builder.build());
//        }

        // sendBroadcast(broadcast)
       OngoingCall.call = call
       CallActivity.start(this, call)
    }

    override fun onCallRemoved(call: Call) {
         Toast.makeText(this, "Call Removed", Toast.LENGTH_SHORT).show()
       OngoingCall.call = null
    }
}