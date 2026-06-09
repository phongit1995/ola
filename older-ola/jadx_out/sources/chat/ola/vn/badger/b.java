package chat.ola.vn.badger;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;
import com.facebook.internal.NativeProtocol;

/* JADX INFO: loaded from: classes.dex */
public class b extends j {
    public b(Context context) {
        super(context);
    }

    @Override // chat.ola.vn.badger.j
    protected void a(int i) {
        try {
            byte[] bArrA = e.a(this.a, i);
            String string = this.a.getResources().getText(this.a.getResources().getIdentifier(NativeProtocol.BRIDGE_ARG_APP_NAME_STRING, "string", b())).toString();
            Uri uri = Uri.parse("content://com.android.launcher2.settings/favorites?notify=true");
            ContentResolver contentResolver = this.a.getContentResolver();
            ContentValues contentValues = new ContentValues();
            contentValues.put("iconType", (Integer) 1);
            contentValues.put("itemType", (Integer) 1);
            contentValues.put("icon", bArrA);
            contentResolver.update(uri, contentValues, "title=?", new String[]{string});
        } catch (Throwable unused) {
        }
    }
}
