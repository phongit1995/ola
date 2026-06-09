package com.google.android.gms.auth.api.accounttransfer;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.app.NotificationCompat;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.server.response.FastJsonResponse;
import com.google.android.gms.internal.auth.zzbs;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AccountTransferMsgCreator")
public final class zzo extends zzbs {
    public static final Parcelable.Creator<zzo> CREATOR = new zzp();
    private static final HashMap<String, FastJsonResponse.Field<?, ?>> zzbk;

    @SafeParcelable.Indicator
    private final Set<Integer> zzbl;

    @SafeParcelable.Field(getter = "getAuthenticatorDatas", id = 2)
    private ArrayList<zzu> zzbm;

    @SafeParcelable.Field(getter = "getRequestType", id = 3)
    private int zzbn;

    @SafeParcelable.Field(getter = "getProgress", id = 4)
    private zzr zzbo;

    @SafeParcelable.VersionField(id = 1)
    private final int zzy;

    static {
        HashMap<String, FastJsonResponse.Field<?, ?>> map = new HashMap<>();
        zzbk = map;
        map.put("authenticatorData", FastJsonResponse.Field.forConcreteTypeArray("authenticatorData", 2, zzu.class));
        zzbk.put(NotificationCompat.CATEGORY_PROGRESS, FastJsonResponse.Field.forConcreteType(NotificationCompat.CATEGORY_PROGRESS, 4, zzr.class));
    }

    public zzo() {
        this.zzbl = new HashSet(1);
        this.zzy = 1;
    }

    @SafeParcelable.Constructor
    zzo(@SafeParcelable.Indicator Set<Integer> set, @SafeParcelable.Param(id = 1) int i, @SafeParcelable.Param(id = 2) ArrayList<zzu> arrayList, @SafeParcelable.Param(id = 3) int i2, @SafeParcelable.Param(id = 4) zzr zzrVar) {
        this.zzbl = set;
        this.zzy = i;
        this.zzbm = arrayList;
        this.zzbn = i2;
        this.zzbo = zzrVar;
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    public final <T extends FastJsonResponse> void addConcreteTypeArrayInternal(FastJsonResponse.Field<?, ?> field, String str, ArrayList<T> arrayList) {
        int safeParcelableFieldId = field.getSafeParcelableFieldId();
        if (safeParcelableFieldId != 2) {
            throw new IllegalArgumentException(String.format("Field with id=%d is not a known ConcreteTypeArray type. Found %s", Integer.valueOf(safeParcelableFieldId), arrayList.getClass().getCanonicalName()));
        }
        this.zzbm = arrayList;
        this.zzbl.add(Integer.valueOf(safeParcelableFieldId));
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    public final <T extends FastJsonResponse> void addConcreteTypeInternal(FastJsonResponse.Field<?, ?> field, String str, T t) {
        int safeParcelableFieldId = field.getSafeParcelableFieldId();
        if (safeParcelableFieldId != 4) {
            throw new IllegalArgumentException(String.format("Field with id=%d is not a known custom type. Found %s", Integer.valueOf(safeParcelableFieldId), t.getClass().getCanonicalName()));
        }
        this.zzbo = (zzr) t;
        this.zzbl.add(Integer.valueOf(safeParcelableFieldId));
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    public final /* synthetic */ Map getFieldMappings() {
        return zzbk;
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    protected final Object getFieldValue(FastJsonResponse.Field field) {
        int safeParcelableFieldId = field.getSafeParcelableFieldId();
        if (safeParcelableFieldId == 4) {
            return this.zzbo;
        }
        switch (safeParcelableFieldId) {
            case 1:
                return Integer.valueOf(this.zzy);
            case 2:
                return this.zzbm;
            default:
                int safeParcelableFieldId2 = field.getSafeParcelableFieldId();
                StringBuilder sb = new StringBuilder(37);
                sb.append("Unknown SafeParcelable id=");
                sb.append(safeParcelableFieldId2);
                throw new IllegalStateException(sb.toString());
        }
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    protected final boolean isFieldSet(FastJsonResponse.Field field) {
        return this.zzbl.contains(Integer.valueOf(field.getSafeParcelableFieldId()));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        Set<Integer> set = this.zzbl;
        if (set.contains(1)) {
            SafeParcelWriter.writeInt(parcel, 1, this.zzy);
        }
        if (set.contains(2)) {
            SafeParcelWriter.writeTypedList(parcel, 2, this.zzbm, true);
        }
        if (set.contains(3)) {
            SafeParcelWriter.writeInt(parcel, 3, this.zzbn);
        }
        if (set.contains(4)) {
            SafeParcelWriter.writeParcelable(parcel, 4, this.zzbo, i, true);
        }
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
