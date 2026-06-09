package chat.ola.vn.entry;

import android.database.Cursor;
import android.os.Parcel;
import android.os.Parcelable;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ImageEntry implements Parcelable {
    public long c;
    public String d;
    public long e;
    public String f;
    public long g;
    public int h;
    public long i;
    public String j;
    private ArrayList<ImageEntry> k;
    public static final String[] a = {"_id", "_data", "bucket_id", "date_modified", "bucket_display_name"};
    public static final String[] b = {"_id", "_data", "_size", "title", "date_modified", "orientation", "bucket_id", "bucket_display_name"};
    public static final Parcelable.Creator<ImageEntry> CREATOR = new Parcelable.Creator<ImageEntry>() { // from class: chat.ola.vn.entry.ImageEntry.1
        @Override // android.os.Parcelable.Creator
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public ImageEntry createFromParcel(Parcel parcel) {
            return new ImageEntry(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public ImageEntry[] newArray(int i) {
            return new ImageEntry[i];
        }
    };

    private ImageEntry() {
    }

    public ImageEntry(Parcel parcel) {
        if (parcel != null) {
            try {
                this.c = parcel.readLong();
                this.d = parcel.readString();
                this.e = parcel.readLong();
                this.f = parcel.readString();
                this.g = parcel.readLong();
                this.h = parcel.readInt();
                this.i = parcel.readLong();
                this.j = parcel.readString();
                this.k = parcel.readArrayList(getClass().getClassLoader());
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    public static ImageEntry a(Cursor cursor) {
        ImageEntry imageEntry = new ImageEntry();
        if (cursor == null || cursor.getColumnCount() != b.length) {
            return null;
        }
        imageEntry.c = cursor.getInt(0);
        imageEntry.d = cursor.getString(1);
        imageEntry.e = cursor.getLong(2);
        imageEntry.f = cursor.getString(3);
        imageEntry.g = cursor.getLong(4);
        imageEntry.h = cursor.getInt(5);
        imageEntry.i = cursor.getLong(6);
        imageEntry.j = cursor.getString(7);
        return imageEntry;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        if (parcel != null) {
            parcel.writeLong(this.c);
            parcel.writeString(this.d);
            parcel.writeLong(this.e);
            parcel.writeString(this.f);
            parcel.writeLong(this.g);
            parcel.writeInt(this.h);
            parcel.writeLong(this.i);
            parcel.writeString(this.j);
            parcel.writeList(this.k);
        }
    }
}
