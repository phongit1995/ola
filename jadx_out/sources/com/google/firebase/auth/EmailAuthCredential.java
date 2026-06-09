package com.google.firebase.auth;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.logging.Logger;

/* JADX INFO: loaded from: classes2.dex */
@SafeParcelable.Class(creator = "EmailAuthCredentialCreator")
public class EmailAuthCredential extends AuthCredential {
    public static final Parcelable.Creator<EmailAuthCredential> CREATOR = new zzf();
    private static final Logger zzdx = new Logger("EmailAuthCredential", new String[0]);

    @SafeParcelable.Field(getter = "getEmail", id = 1)
    private String zzah;

    @SafeParcelable.Field(getter = "getPassword", id = 2)
    private String zzbi;

    @SafeParcelable.Field(getter = "getSignInLink", id = 3)
    private final String zzdy;

    @SafeParcelable.Field(getter = "getCachedState", id = 4)
    private String zzdz;

    @SafeParcelable.Field(getter = "isForLinking", id = 5)
    private boolean zzea;

    EmailAuthCredential(String str, String str2) {
        this(str, str2, null, null, false);
    }

    @SafeParcelable.Constructor
    EmailAuthCredential(@SafeParcelable.Param(id = 1) @NonNull String str, @SafeParcelable.Param(id = 2) @NonNull String str2, @SafeParcelable.Param(id = 3) @NonNull String str3, @SafeParcelable.Param(id = 4) @NonNull String str4, @SafeParcelable.Param(id = 5) @NonNull boolean z) {
        this.zzah = Preconditions.checkNotEmpty(str);
        if (TextUtils.isEmpty(str2) && TextUtils.isEmpty(str3)) {
            throw new IllegalArgumentException("Cannot create an EmailAuthCredential without a password or emailLink.");
        }
        this.zzbi = str2;
        this.zzdy = str3;
        this.zzdz = str4;
        this.zzea = z;
    }

    public static boolean isSignInWithEmailLink(@NonNull String str) {
        if (TextUtils.isEmpty(str)) {
            return false;
        }
        try {
            if (zzb(str)) {
                return true;
            }
            return zzb(Uri.parse(str).getQueryParameter("link"));
        } catch (UnsupportedOperationException e) {
            Logger logger = zzdx;
            Object[] objArr = new Object[1];
            String strValueOf = String.valueOf(e.getMessage());
            objArr[0] = strValueOf.length() != 0 ? "isSignInWithEmailLink returned an UnsupportedOperationException: ".concat(strValueOf) : new String("isSignInWithEmailLink returned an UnsupportedOperationException: ");
            logger.v("EmailAuthCredential", objArr);
            return false;
        }
    }

    private static boolean zzb(@NonNull String str) {
        if (TextUtils.isEmpty(str)) {
            return false;
        }
        Uri uri = Uri.parse(str);
        String queryParameter = uri.getQueryParameter("oobCode");
        String queryParameter2 = uri.getQueryParameter("mode");
        return (TextUtils.isEmpty(queryParameter) || TextUtils.isEmpty(queryParameter2) || !queryParameter2.equals("signIn")) ? false : true;
    }

    @NonNull
    public final String getEmail() {
        return this.zzah;
    }

    @NonNull
    public final String getPassword() {
        return this.zzbi;
    }

    @Override // com.google.firebase.auth.AuthCredential
    @NonNull
    public String getProvider() {
        return "password";
    }

    @Override // com.google.firebase.auth.AuthCredential
    public String getSignInMethod() {
        return !TextUtils.isEmpty(this.zzbi) ? "password" : EmailAuthProvider.EMAIL_LINK_SIGN_IN_METHOD;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzah, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzbi, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzdy, false);
        SafeParcelWriter.writeString(parcel, 4, this.zzdz, false);
        SafeParcelWriter.writeBoolean(parcel, 5, this.zzea);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final EmailAuthCredential zza(@Nullable FirebaseUser firebaseUser) {
        this.zzdz = firebaseUser.zzq();
        this.zzea = true;
        return this;
    }

    @NonNull
    public final String zzg() {
        return this.zzdy;
    }

    @Nullable
    public final String zzh() {
        return this.zzdz;
    }

    public final boolean zzi() {
        return this.zzea;
    }

    public final boolean zzj() {
        return !TextUtils.isEmpty(this.zzdy);
    }
}
