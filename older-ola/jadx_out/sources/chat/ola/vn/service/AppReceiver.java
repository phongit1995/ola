package chat.ola.vn.service;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.telephony.TelephonyManager;
import chat.ola.vn.balloon.OlaBalloonService;
import chat.ola.vn.f.a;
import chat.ola.vn.h;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.n;

/* JADX INFO: loaded from: classes.dex */
public class AppReceiver extends BroadcastReceiver implements a {
    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String action;
        NetworkInfo activeNetworkInfo;
        if (intent == null || (action = intent.getAction()) == null) {
            return;
        }
        if (action.equals("android.intent.action.BOOT_COMPLETED")) {
            Intent intent2 = new Intent(context, (Class<?>) OlaNetworkService.class);
            intent2.putExtra("Source", AppReceiver.class.getName());
            context.startService(intent2);
            context.startService(new Intent(context, (Class<?>) OlaBalloonService.class));
            return;
        }
        if (action.equals("android.net.conn.CONNECTIVITY_CHANGE") || action.equals("android.net.wifi.STATE_CHANGE") || action.equals("android.net.wifi.WIFI_STATE_CHANGED")) {
            if (!n.c(context)) {
                h.F = false;
                return;
            }
            h.F = true;
            h.I = false;
            ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService("connectivity");
            if (connectivityManager != null && (activeNetworkInfo = connectivityManager.getActiveNetworkInfo()) != null && activeNetworkInfo.getType() == 1) {
                h.I = true;
            }
            TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService("phone");
            try {
                if (h.I) {
                    return;
                }
                h.J = true;
                if (telephonyManager.getNetworkType() == 1 || telephonyManager.getNetworkType() == 2) {
                    h.J = false;
                }
            } catch (Throwable unused) {
            }
        }
    }
}
