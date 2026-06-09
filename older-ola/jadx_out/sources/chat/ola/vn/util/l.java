package chat.ola.vn.util;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.provider.MediaStore;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public class l {
    public static void a(Context context, String str, String str2, String str3) {
        Cursor cursorQuery = context.getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, new String[]{"_data"}, "_data=?", new String[]{str2}, null);
        if (cursorQuery == null || cursorQuery.getCount() == 0) {
            ContentValues contentValues = new ContentValues();
            contentValues.put("title", str);
            contentValues.put("_display_name", str);
            contentValues.put("datetaken", Long.valueOf(System.currentTimeMillis()));
            contentValues.put("mime_type", "image/" + str3);
            contentValues.put("orientation", (Integer) 0);
            contentValues.put("_data", str2);
            contentValues.put("_size", Long.valueOf(com.mg.ola.common.d.c.h(new File(str2))));
            context.getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, contentValues);
        }
    }

    public static void a(Context context, String str, String str2, String str3, String str4) {
        Cursor cursorQuery = context.getContentResolver().query(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, new String[]{"_data"}, "_data=?", new String[]{str2}, null);
        if (cursorQuery == null || cursorQuery.getCount() == 0) {
            ContentValues contentValues = new ContentValues();
            contentValues.put("title", str);
            contentValues.put("_display_name", str);
            contentValues.put("date_added", Long.valueOf(System.currentTimeMillis()));
            contentValues.put("mime_type", "audio/" + str3);
            contentValues.put("_data", str2);
            contentValues.put("_size", Long.valueOf(com.mg.ola.common.d.c.h(new File(str2))));
            contentValues.put("is_music", (Boolean) true);
            contentValues.put("album", chat.ola.vn.d.e);
            if (!m.a(str4)) {
                contentValues.put("artist", str4);
            }
            context.getContentResolver().insert(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, contentValues);
        }
    }

    public static void b(Context context, String str, String str2, String str3) {
        Cursor cursorQuery = context.getContentResolver().query(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, new String[]{"_data"}, "_data=?", new String[]{str2}, null);
        if (cursorQuery == null || cursorQuery.getCount() == 0) {
            ContentValues contentValues = new ContentValues(9);
            contentValues.put("title", str);
            contentValues.put("_display_name", str);
            contentValues.put("date_added", Long.valueOf(System.currentTimeMillis()));
            contentValues.put("mime_type", "video/" + str3);
            contentValues.put("_data", str2);
            contentValues.put("_size", Long.valueOf(com.mg.ola.common.d.c.h(new File(str2))));
            context.getContentResolver().insert(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, contentValues);
        }
    }
}
