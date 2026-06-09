package chat.ola.vn.entry;

import android.database.Cursor;
import android.os.Parcel;
import android.os.Parcelable;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class VideoEntry implements Parcelable {
    public long b;
    public String c;
    public long d;
    public String e;
    public long f;
    public long g;
    public long h;
    public String i;
    private ArrayList<VideoEntry> j;
    public static final String[] a = {"_id", "_data", "_size", "title", "date_modified", "duration", "bucket_id", "bucket_display_name"};
    public static final Parcelable.Creator<VideoEntry> CREATOR = new Parcelable.Creator<VideoEntry>() { // from class: chat.ola.vn.entry.VideoEntry.1
        @Override // android.os.Parcelable.Creator
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public VideoEntry createFromParcel(Parcel parcel) {
            return new VideoEntry(parcel);
        }

        @Override // android.os.Parcelable.Creator
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public VideoEntry[] newArray(int i) {
            return new VideoEntry[i];
        }
    };

    private VideoEntry() {
    }

    public VideoEntry(Parcel parcel) {
        if (parcel != null) {
            try {
                this.b = parcel.readLong();
                this.c = parcel.readString();
                this.d = parcel.readLong();
                this.e = parcel.readString();
                this.f = parcel.readLong();
                this.g = parcel.readLong();
                this.h = parcel.readLong();
                this.i = parcel.readString();
                this.j = parcel.readArrayList(getClass().getClassLoader());
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    public static VideoEntry a(Cursor cursor) {
        VideoEntry videoEntry = new VideoEntry();
        if (cursor == null || cursor.getColumnCount() != a.length) {
            return null;
        }
        videoEntry.b = cursor.getInt(0);
        videoEntry.c = cursor.getString(1);
        videoEntry.d = cursor.getLong(2);
        videoEntry.e = cursor.getString(3);
        videoEntry.f = cursor.getLong(4);
        videoEntry.g = cursor.getLong(5);
        videoEntry.h = cursor.getLong(6);
        videoEntry.i = cursor.getString(7);
        return videoEntry;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        if (parcel != null) {
            parcel.writeLong(this.b);
            parcel.writeString(this.c);
            parcel.writeLong(this.d);
            parcel.writeString(this.e);
            parcel.writeLong(this.f);
            parcel.writeLong(this.g);
            parcel.writeLong(this.h);
            parcel.writeString(this.i);
            parcel.writeList(this.j);
        }
    }
}
