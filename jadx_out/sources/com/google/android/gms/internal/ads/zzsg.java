package com.google.android.gms.internal.ads;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "HttpRequestParcelCreator")
@zzadh
public final class zzsg extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzsg> CREATOR = new zzsh();

    @SafeParcelable.Field(id = 1)
    private final String url;

    @SafeParcelable.Field(id = 2)
    private final String[] zzbnh;

    @SafeParcelable.Field(id = 3)
    private final String[] zzbni;

    @SafeParcelable.Constructor
    zzsg(@SafeParcelable.Param(id = 1) String str, @SafeParcelable.Param(id = 2) String[] strArr, @SafeParcelable.Param(id = 3) String[] strArr2) {
        this.url = str;
        this.zzbnh = strArr;
        this.zzbni = strArr2;
    }

    public static zzsg zzh(zzr zzrVar) {
        Map<String, String> headers = zzrVar.getHeaders();
        int size = headers.size();
        String[] strArr = new String[size];
        String[] strArr2 = new String[size];
        int i = 0;
        for (Map.Entry<String, String> entry : headers.entrySet()) {
            strArr[i] = entry.getKey();
            strArr2[i] = entry.getValue();
            i++;
        }
        return new zzsg(zzrVar.getUrl(), strArr, strArr2);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.url, false);
        SafeParcelWriter.writeStringArray(parcel, 2, this.zzbnh, false);
        SafeParcelWriter.writeStringArray(parcel, 3, this.zzbni, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
