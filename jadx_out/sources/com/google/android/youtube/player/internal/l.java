package com.google.android.youtube.player.internal;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import com.google.android.youtube.player.internal.j;
import com.google.android.youtube.player.internal.k;

/* JADX INFO: loaded from: classes2.dex */
public interface l extends IInterface {

    public static abstract class a extends Binder implements l {

        /* JADX INFO: renamed from: com.google.android.youtube.player.internal.l$a$a, reason: collision with other inner class name */
        private static class C0077a implements l {
            private IBinder a;

            C0077a(IBinder iBinder) {
                this.a = iBinder;
            }

            @Override // com.google.android.youtube.player.internal.l
            public final IBinder a() {
                Parcel parcelObtain = Parcel.obtain();
                Parcel parcelObtain2 = Parcel.obtain();
                try {
                    parcelObtain.writeInterfaceToken("com.google.android.youtube.player.internal.IYouTubeService");
                    this.a.transact(1, parcelObtain, parcelObtain2, 0);
                    parcelObtain2.readException();
                    return parcelObtain2.readStrongBinder();
                } finally {
                    parcelObtain2.recycle();
                    parcelObtain.recycle();
                }
            }

            @Override // com.google.android.youtube.player.internal.l
            public final k a(j jVar) {
                Parcel parcelObtain = Parcel.obtain();
                Parcel parcelObtain2 = Parcel.obtain();
                try {
                    parcelObtain.writeInterfaceToken("com.google.android.youtube.player.internal.IYouTubeService");
                    parcelObtain.writeStrongBinder(jVar != null ? jVar.asBinder() : null);
                    this.a.transact(2, parcelObtain, parcelObtain2, 0);
                    parcelObtain2.readException();
                    return k.a.a(parcelObtain2.readStrongBinder());
                } finally {
                    parcelObtain2.recycle();
                    parcelObtain.recycle();
                }
            }

            @Override // com.google.android.youtube.player.internal.l
            public final void a(boolean z) {
                Parcel parcelObtain = Parcel.obtain();
                Parcel parcelObtain2 = Parcel.obtain();
                try {
                    parcelObtain.writeInterfaceToken("com.google.android.youtube.player.internal.IYouTubeService");
                    parcelObtain.writeInt(z ? 1 : 0);
                    this.a.transact(3, parcelObtain, parcelObtain2, 0);
                    parcelObtain2.readException();
                } finally {
                    parcelObtain2.recycle();
                    parcelObtain.recycle();
                }
            }

            @Override // android.os.IInterface
            public final IBinder asBinder() {
                return this.a;
            }
        }

        public static l a(IBinder iBinder) {
            if (iBinder == null) {
                return null;
            }
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.youtube.player.internal.IYouTubeService");
            return (iInterfaceQueryLocalInterface == null || !(iInterfaceQueryLocalInterface instanceof l)) ? new C0077a(iBinder) : (l) iInterfaceQueryLocalInterface;
        }

        @Override // android.os.Binder
        public boolean onTransact(int i, Parcel parcel, Parcel parcel2, int i2) {
            j c0075a;
            if (i == 1598968902) {
                parcel2.writeString("com.google.android.youtube.player.internal.IYouTubeService");
                return true;
            }
            switch (i) {
                case 1:
                    parcel.enforceInterface("com.google.android.youtube.player.internal.IYouTubeService");
                    IBinder iBinderA = a();
                    parcel2.writeNoException();
                    parcel2.writeStrongBinder(iBinderA);
                    return true;
                case 2:
                    parcel.enforceInterface("com.google.android.youtube.player.internal.IYouTubeService");
                    IBinder strongBinder = parcel.readStrongBinder();
                    if (strongBinder == null) {
                        c0075a = null;
                    } else {
                        IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.android.youtube.player.internal.IThumbnailLoaderClient");
                        c0075a = (iInterfaceQueryLocalInterface == null || !(iInterfaceQueryLocalInterface instanceof j)) ? new j.a.C0075a(strongBinder) : (j) iInterfaceQueryLocalInterface;
                    }
                    k kVarA = a(c0075a);
                    parcel2.writeNoException();
                    parcel2.writeStrongBinder(kVarA != null ? kVarA.asBinder() : null);
                    return true;
                case 3:
                    parcel.enforceInterface("com.google.android.youtube.player.internal.IYouTubeService");
                    a(parcel.readInt() != 0);
                    parcel2.writeNoException();
                    return true;
                default:
                    return super.onTransact(i, parcel, parcel2, i2);
            }
        }
    }

    IBinder a();

    k a(j jVar);

    void a(boolean z);
}
