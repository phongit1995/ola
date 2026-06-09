package com.google.android.gms.internal.measurement;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.DeadObjectException;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Looper;
import android.os.RemoteException;
import android.support.annotation.MainThread;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.WorkerThread;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.internal.BaseGmsClient;
import com.google.android.gms.common.internal.GmsClientSupervisor;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.stats.ConnectionTracker;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
public final class zziy implements ServiceConnection, BaseGmsClient.BaseConnectionCallbacks, BaseGmsClient.BaseOnConnectionFailedListener {
    final /* synthetic */ zzik zzaqv;
    private volatile boolean zzarb;
    private volatile zzfh zzarc;

    protected zziy(zzik zzikVar) {
        this.zzaqv = zzikVar;
    }

    static /* synthetic */ boolean zza(zziy zziyVar, boolean z) {
        zziyVar.zzarb = false;
        return false;
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient.BaseConnectionCallbacks
    @MainThread
    public final void onConnected(@Nullable Bundle bundle) {
        Preconditions.checkMainThread("MeasurementServiceConnection.onConnected");
        synchronized (this) {
            try {
                zzfa service = this.zzarc.getService();
                this.zzarc = null;
                this.zzaqv.zzgh().zzc(new zzjb(this, service));
            } catch (DeadObjectException | IllegalStateException unused) {
                this.zzarc = null;
                this.zzarb = false;
            }
        }
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient.BaseOnConnectionFailedListener
    @MainThread
    public final void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        Preconditions.checkMainThread("MeasurementServiceConnection.onConnectionFailed");
        zzfi zzfiVarZzjy = this.zzaqv.zzacv.zzjy();
        if (zzfiVarZzjy != null) {
            zzfiVarZzjy.zziy().zzg("Service connection failed", connectionResult);
        }
        synchronized (this) {
            this.zzarb = false;
            this.zzarc = null;
        }
        this.zzaqv.zzgh().zzc(new zzjd(this));
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient.BaseConnectionCallbacks
    @MainThread
    public final void onConnectionSuspended(int i) {
        Preconditions.checkMainThread("MeasurementServiceConnection.onConnectionSuspended");
        this.zzaqv.zzgi().zzjb().log("Service connection suspended");
        this.zzaqv.zzgh().zzc(new zzjc(this));
    }

    @Override // android.content.ServiceConnection
    @MainThread
    public final void onServiceConnected(ComponentName componentName, IBinder iBinder) {
        Preconditions.checkMainThread("MeasurementServiceConnection.onServiceConnected");
        synchronized (this) {
            if (iBinder == null) {
                this.zzarb = false;
                this.zzaqv.zzgi().zziv().log("Service connected with null binder");
                return;
            }
            zzfa zzfcVar = null;
            try {
                String interfaceDescriptor = iBinder.getInterfaceDescriptor();
                if ("com.google.android.gms.measurement.internal.IMeasurementService".equals(interfaceDescriptor)) {
                    if (iBinder != null) {
                        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.measurement.internal.IMeasurementService");
                        zzfcVar = iInterfaceQueryLocalInterface instanceof zzfa ? (zzfa) iInterfaceQueryLocalInterface : new zzfc(iBinder);
                    }
                    this.zzaqv.zzgi().zzjc().log("Bound to IMeasurementService interface");
                } else {
                    this.zzaqv.zzgi().zziv().zzg("Got binder with a wrong descriptor", interfaceDescriptor);
                }
            } catch (RemoteException unused) {
                this.zzaqv.zzgi().zziv().log("Service connect failed to get IMeasurementService");
            }
            if (zzfcVar == null) {
                this.zzarb = false;
                try {
                    ConnectionTracker.getInstance().unbindService(this.zzaqv.getContext(), this.zzaqv.zzaqo);
                } catch (IllegalArgumentException unused2) {
                }
            } else {
                this.zzaqv.zzgh().zzc(new zziz(this, zzfcVar));
            }
        }
    }

    @Override // android.content.ServiceConnection
    @MainThread
    public final void onServiceDisconnected(ComponentName componentName) {
        Preconditions.checkMainThread("MeasurementServiceConnection.onServiceDisconnected");
        this.zzaqv.zzgi().zzjb().log("Service disconnected");
        this.zzaqv.zzgh().zzc(new zzja(this, componentName));
    }

    @WorkerThread
    public final void zzc(Intent intent) {
        this.zzaqv.zzab();
        Context context = this.zzaqv.getContext();
        ConnectionTracker connectionTracker = ConnectionTracker.getInstance();
        synchronized (this) {
            if (this.zzarb) {
                this.zzaqv.zzgi().zzjc().log("Connection attempt already in progress");
                return;
            }
            this.zzaqv.zzgi().zzjc().log("Using local app measurement service");
            this.zzarb = true;
            connectionTracker.bindService(context, intent, this.zzaqv.zzaqo, GmsClientSupervisor.DEFAULT_BIND_FLAGS);
        }
    }

    @WorkerThread
    public final void zzkt() {
        this.zzaqv.zzab();
        Context context = this.zzaqv.getContext();
        synchronized (this) {
            if (this.zzarb) {
                this.zzaqv.zzgi().zzjc().log("Connection attempt already in progress");
                return;
            }
            if (this.zzarc != null) {
                this.zzaqv.zzgi().zzjc().log("Already awaiting connection attempt");
                return;
            }
            this.zzarc = new zzfh(context, Looper.getMainLooper(), this, this);
            this.zzaqv.zzgi().zzjc().log("Connecting to remote service");
            this.zzarb = true;
            this.zzarc.checkAvailabilityAndConnect();
        }
    }
}
