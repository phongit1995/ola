package com.google.android.gms.auth.api.credentials;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ReflectedParcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Collections;
import java.util.List;
import javax.annotation.Nonnull;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "CredentialCreator")
@SafeParcelable.Reserved({1000})
public class Credential extends AbstractSafeParcelable implements ReflectedParcelable {
    public static final Parcelable.Creator<Credential> CREATOR = new zzd();
    public static final String EXTRA_KEY = "com.google.android.gms.credentials.Credential";

    @Nullable
    @SafeParcelable.Field(getter = "getName", id = 2)
    private final String mName;

    @Nullable
    @SafeParcelable.Field(getter = "getAccountType", id = 6)
    private final String zzbx;

    @Nonnull
    @SafeParcelable.Field(getter = "getId", id = 1)
    private final String zzci;

    @Nullable
    @SafeParcelable.Field(getter = "getProfilePictureUri", id = 3)
    private final Uri zzcj;

    @Nonnull
    @SafeParcelable.Field(getter = "getIdTokens", id = 4)
    private final List<IdToken> zzck;

    @Nullable
    @SafeParcelable.Field(getter = "getPassword", id = 5)
    private final String zzcl;

    @Nullable
    @SafeParcelable.Field(getter = "getGeneratedPassword", id = 7)
    private final String zzcm;

    @Nullable
    @SafeParcelable.Field(getter = "getGeneratedHintId", id = 8)
    private final String zzcn;

    @Nullable
    @SafeParcelable.Field(getter = "getGivenName", id = 9)
    private final String zzco;

    @Nullable
    @SafeParcelable.Field(getter = "getFamilyName", id = 10)
    private final String zzcp;

    public static class Builder {
        private String mName;
        private String zzbx;
        private final String zzci;
        private Uri zzcj;
        private List<IdToken> zzck;
        private String zzcl;
        private String zzcm;
        private String zzcn;
        private String zzco;
        private String zzcp;

        public Builder(Credential credential) {
            this.zzci = credential.zzci;
            this.mName = credential.mName;
            this.zzcj = credential.zzcj;
            this.zzck = credential.zzck;
            this.zzcl = credential.zzcl;
            this.zzbx = credential.zzbx;
            this.zzcm = credential.zzcm;
            this.zzcn = credential.zzcn;
            this.zzco = credential.zzco;
            this.zzcp = credential.zzcp;
        }

        public Builder(String str) {
            this.zzci = str;
        }

        public Credential build() {
            return new Credential(this.zzci, this.mName, this.zzcj, this.zzck, this.zzcl, this.zzbx, this.zzcm, this.zzcn, this.zzco, this.zzcp);
        }

        public Builder setAccountType(String str) {
            this.zzbx = str;
            return this;
        }

        public Builder setName(String str) {
            this.mName = str;
            return this;
        }

        public Builder setPassword(String str) {
            this.zzcl = str;
            return this;
        }

        public Builder setProfilePictureUri(Uri uri) {
            this.zzcj = uri;
            return this;
        }
    }

    @SafeParcelable.Constructor
    Credential(@SafeParcelable.Param(id = 1) String str, @SafeParcelable.Param(id = 2) String str2, @SafeParcelable.Param(id = 3) Uri uri, @SafeParcelable.Param(id = 4) List<IdToken> list, @SafeParcelable.Param(id = 5) String str3, @SafeParcelable.Param(id = 6) String str4, @SafeParcelable.Param(id = 7) String str5, @SafeParcelable.Param(id = 8) String str6, @SafeParcelable.Param(id = 9) String str7, @SafeParcelable.Param(id = 10) String str8) {
        String strTrim = ((String) Preconditions.checkNotNull(str, "credential identifier cannot be null")).trim();
        Preconditions.checkNotEmpty(strTrim, "credential identifier cannot be empty");
        if (str3 != null && TextUtils.isEmpty(str3)) {
            throw new IllegalArgumentException("Password must not be empty if set");
        }
        if (str4 != null) {
            boolean z = false;
            if (!TextUtils.isEmpty(str4)) {
                Uri uri2 = Uri.parse(str4);
                if (uri2.isAbsolute() && uri2.isHierarchical() && !TextUtils.isEmpty(uri2.getScheme()) && !TextUtils.isEmpty(uri2.getAuthority()) && ("http".equalsIgnoreCase(uri2.getScheme()) || "https".equalsIgnoreCase(uri2.getScheme()))) {
                    z = true;
                }
            }
            if (!Boolean.valueOf(z).booleanValue()) {
                throw new IllegalArgumentException("Account type must be a valid Http/Https URI");
            }
        }
        if (!TextUtils.isEmpty(str4) && !TextUtils.isEmpty(str3)) {
            throw new IllegalArgumentException("Password and AccountType are mutually exclusive");
        }
        if (str2 != null && TextUtils.isEmpty(str2.trim())) {
            str2 = null;
        }
        this.mName = str2;
        this.zzcj = uri;
        this.zzck = list == null ? Collections.emptyList() : Collections.unmodifiableList(list);
        this.zzci = strTrim;
        this.zzcl = str3;
        this.zzbx = str4;
        this.zzcm = str5;
        this.zzcn = str6;
        this.zzco = str7;
        this.zzcp = str8;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof Credential)) {
            return false;
        }
        Credential credential = (Credential) obj;
        return TextUtils.equals(this.zzci, credential.zzci) && TextUtils.equals(this.mName, credential.mName) && Objects.equal(this.zzcj, credential.zzcj) && TextUtils.equals(this.zzcl, credential.zzcl) && TextUtils.equals(this.zzbx, credential.zzbx) && TextUtils.equals(this.zzcm, credential.zzcm);
    }

    @Nullable
    public String getAccountType() {
        return this.zzbx;
    }

    @Nullable
    public String getFamilyName() {
        return this.zzcp;
    }

    @Nullable
    public String getGeneratedPassword() {
        return this.zzcm;
    }

    @Nullable
    public String getGivenName() {
        return this.zzco;
    }

    @Nonnull
    public String getId() {
        return this.zzci;
    }

    @Nonnull
    public List<IdToken> getIdTokens() {
        return this.zzck;
    }

    @Nullable
    public String getName() {
        return this.mName;
    }

    @Nullable
    public String getPassword() {
        return this.zzcl;
    }

    @Nullable
    public Uri getProfilePictureUri() {
        return this.zzcj;
    }

    public int hashCode() {
        return Objects.hashCode(this.zzci, this.mName, this.zzcj, this.zzcl, this.zzbx, this.zzcm);
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getId(), false);
        SafeParcelWriter.writeString(parcel, 2, getName(), false);
        SafeParcelWriter.writeParcelable(parcel, 3, getProfilePictureUri(), i, false);
        SafeParcelWriter.writeTypedList(parcel, 4, getIdTokens(), false);
        SafeParcelWriter.writeString(parcel, 5, getPassword(), false);
        SafeParcelWriter.writeString(parcel, 6, getAccountType(), false);
        SafeParcelWriter.writeString(parcel, 7, getGeneratedPassword(), false);
        SafeParcelWriter.writeString(parcel, 8, this.zzcn, false);
        SafeParcelWriter.writeString(parcel, 9, getGivenName(), false);
        SafeParcelWriter.writeString(parcel, 10, getFamilyName(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
