package com.google.android.gms.internal.ads;

import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.IOUtils;
import java.io.DataInputStream;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "LargeParcelTeleporterCreator")
@SafeParcelable.Reserved({1})
@zzadh
public final class zzaev extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzaev> CREATOR = new zzaex();

    @SafeParcelable.Field(id = 2)
    private ParcelFileDescriptor zzcft;
    private Parcelable zzcfu;
    private boolean zzcfv;

    @SafeParcelable.Constructor
    public zzaev(@SafeParcelable.Param(id = 2) ParcelFileDescriptor parcelFileDescriptor) {
        this.zzcft = parcelFileDescriptor;
        this.zzcfu = null;
        this.zzcfv = true;
    }

    public zzaev(SafeParcelable safeParcelable) {
        this.zzcft = null;
        this.zzcfu = safeParcelable;
        this.zzcfv = false;
    }

    private final <T> ParcelFileDescriptor zze(byte[] bArr) {
        ParcelFileDescriptor.AutoCloseOutputStream autoCloseOutputStream;
        ParcelFileDescriptor[] parcelFileDescriptorArrCreatePipe;
        try {
            parcelFileDescriptorArrCreatePipe = ParcelFileDescriptor.createPipe();
            autoCloseOutputStream = new ParcelFileDescriptor.AutoCloseOutputStream(parcelFileDescriptorArrCreatePipe[1]);
        } catch (IOException e) {
            e = e;
            autoCloseOutputStream = null;
        }
        try {
            new Thread(new zzaew(this, autoCloseOutputStream, bArr)).start();
            return parcelFileDescriptorArrCreatePipe[0];
        } catch (IOException e2) {
            e = e2;
            zzakb.zzb("Error transporting the ad response", e);
            com.google.android.gms.ads.internal.zzbv.zzeo().zza(e, "LargeParcelTeleporter.pipeData.2");
            IOUtils.closeQuietly(autoCloseOutputStream);
            return null;
        }
    }

    private final ParcelFileDescriptor zzoc() {
        if (this.zzcft == null) {
            Parcel parcelObtain = Parcel.obtain();
            try {
                this.zzcfu.writeToParcel(parcelObtain, 0);
                byte[] bArrMarshall = parcelObtain.marshall();
                parcelObtain.recycle();
                this.zzcft = zze(bArrMarshall);
            } catch (Throwable th) {
                parcelObtain.recycle();
                throw th;
            }
        }
        return this.zzcft;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        zzoc();
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzcft, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final <T extends SafeParcelable> T zza(Parcelable.Creator<T> creator) {
        if (this.zzcfv) {
            if (this.zzcft == null) {
                zzakb.e("File descriptor is empty, returning null.");
                return null;
            }
            DataInputStream dataInputStream = new DataInputStream(new ParcelFileDescriptor.AutoCloseInputStream(this.zzcft));
            try {
                try {
                    byte[] bArr = new byte[dataInputStream.readInt()];
                    dataInputStream.readFully(bArr, 0, bArr.length);
                    IOUtils.closeQuietly(dataInputStream);
                    Parcel parcelObtain = Parcel.obtain();
                    try {
                        parcelObtain.unmarshall(bArr, 0, bArr.length);
                        parcelObtain.setDataPosition(0);
                        this.zzcfu = creator.createFromParcel(parcelObtain);
                        parcelObtain.recycle();
                        this.zzcfv = false;
                    } catch (Throwable th) {
                        parcelObtain.recycle();
                        throw th;
                    }
                } catch (IOException e) {
                    zzakb.zzb("Could not read from parcel file descriptor", e);
                    IOUtils.closeQuietly(dataInputStream);
                    return null;
                }
            } catch (Throwable th2) {
                IOUtils.closeQuietly(dataInputStream);
                throw th2;
            }
        }
        return (T) this.zzcfu;
    }
}
