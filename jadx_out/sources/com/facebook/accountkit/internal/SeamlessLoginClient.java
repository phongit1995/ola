package com.facebook.accountkit.internal;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;

/* JADX INFO: loaded from: classes.dex */
final class SeamlessLoginClient implements ServiceConnection {
    private static final int MIN_PROTOCOL_VERSION = 20161017;
    private static final int REPLY_MESSAGE = 65545;
    private static final int REQUEST_MESSAGE = 65544;
    private final String applicationId;
    private final Context context;
    private final Handler handler = new Handler() { // from class: com.facebook.accountkit.internal.SeamlessLoginClient.1
        @Override // android.os.Handler
        public void handleMessage(Message message) {
            SeamlessLoginClient.this.handleMessage(message);
        }
    };
    private CompletedListener listener;
    private final InternalLogger logger;
    private boolean running;
    private Messenger sender;

    public interface CompletedListener {
        void completed(Bundle bundle);
    }

    public SeamlessLoginClient(Context context, String str, InternalLogger internalLogger) {
        this.context = context;
        this.applicationId = str;
        this.logger = internalLogger;
    }

    private void callback(Bundle bundle) {
        if (this.running) {
            this.running = false;
            if (this.listener != null) {
                this.listener.completed(bundle);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void handleMessage(Message message) {
        if (message.what == 65545) {
            Bundle data = message.getData();
            if (data.getString(com.facebook.internal.NativeProtocol.STATUS_ERROR_TYPE) != null) {
                data = null;
            }
            callback(data);
            try {
                this.context.unbindService(this);
            } catch (IllegalArgumentException unused) {
            }
        }
    }

    private void sendMessage() {
        Bundle bundle = new Bundle();
        bundle.putString(com.facebook.internal.NativeProtocol.EXTRA_APPLICATION_ID, this.applicationId);
        Message messageObtain = Message.obtain((Handler) null, 65544);
        messageObtain.arg1 = MIN_PROTOCOL_VERSION;
        messageObtain.setData(bundle);
        messageObtain.replyTo = new Messenger(this.handler);
        try {
            this.sender.send(messageObtain);
        } catch (RemoteException unused) {
            callback(null);
        }
    }

    public boolean isRunning() {
        return this.running;
    }

    @Override // android.content.ServiceConnection
    public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
        this.sender = new Messenger(iBinder);
        sendMessage();
    }

    @Override // android.content.ServiceConnection
    public void onServiceDisconnected(ComponentName componentName) {
        this.sender = null;
        try {
            this.context.unbindService(this);
        } catch (IllegalArgumentException unused) {
        }
        callback(null);
    }

    public void setCompletedListener(CompletedListener completedListener) {
        this.listener = completedListener;
    }

    public boolean start() {
        if (this.running) {
            return false;
        }
        if (!NativeProtocol.validateApplicationForService()) {
            this.logger.logFetchEventError(InternalLogger.EVENT_NAME_FETCH_SEAMLESS_LOGIN_TOKEN, InternalAccountKitError.NO_NATIVE_APP_INSTALLED);
            return false;
        }
        if (!NativeProtocol.validateProtocolVersionForService(MIN_PROTOCOL_VERSION)) {
            this.logger.logFetchEventError(InternalLogger.EVENT_NAME_FETCH_SEAMLESS_LOGIN_TOKEN, InternalAccountKitError.UNSUPPORTED_NATIVE_APP_VERSION);
            return false;
        }
        Intent intentCreatePlatformServiceIntent = NativeProtocol.createPlatformServiceIntent(this.context);
        if (intentCreatePlatformServiceIntent == null) {
            return false;
        }
        this.running = true;
        this.context.bindService(intentCreatePlatformServiceIntent, this, 1);
        return true;
    }
}
