package chat.ola.vn.n;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationManager;
import android.os.AsyncTask;
import android.os.Build;
import android.support.v4.app.Fragment;
import chat.ola.vn.R;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class b {

    public interface a {
        void a();

        void a(List<Address> list);
    }

    /* JADX INFO: renamed from: chat.ola.vn.n.b$b, reason: collision with other inner class name */
    public interface InterfaceC0042b {
        void a(double d, double d2, float f);

        void j_();

        void k_();

        void l_();
    }

    public static Bitmap a(Context context, Bitmap bitmap) {
        Drawable drawable = context.getResources().getDrawable(R.drawable.border_location_marker);
        Bitmap bitmapDecodeResource = BitmapFactory.decodeResource(context.getResources(), R.drawable.border_location_marker);
        Rect rect = new Rect();
        drawable.getPadding(rect);
        rect.right = bitmapDecodeResource.getWidth() - rect.right;
        rect.bottom = bitmapDecodeResource.getHeight() - rect.bottom;
        Bitmap bitmapCreateBitmap = Bitmap.createBitmap(bitmapDecodeResource.getWidth(), bitmapDecodeResource.getHeight(), bitmapDecodeResource.getConfig());
        Canvas canvas = new Canvas(bitmapCreateBitmap);
        canvas.drawBitmap(bitmapDecodeResource, 0.0f, 0.0f, (Paint) null);
        if (bitmap != null) {
            canvas.drawBitmap(bitmap, (Rect) null, rect, (Paint) null);
        }
        return bitmapCreateBitmap;
    }

    public static String a(int i, int i2, String str, String str2, int i3) {
        return "http://maps.googleapis.com/maps/api/staticmap?size=" + i + "x" + i2 + "&markers=" + str2 + "," + str + "&zoom=" + i3 + "&sensor=true";
    }

    /* JADX WARN: Code restructure failed: missing block: B:9:0x0017, code lost:
    
        r0 = r4.getAddressLine(r1);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static java.lang.String a(android.location.Address r4) {
        /*
            java.lang.String r0 = ""
            r1 = 0
            int r2 = r4.getMaxAddressLineIndex()     // Catch: java.lang.Throwable -> L1c
        L7:
            if (r1 >= r2) goto L1c
            java.lang.String r3 = r4.getAddressLine(r1)     // Catch: java.lang.Throwable -> L1c
            boolean r3 = chat.ola.vn.util.m.a(r3)     // Catch: java.lang.Throwable -> L1c
            if (r3 != 0) goto L19
            java.lang.String r1 = r4.getAddressLine(r1)     // Catch: java.lang.Throwable -> L1c
            r0 = r1
            goto L1c
        L19:
            int r1 = r1 + 1
            goto L7
        L1c:
            java.lang.String r1 = r4.getSubAdminArea()     // Catch: java.lang.Throwable -> La4
            boolean r1 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> La4
            if (r1 != 0) goto L49
            boolean r1 = chat.ola.vn.util.m.a(r0)     // Catch: java.lang.Throwable -> La4
            if (r1 == 0) goto L31
            java.lang.String r0 = r4.getSubAdminArea()     // Catch: java.lang.Throwable -> La4
            goto L49
        L31:
            java.lang.StringBuilder r1 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> La4
            r1.<init>()     // Catch: java.lang.Throwable -> La4
            r1.append(r0)     // Catch: java.lang.Throwable -> La4
            java.lang.String r0 = ", "
            r1.append(r0)     // Catch: java.lang.Throwable -> La4
            java.lang.String r0 = r4.getSubAdminArea()     // Catch: java.lang.Throwable -> La4
            r1.append(r0)     // Catch: java.lang.Throwable -> La4
            java.lang.String r0 = r1.toString()     // Catch: java.lang.Throwable -> La4
        L49:
            java.lang.String r1 = r4.getAdminArea()     // Catch: java.lang.Throwable -> La4
            boolean r1 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> La4
            if (r1 != 0) goto L76
            boolean r1 = chat.ola.vn.util.m.a(r0)     // Catch: java.lang.Throwable -> La4
            if (r1 == 0) goto L5e
            java.lang.String r0 = r4.getAdminArea()     // Catch: java.lang.Throwable -> La4
            goto L76
        L5e:
            java.lang.StringBuilder r1 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> La4
            r1.<init>()     // Catch: java.lang.Throwable -> La4
            r1.append(r0)     // Catch: java.lang.Throwable -> La4
            java.lang.String r0 = ", "
            r1.append(r0)     // Catch: java.lang.Throwable -> La4
            java.lang.String r0 = r4.getAdminArea()     // Catch: java.lang.Throwable -> La4
            r1.append(r0)     // Catch: java.lang.Throwable -> La4
            java.lang.String r0 = r1.toString()     // Catch: java.lang.Throwable -> La4
        L76:
            java.lang.String r1 = r4.getCountryName()     // Catch: java.lang.Throwable -> La4
            boolean r1 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> La4
            if (r1 != 0) goto La3
            boolean r1 = chat.ola.vn.util.m.a(r0)     // Catch: java.lang.Throwable -> La4
            if (r1 == 0) goto L8b
            java.lang.String r0 = r4.getCountryName()     // Catch: java.lang.Throwable -> La4
            return r0
        L8b:
            java.lang.StringBuilder r1 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> La4
            r1.<init>()     // Catch: java.lang.Throwable -> La4
            r1.append(r0)     // Catch: java.lang.Throwable -> La4
            java.lang.String r0 = ", "
            r1.append(r0)     // Catch: java.lang.Throwable -> La4
            java.lang.String r4 = r4.getCountryName()     // Catch: java.lang.Throwable -> La4
            r1.append(r4)     // Catch: java.lang.Throwable -> La4
            java.lang.String r0 = r1.toString()     // Catch: java.lang.Throwable -> La4
        La3:
            return r0
        La4:
            r4 = 0
            return r4
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.n.b.a(android.location.Address):java.lang.String");
    }

    @SuppressLint({"NewApi"})
    public static void a(Activity activity, int i) {
        activity.requestPermissions(new String[]{"android.permission.ACCESS_FINE_LOCATION", "android.permission.ACCESS_COARSE_LOCATION"}, i);
    }

    public static void a(Context context) {
        a(context, 0L, false, (InterfaceC0042b) null);
    }

    public static void a(Context context, final double d, final double d2, final int i, final a aVar) {
        try {
            try {
                new AsyncTask<Context, Void, List<Address>>() { // from class: chat.ola.vn.n.b.1
                    /* JADX INFO: Access modifiers changed from: protected */
                    @Override // android.os.AsyncTask
                    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                    public List<Address> doInBackground(Context... contextArr) {
                        try {
                            return new Geocoder(contextArr[0], Locale.getDefault()).getFromLocation(d2, d, i);
                        } catch (Throwable unused) {
                            return null;
                        }
                    }

                    /* JADX INFO: Access modifiers changed from: protected */
                    @Override // android.os.AsyncTask
                    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                    public void onPostExecute(List<Address> list) {
                        try {
                            if (list == null) {
                                aVar.a();
                            } else {
                                aVar.a(list);
                            }
                        } catch (Throwable unused) {
                        }
                    }
                }.execute(context);
            } catch (Throwable unused) {
                aVar.a();
            }
        } catch (Throwable unused2) {
        }
    }

    public static void a(Context context, double d, double d2, a aVar) {
        a(context, d, d2, 10, aVar);
    }

    public static void a(Context context, long j, InterfaceC0042b interfaceC0042b) {
        a(context, j, false, interfaceC0042b);
    }

    private static void a(Context context, long j, boolean z, InterfaceC0042b interfaceC0042b) {
        chat.ola.vn.n.a aVar = new chat.ola.vn.n.a(context);
        aVar.a(interfaceC0042b);
        aVar.a(j, z);
    }

    @SuppressLint({"NewApi"})
    public static void a(Fragment fragment, int i) {
        fragment.requestPermissions(new String[]{"android.permission.ACCESS_FINE_LOCATION", "android.permission.ACCESS_COARSE_LOCATION"}, i);
    }

    public static boolean a(Location location, Location location2) {
        if (location2 == null) {
            return true;
        }
        try {
            long time = location.getTime() - location2.getTime();
            boolean z = time > 120000;
            boolean z2 = time < -120000;
            boolean z3 = time > 0;
            if (z) {
                return true;
            }
            if (z2) {
                return false;
            }
            int accuracy = (int) (location.getAccuracy() - location2.getAccuracy());
            boolean z4 = accuracy > 0;
            boolean z5 = accuracy < 0;
            boolean z6 = accuracy > 200;
            boolean zA = a(location.getProvider(), location2.getProvider());
            if (z5) {
                return true;
            }
            if (z3 && !z4) {
                return true;
            }
            if (z3 && !z6 && zA) {
                return true;
            }
        } catch (Throwable unused) {
        }
        return false;
    }

    public static boolean a(String str, String str2) {
        return str == null ? str2 == null : str.equals(str2);
    }

    public static void b(Context context, long j, InterfaceC0042b interfaceC0042b) {
        a(context, j, true, interfaceC0042b);
    }

    public static boolean b(Context context) {
        return Build.VERSION.SDK_INT < 23 || context.checkSelfPermission("android.permission.ACCESS_FINE_LOCATION") == 0 || context.checkSelfPermission("android.permission.ACCESS_COARSE_LOCATION") == 0;
    }

    public static boolean c(Context context) {
        try {
            LocationManager locationManager = (LocationManager) context.getSystemService("location");
            return locationManager.isProviderEnabled("gps") || locationManager.isProviderEnabled("network");
        } catch (Throwable th) {
            th.printStackTrace();
            return false;
        }
    }
}
