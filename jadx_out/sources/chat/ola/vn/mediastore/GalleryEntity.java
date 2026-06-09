package chat.ola.vn.mediastore;

import android.os.Parcel;
import android.os.Parcelable;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class GalleryEntity implements Parcelable {
    protected String e;
    protected String f;
    protected GalleryEntity g;
    protected List<GalleryEntity> h;

    public GalleryEntity() {
    }

    public GalleryEntity(Parcel parcel) {
        if (parcel != null) {
            try {
                this.e = parcel.readString();
                this.f = parcel.readString();
                this.g = (GalleryEntity) parcel.readParcelable(getClass().getClassLoader());
                this.h = parcel.readArrayList(getClass().getClassLoader());
            } catch (Throwable unused) {
            }
        }
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        if (parcel != null) {
            parcel.writeString(this.e);
            parcel.writeString(this.f);
            parcel.writeParcelable(this.g, 0);
            parcel.writeList(this.h);
        }
    }
}
