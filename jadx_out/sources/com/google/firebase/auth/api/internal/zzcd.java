package com.google.firebase.auth.api.internal;

import android.content.Context;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Looper;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.internal.ClientSettings;
import com.google.android.gms.common.internal.GmsClient;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.logging.Logger;
import com.google.android.gms.dynamite.DynamiteModule;

/* JADX INFO: loaded from: classes2.dex */
public final class zzcd extends GmsClient<zzck> implements zzcc {
    private static Logger zzdx = new Logger("FirebaseAuth", "FirebaseAuth:");
    private final Context zzgs;
    private final zzcp zzhi;

    public zzcd(Context context, Looper looper, ClientSettings clientSettings, zzcp zzcpVar, GoogleApiClient.ConnectionCallbacks connectionCallbacks, GoogleApiClient.OnConnectionFailedListener onConnectionFailedListener) {
        super(context, looper, 112, clientSettings, connectionCallbacks, onConnectionFailedListener);
        this.zzgs = (Context) Preconditions.checkNotNull(context);
        this.zzhi = zzcpVar;
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected final /* synthetic */ IInterface createServiceInterface(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.firebase.auth.api.internal.IFirebaseAuthService");
        return iInterfaceQueryLocalInterface instanceof zzck ? (zzck) iInterfaceQueryLocalInterface : new zzcm(iBinder);
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected final Bundle getGetServiceRequestExtraArgs() {
        Bundle getServiceRequestExtraArgs = super.getGetServiceRequestExtraArgs();
        if (getServiceRequestExtraArgs == null) {
            getServiceRequestExtraArgs = new Bundle();
        }
        if (this.zzhi != null) {
            getServiceRequestExtraArgs.putString("com.google.firebase.auth.API_KEY", this.zzhi.getApiKey());
        }
        return getServiceRequestExtraArgs;
    }

    @Override // com.google.android.gms.common.internal.GmsClient, com.google.android.gms.common.internal.BaseGmsClient, com.google.android.gms.common.api.Api.Client
    public final int getMinApkVersion() {
        return 12451000;
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected final String getServiceDescriptor() {
        return "com.google.firebase.auth.api.internal.IFirebaseAuthService";
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected final String getStartServiceAction() {
        return "com.google.firebase.auth.api.gms.service.START";
    }

    /* JADX WARN: Removed duplicated region for block: B:16:0x0033  */
    @Override // com.google.android.gms.common.internal.BaseGmsClient
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected final java.lang.String getStartServicePackage() {
        /*
            r6 = this;
            java.lang.String r0 = "firebear.preference"
            java.lang.String r0 = com.google.firebase.auth.api.internal.zzdo.getProperty(r0)
            boolean r1 = android.text.TextUtils.isEmpty(r0)
            if (r1 == 0) goto Le
            java.lang.String r0 = "default"
        Le:
            int r1 = r0.hashCode()
            r2 = 103145323(0x625df6b, float:3.1197192E-35)
            r3 = -1
            r4 = 0
            if (r1 == r2) goto L29
            r5 = 1544803905(0x5c13d641, float:1.66449585E17)
            if (r1 == r5) goto L1f
            goto L33
        L1f:
            java.lang.String r1 = "default"
            boolean r1 = r0.equals(r1)
            if (r1 == 0) goto L33
            r1 = 1
            goto L34
        L29:
            java.lang.String r1 = "local"
            boolean r1 = r0.equals(r1)
            if (r1 == 0) goto L33
            r1 = 0
            goto L34
        L33:
            r1 = -1
        L34:
            switch(r1) {
                case 0: goto L39;
                case 1: goto L39;
                default: goto L37;
            }
        L37:
            java.lang.String r0 = "default"
        L39:
            int r1 = r0.hashCode()
            if (r1 == r2) goto L40
            goto L49
        L40:
            java.lang.String r1 = "local"
            boolean r0 = r0.equals(r1)
            if (r0 == 0) goto L49
            r3 = 0
        L49:
            if (r3 == 0) goto L76
            com.google.android.gms.common.logging.Logger r0 = com.google.firebase.auth.api.internal.zzcd.zzdx
            java.lang.String r1 = "Loading module via FirebaseOptions."
            java.lang.Object[] r2 = new java.lang.Object[r4]
            r0.i(r1, r2)
            com.google.firebase.auth.api.internal.zzcp r0 = r6.zzhi
            boolean r0 = r0.zzgn
            if (r0 == 0) goto L6a
            com.google.android.gms.common.logging.Logger r0 = com.google.firebase.auth.api.internal.zzcd.zzdx
            java.lang.String r1 = "Preparing to create service connection to fallback implementation"
            java.lang.Object[] r2 = new java.lang.Object[r4]
            r0.i(r1, r2)
            android.content.Context r0 = r6.zzgs
            java.lang.String r0 = r0.getPackageName()
            return r0
        L6a:
            com.google.android.gms.common.logging.Logger r0 = com.google.firebase.auth.api.internal.zzcd.zzdx
            java.lang.String r1 = "Preparing to create service connection to gms implementation"
            java.lang.Object[] r2 = new java.lang.Object[r4]
            r0.i(r1, r2)
            java.lang.String r0 = "com.google.android.gms"
            return r0
        L76:
            com.google.android.gms.common.logging.Logger r0 = com.google.firebase.auth.api.internal.zzcd.zzdx
            java.lang.String r1 = "Loading fallback module override."
            java.lang.Object[] r2 = new java.lang.Object[r4]
            r0.i(r1, r2)
            android.content.Context r0 = r6.zzgs
            java.lang.String r0 = r0.getPackageName()
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.firebase.auth.api.internal.zzcd.getStartServicePackage():java.lang.String");
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient, com.google.android.gms.common.api.Api.Client
    public final boolean requiresGooglePlayServices() {
        return DynamiteModule.getLocalVersion(this.zzgs, "com.google.firebase.auth") == 0;
    }

    @Override // com.google.firebase.auth.api.internal.zzcc
    public final /* synthetic */ zzck zzaf() {
        return (zzck) super.getService();
    }
}
