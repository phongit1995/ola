package chat.ola.vn.pickercontacts;

import android.content.ContentUris;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.provider.ContactsContract;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.c.t;
import chat.ola.vn.view.OlaCachedImageView;
import com.facebook.internal.AnalyticsEvents;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class b extends AsyncTask<f, Void, Bitmap> {
    private f a;

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public Bitmap doInBackground(f... fVarArr) {
        try {
            this.a = fVarArr[0];
            if (this.a != null) {
                return BitmapFactory.decodeStream(OlaApplication.a().getContentResolver().openAssetFileDescriptor(Uri.withAppendedPath(ContentUris.withAppendedId(ContactsContract.Contacts.CONTENT_URI, Long.parseLong(this.a.b())), AnalyticsEvents.PARAMETER_SHARE_DIALOG_CONTENT_PHOTO), "r").createInputStream());
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(Bitmap bitmap) {
        OlaCachedImageView olaCachedImageView;
        try {
            WeakReference<OlaCachedImageView> weakReferenceA = this.a.a();
            if (weakReferenceA == null || (olaCachedImageView = weakReferenceA.get()) == null || bitmap == null) {
                return;
            }
            String strA = a.a(this.a.b());
            Bitmap bitmapA = chat.ola.vn.c.f.a(bitmap);
            t.a().a(strA, bitmapA);
            olaCachedImageView.a(bitmapA, this.a.b());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
