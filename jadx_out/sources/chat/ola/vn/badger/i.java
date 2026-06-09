package chat.ola.vn.badger;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;

/* JADX INFO: loaded from: classes.dex */
public class i extends j {
    public i(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.badger.j
    protected void a(int i) {
        try {
            Uri uri = Uri.parse("content://com.sec.badge/apps?notify=true");
            ContentResolver contentResolver = this.a.getContentResolver();
            Cursor cursorQuery = contentResolver.query(uri, new String[]{"_id"}, "package=?", new String[]{b()}, null);
            if (cursorQuery.moveToNext()) {
                int i2 = cursorQuery.getInt(0);
                ContentValues contentValues = new ContentValues();
                contentValues.put("badgecount", Integer.valueOf(i));
                contentResolver.update(uri, contentValues, "_id=?", new String[]{String.valueOf(i2)});
                return;
            }
            ContentValues contentValues2 = new ContentValues();
            contentValues2.put("package", b());
            contentValues2.put("class", a());
            contentValues2.put("badgecount", Integer.valueOf(i));
            contentResolver.insert(uri, contentValues2);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
