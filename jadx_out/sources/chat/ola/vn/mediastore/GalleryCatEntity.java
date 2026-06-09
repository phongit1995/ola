package chat.ola.vn.mediastore;

import android.os.Parcel;
import android.os.Parcelable;

/* JADX INFO: loaded from: classes.dex */
public class GalleryCatEntity extends GalleryEntity {
    public static final Parcelable.Creator<GalleryCatEntity> CREATOR = new Parcelable.Creator<GalleryCatEntity>() { // from class: chat.ola.vn.mediastore.GalleryCatEntity.1
        @Override // android.os.Parcelable.Creator
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public GalleryCatEntity createFromParcel(Parcel parcel) {
            return new GalleryCatEntity(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public GalleryCatEntity[] newArray(int i) {
            return new GalleryCatEntity[i];
        }
    };
    public String a;
    public String b;
    public String c;
    public String d;

    public GalleryCatEntity() {
    }

    public GalleryCatEntity(Parcel parcel) {
        super(parcel);
        if (parcel != null) {
            try {
                this.a = parcel.readString();
                this.b = parcel.readString();
                this.c = parcel.readString();
                this.d = parcel.readString();
            } catch (Throwable unused) {
            }
        }
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // chat.ola.vn.mediastore.GalleryEntity, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        if (parcel != null) {
            parcel.writeString(this.a);
            parcel.writeString(this.b);
            parcel.writeString(this.c);
            parcel.writeString(this.d);
        }
    }
}
