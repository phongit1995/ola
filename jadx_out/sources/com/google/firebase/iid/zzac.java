package com.google.firebase.iid;

import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.util.Log;

/* JADX INFO: loaded from: classes2.dex */
final class zzac {
    private final Messenger zzaf;
    private final zzi zzbx;

    zzac(IBinder iBinder) throws RemoteException {
        String interfaceDescriptor = iBinder.getInterfaceDescriptor();
        if ("android.os.IMessenger".equals(interfaceDescriptor)) {
            this.zzaf = new Messenger(iBinder);
            this.zzbx = null;
        } else if ("com.google.android.gms.iid.IMessengerCompat".equals(interfaceDescriptor)) {
            this.zzbx = new zzi(iBinder);
            this.zzaf = null;
        } else {
            String strValueOf = String.valueOf(interfaceDescriptor);
            Log.w("MessengerIpcClient", strValueOf.length() != 0 ? "Invalid interface descriptor: ".concat(strValueOf) : new String("Invalid interface descriptor: "));
            throw new RemoteException();
        }
    }

    final void send(Message message) throws RemoteException {
        if (this.zzaf != null) {
            this.zzaf.send(message);
        } else {
            if (this.zzbx == null) {
                throw new IllegalStateException("Both messengers are null");
            }
            this.zzbx.send(message);
        }
    }
}
