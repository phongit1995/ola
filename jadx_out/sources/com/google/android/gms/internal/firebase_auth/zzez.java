package com.google.android.gms.internal.firebase_auth;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/* JADX INFO: Add missing generic type declarations: [FieldDescriptorType] */
/* JADX INFO: loaded from: classes2.dex */
final class zzez<FieldDescriptorType> extends zzey<FieldDescriptorType, Object> {
    zzez(int i) {
        super(i, null);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzey
    public final void zzbs() {
        if (!isImmutable()) {
            for (int i = 0; i < zzfo(); i++) {
                Map.Entry<FieldDescriptorType, Object> entryZzau = zzau(i);
                if (((zzcu) entryZzau.getKey()).zzdv()) {
                    entryZzau.setValue(Collections.unmodifiableList((List) entryZzau.getValue()));
                }
            }
            for (Map.Entry<FieldDescriptorType, Object> entry : zzfp()) {
                if (((zzcu) entry.getKey()).zzdv()) {
                    entry.setValue(Collections.unmodifiableList((List) entry.getValue()));
                }
            }
        }
        super.zzbs();
    }
}
