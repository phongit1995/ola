package chat.ola.vn.mediastore;

import android.os.Parcel;
import android.os.Parcelable;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaMediaEntity implements Parcelable {
    public static final Parcelable.Creator<OlaMediaEntity> CREATOR = new Parcelable.Creator<OlaMediaEntity>() { // from class: chat.ola.vn.mediastore.OlaMediaEntity.1
        @Override // android.os.Parcelable.Creator
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public OlaMediaEntity createFromParcel(Parcel parcel) {
            return new OlaMediaEntity(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public OlaMediaEntity[] newArray(int i) {
            return new OlaMediaEntity[i];
        }
    };
    private int a;
    private String b;
    private short c;
    private boolean d;
    private String e;
    private String f;
    private String g;

    public OlaMediaEntity(Parcel parcel) {
        this.d = true;
        if (parcel != null) {
            try {
                this.a = parcel.readInt();
                this.b = parcel.readString();
                this.c = (short) parcel.readInt();
                this.d = Boolean.parseBoolean(parcel.readString());
                this.e = parcel.readString();
                this.f = parcel.readString();
                this.g = parcel.readString();
            } catch (Throwable unused) {
            }
        }
    }

    public OlaMediaEntity(String str, int i, short s) {
        this.d = true;
        this.a = i;
        this.b = str;
        this.c = s;
    }

    public static ArrayList<OlaMediaEntity> a(int i, short s, boolean z, String... strArr) {
        if (strArr == null || strArr.length == 0) {
            return null;
        }
        return a((List<String>) Arrays.asList(strArr), i, s, z);
    }

    public static ArrayList<OlaMediaEntity> a(int i, short s, String... strArr) {
        return a(i, s, true, strArr);
    }

    public static ArrayList<OlaMediaEntity> a(List<String> list) {
        if (list == null || list.isEmpty()) {
            return null;
        }
        ArrayList<OlaMediaEntity> arrayList = new ArrayList<>();
        for (String str : list) {
            if (!m.a(str)) {
                arrayList.add(new OlaMediaEntity(str, 1, o.g(str)));
            }
        }
        return arrayList;
    }

    public static ArrayList<OlaMediaEntity> a(List<String> list, int i, short s, boolean z) {
        if (list == null || list.isEmpty()) {
            return null;
        }
        ArrayList<OlaMediaEntity> arrayList = new ArrayList<>();
        for (String str : list) {
            if (!m.a(str)) {
                OlaMediaEntity olaMediaEntity = new OlaMediaEntity(str, i, s);
                olaMediaEntity.a(z);
                arrayList.add(olaMediaEntity);
            }
        }
        return arrayList;
    }

    public static ArrayList<OlaMediaEntity> a(String... strArr) {
        return a((List<String>) Arrays.asList(strArr));
    }

    public int a() {
        return this.a;
    }

    public void a(String str) {
        this.e = str;
    }

    public void a(boolean z) {
        this.d = z;
    }

    public short b() {
        return this.c;
    }

    public void b(String str) {
        this.f = str;
    }

    public String c() {
        return this.b;
    }

    public void c(String str) {
        this.g = str;
    }

    public boolean d() {
        return this.d;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        OlaMediaEntity olaMediaEntity = (OlaMediaEntity) obj;
        if (this.a == olaMediaEntity.a && this.c == olaMediaEntity.c) {
            return m.b(this.b, olaMediaEntity.b);
        }
        return false;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        if (parcel != null) {
            parcel.writeInt(this.a);
            parcel.writeString(this.b);
            parcel.writeInt(this.c);
            parcel.writeString(String.valueOf(this.d));
            parcel.writeString(!m.a(this.e) ? this.e : "");
            parcel.writeString(!m.a(this.f) ? this.f : "");
            parcel.writeString(!m.a(this.g) ? this.g : "");
        }
    }
}
