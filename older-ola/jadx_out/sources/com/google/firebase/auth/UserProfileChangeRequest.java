package com.google.firebase.auth;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "UserProfileChangeRequestCreator")
@SafeParcelable.Reserved({1})
public class UserProfileChangeRequest extends AbstractSafeParcelable {
    public static final Parcelable.Creator<UserProfileChangeRequest> CREATOR = new zzy();

    @SafeParcelable.Field(getter = "getDisplayName", id = 2)
    private String zzbh;

    @SafeParcelable.Field(getter = "getPhotoUrl", id = 3)
    private String zzbr;

    @SafeParcelable.Field(getter = "shouldRemoveDisplayName", id = 4)
    private boolean zzff;

    @SafeParcelable.Field(getter = "shouldRemovePhotoUri", id = 5)
    private boolean zzfg;
    private Uri zzfh;

    public static class Builder {
        private String zzbh;
        private boolean zzff;
        private boolean zzfg;
        private Uri zzfh;

        public UserProfileChangeRequest build() {
            return new UserProfileChangeRequest(this.zzbh, this.zzfh == null ? null : this.zzfh.toString(), this.zzff, this.zzfg);
        }

        public Builder setDisplayName(@Nullable String str) {
            if (str == null) {
                this.zzff = true;
                return this;
            }
            this.zzbh = str;
            return this;
        }

        public Builder setPhotoUri(@Nullable Uri uri) {
            if (uri == null) {
                this.zzfg = true;
                return this;
            }
            this.zzfh = uri;
            return this;
        }
    }

    @SafeParcelable.Constructor
    UserProfileChangeRequest(@SafeParcelable.Param(id = 2) String str, @SafeParcelable.Param(id = 3) String str2, @SafeParcelable.Param(id = 4) boolean z, @SafeParcelable.Param(id = 5) boolean z2) {
        this.zzbh = str;
        this.zzbr = str2;
        this.zzff = z;
        this.zzfg = z2;
        this.zzfh = TextUtils.isEmpty(str2) ? null : Uri.parse(str2);
    }

    @Nullable
    public String getDisplayName() {
        return this.zzbh;
    }

    @Nullable
    public Uri getPhotoUri() {
        return this.zzfh;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, getDisplayName(), false);
        SafeParcelWriter.writeString(parcel, 3, this.zzbr, false);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzff);
        SafeParcelWriter.writeBoolean(parcel, 5, this.zzfg);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final String zzt() {
        return this.zzbr;
    }

    public final boolean zzu() {
        return this.zzff;
    }

    public final boolean zzv() {
        return this.zzfg;
    }
}
