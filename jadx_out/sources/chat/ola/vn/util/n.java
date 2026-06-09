package chat.ola.vn.util;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WifiManager;
import android.provider.ContactsContract;
import android.provider.Settings;
import android.telephony.TelephonyManager;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class n {
    public static int a(Context context) {
        try {
            int identifier = context.getResources().getIdentifier("status_bar_height", "dimen", AccountKitGraphConstants.SDK_TYPE_ANDROID);
            if (identifier > 0) {
                return context.getResources().getDimensionPixelOffset(identifier);
            }
            return 15;
        } catch (Throwable unused) {
            return 0;
        }
    }

    public static boolean a(Context context, Uri uri) {
        try {
            MediaPlayer mediaPlayer = new MediaPlayer();
            mediaPlayer.setAudioStreamType(5);
            mediaPlayer.setDataSource(context, uri);
            mediaPlayer.setVolume(1.0f, 1.0f);
            mediaPlayer.prepare();
            mediaPlayer.start();
            mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() { // from class: chat.ola.vn.util.n.1
                @Override // android.media.MediaPlayer.OnCompletionListener
                public void onCompletion(MediaPlayer mediaPlayer2) {
                    mediaPlayer2.release();
                }
            });
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    public static boolean b(Context context) {
        try {
            switch (((TelephonyManager) context.getSystemService("phone")).getSimState()) {
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    public static boolean c(Context context) {
        NetworkInfo activeNetworkInfo = ((ConnectivityManager) context.getSystemService("connectivity")).getActiveNetworkInfo();
        return activeNetworkInfo != null && activeNetworkInfo.isConnected() && activeNetworkInfo.isAvailable();
    }

    public static int d(Context context) {
        return ((AudioManager) context.getSystemService("audio")).getStreamVolume(3);
    }

    public static int e(Context context) {
        return ((AudioManager) context.getSystemService("audio")).getStreamMaxVolume(3);
    }

    public static String f(Context context) {
        try {
            String string = Settings.Secure.getString(context.getContentResolver(), "android_id");
            if (!m.b("9774d56d682e549c", string)) {
                return string;
            }
            try {
                String deviceId = ((TelephonyManager) context.getSystemService("phone")).getDeviceId();
                if (!m.a(deviceId)) {
                    return deviceId;
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
            try {
                String macAddress = ((WifiManager) context.getSystemService("wifi")).getConnectionInfo().getMacAddress();
                return !m.a(macAddress) ? macAddress : "9774d56d682e549c";
            } catch (Throwable th2) {
                th2.printStackTrace();
                return "9774d56d682e549c";
            }
        } catch (Throwable th3) {
            th3.printStackTrace();
            return "9774d56d682e549c";
        }
    }

    public static String g(Context context) {
        try {
            Cursor cursorI = i(context);
            String string = "";
            while (cursorI.moveToNext()) {
                string = cursorI.getString(cursorI.getColumnIndex("display_name"));
            }
            return string;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static String h(Context context) {
        Cursor cursorI = i(context);
        String string = null;
        while (cursorI.moveToNext()) {
            string = cursorI.getString(cursorI.getColumnIndex("data1"));
            if (!m.a(string)) {
                break;
            }
        }
        return string;
    }

    static Cursor i(Context context) {
        Account[] accountsByType = AccountManager.get(context).getAccountsByType("com.google");
        if (accountsByType[0].name == null) {
            return null;
        }
        String str = accountsByType[0].name;
        ArrayList arrayList = new ArrayList();
        arrayList.add(str);
        String str2 = "data1 = ?";
        for (int i = 1; i < accountsByType.length; i++) {
            str2 = str2 + " or data1 = ?";
            arrayList.add(accountsByType[i].name);
        }
        return context.getContentResolver().query(ContactsContract.CommonDataKinds.Email.CONTENT_URI, null, str2, (String[]) arrayList.toArray(new String[arrayList.size()]), null);
    }

    public static String j(Context context) {
        String str = null;
        try {
            Account[] accountsByType = AccountManager.get(context).getAccountsByType("com.google");
            if (accountsByType[0].name != null) {
                String str2 = accountsByType[0].name;
                ArrayList arrayList = new ArrayList();
                arrayList.add(str2);
                String str3 = "data1 = ?";
                for (int i = 1; i < accountsByType.length; i++) {
                    str3 = str3 + " or data1 = ?";
                    arrayList.add(accountsByType[i].name);
                }
                String[] strArr = (String[]) arrayList.toArray(new String[arrayList.size()]);
                ContentResolver contentResolver = context.getContentResolver();
                Cursor cursorQuery = contentResolver.query(ContactsContract.CommonDataKinds.Email.CONTENT_URI, null, str3, strArr, null);
                while (cursorQuery.moveToNext()) {
                    try {
                        String string = cursorQuery.getString(cursorQuery.getColumnIndex("contact_id"));
                        if (string != null) {
                            Cursor cursorQuery2 = contentResolver.query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI, null, "contact_id = ?", new String[]{string}, null);
                            while (cursorQuery2.moveToNext()) {
                                String string2 = cursorQuery2.getString(cursorQuery2.getColumnIndex("data1"));
                                try {
                                    if (!m.a(string2) && (!chat.ola.vn.c.x() || string2.length() >= 10)) {
                                        str = string2;
                                        break;
                                    }
                                    str = string2;
                                } catch (Throwable unused) {
                                    str = string2;
                                }
                            }
                            cursorQuery2.close();
                        }
                    } catch (Throwable unused2) {
                    }
                }
            }
        } catch (Throwable unused3) {
        }
        return str;
    }
}
