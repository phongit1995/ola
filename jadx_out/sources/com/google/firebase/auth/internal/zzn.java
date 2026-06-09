package com.google.firebase.auth.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.firebase.auth.FirebaseUserMetadata;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "DefaultFirebaseUserMetadataCreator")
public final class zzn implements FirebaseUserMetadata {
    public static final Parcelable.Creator<zzn> CREATOR = new zzo();

    @SafeParcelable.Field(getter = "getCreationTimestamp", id = 2)
    private long zzjs;

    @SafeParcelable.Field(getter = "getLastSignInTimestamp", id = 1)
    private long zzlf;

    @SafeParcelable.Constructor
    public zzn(@SafeParcelable.Param(id = 1) long j, @SafeParcelable.Param(id = 2) long j2) {
        this.zzlf = j;
        this.zzjs = j2;
    }

    public static zzn zza(JSONObject jSONObject) {
        if (jSONObject == null) {
            return null;
        }
        try {
            return new zzn(jSONObject.getLong("lastSignInTimestamp"), jSONObject.getLong("creationTimestamp"));
        } catch (JSONException unused) {
            return null;
        }
    }

    @Override // android.os.Parcelable
    public final int describeContents() {
        return 0;
    }

    @Override // com.google.firebase.auth.FirebaseUserMetadata
    public final long getCreationTimestamp() {
        return this.zzjs;
    }

    @Override // com.google.firebase.auth.FirebaseUserMetadata
    public final long getLastSignInTimestamp() {
        return this.zzlf;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeLong(parcel, 1, getLastSignInTimestamp());
        SafeParcelWriter.writeLong(parcel, 2, getCreationTimestamp());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final JSONObject zzbh() {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put("lastSignInTimestamp", this.zzlf);
            jSONObject.put("creationTimestamp", this.zzjs);
        } catch (JSONException unused) {
        }
        return jSONObject;
    }
}
