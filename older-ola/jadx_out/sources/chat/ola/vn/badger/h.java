package chat.ola.vn.badger;

import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;

/* JADX INFO: loaded from: classes.dex */
public class h extends j {
    public h(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.badger.j
    protected void a(int i) throws ShortcutBadgeException {
        try {
            ContentValues contentValues = new ContentValues();
            contentValues.put("tag", b() + "/" + a());
            contentValues.put("count", Integer.valueOf(i));
            this.a.getContentResolver().insert(Uri.parse("content://com.teslacoilsw.notifier/unread_count"), contentValues);
        } catch (IllegalArgumentException unused) {
        } catch (Exception e) {
            throw new ShortcutBadgeException(e.getMessage());
        }
    }
}
