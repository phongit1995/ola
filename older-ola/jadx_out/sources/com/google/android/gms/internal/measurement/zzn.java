package com.google.android.gms.internal.measurement;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;

/* JADX INFO: loaded from: classes2.dex */
public class zzn implements IInterface {
    private final IBinder zzqi;
    private final String zzqj;

    protected zzn(IBinder iBinder, String str) {
        this.zzqi = iBinder;
        this.zzqj = str;
    }

    @Override // android.os.IInterface
    public IBinder asBinder() {
        return this.zzqi;
    }

    protected final Parcel obtainAndWriteInterfaceToken() {
        Parcel parcelObtain = Parcel.obtain();
        parcelObtain.writeInterfaceToken(this.zzqj);
        return parcelObtain;
    }

    protected final Parcel transactAndReadException(int i, Parcel parcel) {
        Parcel parcelObtain = Parcel.obtain();
        try {
            try {
                this.zzqi.transact(i, parcel, parcelObtain, 0);
                parcelObtain.readException();
                return parcelObtain;
            } catch (RuntimeException e) {
                parcelObtain.recycle();
                throw e;
            }
        } finally {
            parcel.recycle();
        }
    }

    protected final void transactAndReadExceptionReturnVoid(int i, Parcel parcel) {
        Parcel parcelObtain = Parcel.obtain();
        try {
            this.zzqi.transact(i, parcel, parcelObtain, 0);
            parcelObtain.readException();
        } finally {
            parcel.recycle();
            parcelObtain.recycle();
        }
    }

    protected final void transactOneway(int i, Parcel parcel) {
        try {
            this.zzqi.transact(1, parcel, null, 1);
        } finally {
            parcel.recycle();
        }
    }
}
