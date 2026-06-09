package com.google.android.gms.internal.measurement;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/* JADX INFO: Add missing generic type declarations: [FieldDescriptorType] */
/* JADX INFO: loaded from: classes2.dex */
final class zzabe<FieldDescriptorType> extends zzabd<FieldDescriptorType, Object> {
    zzabe(int i) {
        super(i, null);
    }

    @Override // com.google.android.gms.internal.measurement.zzabd
    public final void zzru() {
        if (!isImmutable()) {
            for (int i = 0; i < zzuy(); i++) {
                Map.Entry<FieldDescriptorType, Object> entryZzah = zzah(i);
                if (((zzzt) entryZzah.getKey()).zztz()) {
                    entryZzah.setValue(Collections.unmodifiableList((List) entryZzah.getValue()));
                }
            }
            for (Map.Entry<FieldDescriptorType, Object> entry : zzuz()) {
                if (((zzzt) entry.getKey()).zztz()) {
                    entry.setValue(Collections.unmodifiableList((List) entry.getValue()));
                }
            }
        }
        super.zzru();
    }
}
