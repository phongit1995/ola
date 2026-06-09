package com.google.firebase.analytics.connector.internal;

import android.content.Context;
import com.google.firebase.analytics.connector.AnalyticsConnectorImpl;
import com.google.firebase.components.ComponentContainer;
import com.google.firebase.components.ComponentFactory;

/* JADX INFO: loaded from: classes2.dex */
final /* synthetic */ class zzb implements ComponentFactory {
    static final ComponentFactory zzbql = new zzb();

    private zzb() {
    }

    @Override // com.google.firebase.components.ComponentFactory
    public final Object create(ComponentContainer componentContainer) {
        return AnalyticsConnectorImpl.getInstance((Context) componentContainer.get(Context.class));
    }
}
