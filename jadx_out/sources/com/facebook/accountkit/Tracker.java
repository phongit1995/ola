package com.facebook.accountkit;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.internal.AccountKitController;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class Tracker {
    public static final String EXTRA_LOGIN_ERROR = "com.facebook.accountkit.sdk.EXTRA_LOGIN_ERROR";
    public static final String EXTRA_LOGIN_MODEL = "com.facebook.accountkit.sdk.EXTRA_LOGIN_MODEL";
    public static final String EXTRA_LOGIN_STATUS = "com.facebook.accountkit.sdk.EXTRA_LOGIN_STATUS";
    private boolean isPaused = false;
    private boolean isTracking = false;
    private final List<Intent> pendingBroadcasts = new ArrayList();
    private final BroadcastReceiver receiver = new TrackerBroadcastReceiver(this);

    private static class TrackerBroadcastReceiver extends BroadcastReceiver {
        final WeakReference<Tracker> trackerRef;

        TrackerBroadcastReceiver(Tracker tracker) {
            this.trackerRef = new WeakReference<>(tracker);
        }

        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            Tracker tracker = this.trackerRef.get();
            if (tracker != null && tracker.getActionsStateChanged().contains(intent.getAction())) {
                if (tracker.isPaused()) {
                    tracker.pendingBroadcasts.add(intent);
                } else if (tracker.isTracking()) {
                    tracker.onReceive(intent);
                }
            }
        }
    }

    private void addBroadcastReceiver() {
        IntentFilter intentFilter = new IntentFilter();
        Iterator<String> it2 = getActionsStateChanged().iterator();
        while (it2.hasNext()) {
            intentFilter.addAction(it2.next());
        }
        registerReceiver(this.receiver, intentFilter);
    }

    private void registerReceiver(BroadcastReceiver broadcastReceiver, IntentFilter intentFilter) {
        Context applicationContext = AccountKitController.getApplicationContext();
        if (isLocal()) {
            LocalBroadcastManager.getInstance(applicationContext).registerReceiver(broadcastReceiver, intentFilter);
        } else {
            applicationContext.registerReceiver(broadcastReceiver, intentFilter);
        }
    }

    private void unregisterReceiver(BroadcastReceiver broadcastReceiver) {
        Context applicationContext = AccountKitController.getApplicationContext();
        if (isLocal()) {
            LocalBroadcastManager.getInstance(applicationContext).unregisterReceiver(broadcastReceiver);
        } else {
            applicationContext.unregisterReceiver(broadcastReceiver);
        }
    }

    protected abstract List<String> getActionsStateChanged();

    protected boolean isLocal() {
        return true;
    }

    public boolean isPaused() {
        return this.isPaused;
    }

    public boolean isTracking() {
        return this.isTracking;
    }

    protected abstract void onReceive(Intent intent);

    public void pauseTracking() {
        this.isPaused = true;
    }

    public void startTracking() {
        if (!this.isTracking) {
            this.isTracking = true;
            addBroadcastReceiver();
        }
        if (this.isPaused) {
            this.isPaused = false;
            ArrayList<Intent> arrayList = new ArrayList(this.pendingBroadcasts);
            this.pendingBroadcasts.clear();
            for (Intent intent : arrayList) {
                if (isTracking()) {
                    onReceive(intent);
                }
            }
        }
    }

    public void stopTracking() {
        if (this.isTracking) {
            this.isTracking = false;
            unregisterReceiver(this.receiver);
            this.pendingBroadcasts.clear();
        }
    }
}
