package com.google.android.gms.auth.api;

import android.os.Bundle;
import android.support.annotation.NonNull;
import com.google.android.gms.auth.api.credentials.CredentialsApi;
import com.google.android.gms.auth.api.credentials.PasswordSpecification;
import com.google.android.gms.auth.api.proxy.ProxyApi;
import com.google.android.gms.auth.api.signin.GoogleSignInApi;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.internal.auth.zzao;
import com.google.android.gms.internal.auth.zzax;
import com.google.android.gms.internal.auth.zzbn;

/* JADX INFO: loaded from: classes.dex */
public final class Auth {
    public static final Api.ClientKey<zzax> zzaj = new Api.ClientKey<>();
    public static final Api.ClientKey<com.google.android.gms.auth.api.signin.internal.zzh> zzak = new Api.ClientKey<>();
    private static final Api.AbstractClientBuilder<zzax, AuthCredentialsOptions> zzal = new zzd();
    private static final Api.AbstractClientBuilder<com.google.android.gms.auth.api.signin.internal.zzh, GoogleSignInOptions> zzam = new zze();

    @KeepForSdk
    public static final Api<zzh> PROXY_API = zzf.API;
    public static final Api<AuthCredentialsOptions> CREDENTIALS_API = new Api<>("Auth.CREDENTIALS_API", zzal, zzaj);
    public static final Api<GoogleSignInOptions> GOOGLE_SIGN_IN_API = new Api<>("Auth.GOOGLE_SIGN_IN_API", zzam, zzak);

    @KeepForSdk
    public static final ProxyApi ProxyApi = new zzbn();
    public static final CredentialsApi CredentialsApi = new zzao();
    public static final GoogleSignInApi GoogleSignInApi = new com.google.android.gms.auth.api.signin.internal.zzg();

    @Deprecated
    public static class AuthCredentialsOptions implements Api.ApiOptions.Optional {
        private static final AuthCredentialsOptions zzan = new Builder().zzh();
        private final String zzao = null;
        private final PasswordSpecification zzap;
        private final boolean zzaq;

        @Deprecated
        public static class Builder {

            @NonNull
            protected PasswordSpecification zzap = PasswordSpecification.zzdg;
            protected Boolean zzar = false;

            public Builder forceEnableSaveDialog() {
                this.zzar = true;
                return this;
            }

            public AuthCredentialsOptions zzh() {
                return new AuthCredentialsOptions(this);
            }
        }

        public AuthCredentialsOptions(Builder builder) {
            this.zzap = builder.zzap;
            this.zzaq = builder.zzar.booleanValue();
        }

        public final Bundle toBundle() {
            Bundle bundle = new Bundle();
            bundle.putString("consumer_package", null);
            bundle.putParcelable("password_specification", this.zzap);
            bundle.putBoolean("force_save_dialog", this.zzaq);
            return bundle;
        }

        public final PasswordSpecification zzg() {
            return this.zzap;
        }
    }

    private Auth() {
    }
}
