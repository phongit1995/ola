package com.google.android.gms.internal.auth;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.annotation.Nullable;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.credentials.CredentialsApi;
import com.google.android.gms.auth.api.credentials.HintRequest;
import com.google.android.gms.auth.api.credentials.PasswordSpecification;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelableSerializer;

/* JADX INFO: loaded from: classes.dex */
public final class zzaw {
    public static PendingIntent zzd(Context context, @Nullable Auth.AuthCredentialsOptions authCredentialsOptions, HintRequest hintRequest) {
        Preconditions.checkNotNull(context, "context must not be null");
        Preconditions.checkNotNull(hintRequest, "request must not be null");
        PasswordSpecification passwordSpecificationZzg = (authCredentialsOptions == null || authCredentialsOptions.zzg() == null) ? PasswordSpecification.zzdg : authCredentialsOptions.zzg();
        Intent intentPutExtra = new Intent("com.google.android.gms.auth.api.credentials.PICKER").putExtra("com.google.android.gms.credentials.hintRequestVersion", 2).putExtra("com.google.android.gms.credentials.RequestType", "Hints").putExtra("com.google.android.gms.credentials.ClaimedCallingPackage", (String) null);
        SafeParcelableSerializer.serializeToIntentExtra(passwordSpecificationZzg, intentPutExtra, "com.google.android.gms.credentials.PasswordSpecification");
        SafeParcelableSerializer.serializeToIntentExtra(hintRequest, intentPutExtra, "com.google.android.gms.credentials.HintRequest");
        return PendingIntent.getActivity(context, CredentialsApi.CREDENTIAL_PICKER_REQUEST_CODE, intentPutExtra, 134217728);
    }
}
