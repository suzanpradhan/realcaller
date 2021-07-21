package com.example.realcallerapp.call

import android.app.*
import android.content.BroadcastReceiver
import android.content.Intent
import android.content.IntentFilter
import android.os.*
import android.widget.Toast
import androidx.annotation.RequiresApi
import com.example.realcallerapp.R

class TestService : Service() {
    private var notificationReceiver: BroadcastReceiver? = null
    override fun onBind(intent: Intent?): IBinder? {
        return null;
    }

    override fun onCreate() {
        super.onCreate()
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
                .setContentTitle("App is running in background")
                .setContentText("test")
                .setSmallIcon(R.drawable.ic_android)
                .setCategory(Notification.CATEGORY_SERVICE)
                .build()

        startForeground(2, notification)

    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
//        startTimer();
        return START_STICKY;
    }

    override fun onDestroy() {
        super.onDestroy()
    }

}

