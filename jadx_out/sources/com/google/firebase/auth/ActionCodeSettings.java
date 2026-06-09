package com.google.firebase.auth;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "ActionCodeSettingsCreator")
public class ActionCodeSettings extends AbstractSafeParcelable {
    public static final Parcelable.Creator<ActionCodeSettings> CREATOR = new zzb();

    @SafeParcelable.Field(getter = "getUrl", id = 1)
    private final String url;

    @SafeParcelable.Field(getter = "getRequestType", id = 9)
    private int zzao;

    @SafeParcelable.Field(getter = "getAndroidPackageName", id = 4)
    private final String zzaw;

    @SafeParcelable.Field(getter = "getAndroidInstallApp", id = 5)
    private final boolean zzax;

    @SafeParcelable.Field(getter = "getAndroidMinimumVersion", id = 6)
    private final String zzay;

    @SafeParcelable.Field(getter = "canHandleCodeInApp", id = 7)
    private final boolean zzaz;

    @SafeParcelable.Field(getter = "getIOSBundle", id = 2)
    private final String zzds;

    @SafeParcelable.Field(getter = "getIOSAppStoreId", id = 3)
    private final String zzdt;

    @SafeParcelable.Field(getter = "getLocaleHeader", id = 8)
    private String zzdu;

    public static class Builder {
        private String url;
        private String zzaw;
        private boolean zzax;
        private String zzay;
        private boolean zzaz;
        private String zzds;

        private Builder() {
            this.zzaz = false;
        }

        public ActionCodeSettings build() {
            if (this.url == null) {
                throw new IllegalArgumentException("Cannot build ActionCodeSettings with null URL. Call #setUrl(String) before calling build()");
            }
            return new ActionCodeSettings(this);
        }

        public Builder setAndroidPackageName(@NonNull String str, boolean z, @Nullable String str2) {
            this.zzaw = str;
            this.zzax = z;
            this.zzay = str2;
            return this;
        }

        public Builder setHandleCodeInApp(boolean z) {
            this.zzaz = z;
            return this;
        }

        public Builder setIOSBundleId(@NonNull String str) {
            this.zzds = str;
            return this;
        }

        public Builder setUrl(@NonNull String str) {
            this.url = str;
            return this;
        }
    }

    private ActionCodeSettings(Builder builder) {
        this.url = builder.url;
        this.zzds = builder.zzds;
        this.zzdt = null;
        this.zzaw = builder.zzaw;
        this.zzax = builder.zzax;
        this.zzay = builder.zzay;
        this.zzaz = builder.zzaz;
    }

    @SafeParcelable.Constructor
    ActionCodeSettings(@SafeParcelable.Param(id = 1) String str, @SafeParcelable.Param(id = 2) String str2, @SafeParcelable.Param(id = 3) String str3, @SafeParcelable.Param(id = 4) String str4, @SafeParcelable.Param(id = 5) boolean z, @SafeParcelable.Param(id = 6) String str5, @SafeParcelable.Param(id = 7) boolean z2, @SafeParcelable.Param(id = 8) String str6, @SafeParcelable.Param(id = 9) int i) {
        this.url = str;
        this.zzds = str2;
        this.zzdt = str3;
        this.zzaw = str4;
        this.zzax = z;
        this.zzay = str5;
        this.zzaz = z2;
        this.zzdu = str6;
        this.zzao = i;
    }

    public static Builder newBuilder() {
        return new Builder();
    }

    public static ActionCodeSettings zze() {
        return new ActionCodeSettings(new Builder());
    }

    public boolean canHandleCodeInApp() {
        return this.zzaz;
    }

    public boolean getAndroidInstallApp() {
        return this.zzax;
    }

    public String getAndroidMinimumVersion() {
        return this.zzay;
    }

    public String getAndroidPackageName() {
        return this.zzaw;
    }

    public String getIOSBundle() {
        return this.zzds;
    }

    public final int getRequestType() {
        return this.zzao;
    }

    public String getUrl() {
        return this.url;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getUrl(), false);
        SafeParcelWriter.writeString(parcel, 2, getIOSBundle(), false);
        SafeParcelWriter.writeString(parcel, 3, this.zzdt, false);
        SafeParcelWriter.writeString(parcel, 4, getAndroidPackageName(), false);
        SafeParcelWriter.writeBoolean(parcel, 5, getAndroidInstallApp());
        SafeParcelWriter.writeString(parcel, 6, getAndroidMinimumVersion(), false);
        SafeParcelWriter.writeBoolean(parcel, 7, canHandleCodeInApp());
        SafeParcelWriter.writeString(parcel, 8, this.zzdu, false);
        SafeParcelWriter.writeInt(parcel, 9, this.zzao);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final void zza(@NonNull String str) {
        this.zzdu = str;
    }

    public final void zzb(@NonNull int i) {
        this.zzao = i;
    }

    public final String zzf() {
        return this.zzdt;
    }
}
