package bolts;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import com.facebook.applinks.AppLinkData;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class c {
    public static Uri a(Context context, Intent intent) {
        String string;
        Bundle bundleA = a(intent);
        if (bundleA == null || (string = bundleA.getString("target_url")) == null) {
            return null;
        }
        i.a(context, "al_nav_in", intent, (Map<String, String>) null);
        return Uri.parse(string);
    }

    public static Bundle a(Intent intent) {
        return intent.getBundleExtra("al_applink_data");
    }

    public static Bundle b(Intent intent) {
        Bundle bundleA = a(intent);
        if (bundleA == null) {
            return null;
        }
        return bundleA.getBundle(AppLinkData.ARGUMENTS_EXTRAS_KEY);
    }
}
