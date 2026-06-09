package com.google.android.gms.internal.ads;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/* JADX INFO: Add missing generic type declarations: [FieldDescriptorType] */
/* JADX INFO: loaded from: classes.dex */
final class zzbdq<FieldDescriptorType> extends zzbdp<FieldDescriptorType, Object> {
    zzbdq(int i) {
        super(i, null);
    }

    @Override // com.google.android.gms.internal.ads.zzbdp
    public final void zzaaz() {
        if (!isImmutable()) {
            for (int i = 0; i < zzafs(); i++) {
                Map.Entry<FieldDescriptorType, Object> entryZzcy = zzcy(i);
                if (((zzbbi) entryZzcy.getKey()).zzada()) {
                    entryZzcy.setValue(Collections.unmodifiableList((List) entryZzcy.getValue()));
                }
            }
            for (Map.Entry<FieldDescriptorType, Object> entry : zzaft()) {
                if (((zzbbi) entry.getKey()).zzada()) {
                    entry.setValue(Collections.unmodifiableList((List) entry.getValue()));
                }
            }
        }
        super.zzaaz();
    }
}
