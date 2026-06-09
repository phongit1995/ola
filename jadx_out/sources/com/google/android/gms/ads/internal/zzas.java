package com.google.android.gms.ads.internal;

import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import android.util.Base64;
import android.view.View;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.applinks.AppLinkData;
import com.facebook.share.internal.MessengerShareContentUtility;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzajh;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzaqw;
import com.google.android.gms.internal.ads.zzoo;
import com.google.android.gms.internal.ads.zzoq;
import com.google.android.gms.internal.ads.zzpw;
import com.google.android.gms.internal.ads.zzpx;
import com.google.android.gms.internal.ads.zzxz;
import com.google.android.gms.internal.ads.zzyc;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.ByteArrayOutputStream;
import java.util.Iterator;
import java.util.List;
import javax.annotation.ParametersAreNonnullByDefault;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public final class zzas {
    @VisibleForTesting
    static com.google.android.gms.ads.internal.gmsg.zzv<zzaqw> zza(@Nullable zzxz zzxzVar, @Nullable zzyc zzycVar, zzac zzacVar) {
        return new zzax(zzxzVar, zzacVar, zzycVar);
    }

    private static String zza(@Nullable Bitmap bitmap) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        if (bitmap == null) {
            zzakb.zzdk("Bitmap is null. Returning empty string");
            return "";
        }
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
        String strEncodeToString = Base64.encodeToString(byteArrayOutputStream.toByteArray(), 0);
        String strValueOf = String.valueOf("data:image/png;base64,");
        String strValueOf2 = String.valueOf(strEncodeToString);
        return strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf);
    }

    @VisibleForTesting
    private static String zza(@Nullable zzpw zzpwVar) {
        if (zzpwVar == null) {
            zzakb.zzdk("Image is null. Returning empty string");
            return "";
        }
        try {
            Uri uri = zzpwVar.getUri();
            if (uri != null) {
                return uri.toString();
            }
        } catch (RemoteException unused) {
            zzakb.zzdk("Unable to get image uri. Trying data uri next");
        }
        return zzb(zzpwVar);
    }

    private static JSONObject zza(@Nullable Bundle bundle, String str) throws JSONException {
        String strValueOf;
        String str2;
        JSONObject jSONObject = new JSONObject();
        if (bundle == null || TextUtils.isEmpty(str)) {
            return jSONObject;
        }
        JSONObject jSONObject2 = new JSONObject(str);
        Iterator<String> itKeys = jSONObject2.keys();
        while (itKeys.hasNext()) {
            String next = itKeys.next();
            if (bundle.containsKey(next)) {
                if (MessengerShareContentUtility.MEDIA_IMAGE.equals(jSONObject2.getString(next))) {
                    Object obj = bundle.get(next);
                    if (obj instanceof Bitmap) {
                        strValueOf = zza((Bitmap) obj);
                        jSONObject.put(next, strValueOf);
                    } else {
                        str2 = "Invalid type. An image type extra should return a bitmap";
                        zzakb.zzdk(str2);
                    }
                } else if (bundle.get(next) instanceof Bitmap) {
                    str2 = "Invalid asset type. Bitmap should be returned only for image type";
                    zzakb.zzdk(str2);
                } else {
                    strValueOf = String.valueOf(bundle.get(next));
                    jSONObject.put(next, strValueOf);
                }
            }
        }
        return jSONObject;
    }

    static final /* synthetic */ void zza(zzoo zzooVar, String str, zzaqw zzaqwVar, boolean z) {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("headline", zzooVar.getHeadline());
            jSONObject.put(AccountKitGraphConstants.BODY_KEY, zzooVar.getBody());
            jSONObject.put("call_to_action", zzooVar.getCallToAction());
            jSONObject.put(FirebaseAnalytics.Param.PRICE, zzooVar.getPrice());
            jSONObject.put("star_rating", String.valueOf(zzooVar.getStarRating()));
            jSONObject.put("store", zzooVar.getStore());
            jSONObject.put("icon", zza(zzooVar.zzjz()));
            JSONArray jSONArray = new JSONArray();
            List images = zzooVar.getImages();
            if (images != null) {
                Iterator it2 = images.iterator();
                while (it2.hasNext()) {
                    jSONArray.put(zza(zzd(it2.next())));
                }
            }
            jSONObject.put("images", jSONArray);
            jSONObject.put(AppLinkData.ARGUMENTS_EXTRAS_KEY, zza(zzooVar.getExtras(), str));
            JSONObject jSONObject2 = new JSONObject();
            jSONObject2.put("assets", jSONObject);
            jSONObject2.put("template_id", "2");
            zzaqwVar.zzb("google.afma.nativeExpressAds.loadAssets", jSONObject2);
        } catch (JSONException e) {
            zzakb.zzc("Exception occurred when loading assets", e);
        }
    }

    static final /* synthetic */ void zza(zzoq zzoqVar, String str, zzaqw zzaqwVar, boolean z) {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("headline", zzoqVar.getHeadline());
            jSONObject.put(AccountKitGraphConstants.BODY_KEY, zzoqVar.getBody());
            jSONObject.put("call_to_action", zzoqVar.getCallToAction());
            jSONObject.put("advertiser", zzoqVar.getAdvertiser());
            jSONObject.put("logo", zza(zzoqVar.zzkg()));
            JSONArray jSONArray = new JSONArray();
            List images = zzoqVar.getImages();
            if (images != null) {
                Iterator it2 = images.iterator();
                while (it2.hasNext()) {
                    jSONArray.put(zza(zzd(it2.next())));
                }
            }
            jSONObject.put("images", jSONArray);
            jSONObject.put(AppLinkData.ARGUMENTS_EXTRAS_KEY, zza(zzoqVar.getExtras(), str));
            JSONObject jSONObject2 = new JSONObject();
            jSONObject2.put("assets", jSONObject);
            jSONObject2.put("template_id", "1");
            zzaqwVar.zzb("google.afma.nativeExpressAds.loadAssets", jSONObject2);
        } catch (JSONException e) {
            zzakb.zzc("Exception occurred when loading assets", e);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:41:0x0134  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static boolean zza(final com.google.android.gms.internal.ads.zzaqw r26, com.google.android.gms.internal.ads.zzxe r27, java.util.concurrent.CountDownLatch r28) {
        /*
            Method dump skipped, instruction units count: 312
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.ads.internal.zzas.zza(com.google.android.gms.internal.ads.zzaqw, com.google.android.gms.internal.ads.zzxe, java.util.concurrent.CountDownLatch):boolean");
    }

    private static String zzb(zzpw zzpwVar) {
        try {
            IObjectWrapper iObjectWrapperZzjy = zzpwVar.zzjy();
            if (iObjectWrapperZzjy == null) {
                zzakb.zzdk("Drawable is null. Returning empty string");
                return "";
            }
            Drawable drawable = (Drawable) ObjectWrapper.unwrap(iObjectWrapperZzjy);
            if (drawable instanceof BitmapDrawable) {
                return zza(((BitmapDrawable) drawable).getBitmap());
            }
            zzakb.zzdk("Drawable is not an instance of BitmapDrawable. Returning empty string");
            return "";
        } catch (RemoteException unused) {
            zzakb.zzdk("Unable to get drawable. Returning empty string");
            return "";
        }
    }

    @Nullable
    private static zzpw zzd(Object obj) {
        if (obj instanceof IBinder) {
            return zzpx.zzh((IBinder) obj);
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zzd(zzaqw zzaqwVar) {
        View.OnClickListener onClickListener = zzaqwVar.getOnClickListener();
        if (onClickListener != null) {
            onClickListener.onClick(zzaqwVar.getView());
        }
    }

    @Nullable
    public static View zze(@Nullable zzajh zzajhVar) {
        if (zzajhVar == null) {
            zzakb.e("AdState is null");
            return null;
        }
        if (zzf(zzajhVar) && zzajhVar.zzbyo != null) {
            return zzajhVar.zzbyo.getView();
        }
        try {
            IObjectWrapper view = zzajhVar.zzbtx != null ? zzajhVar.zzbtx.getView() : null;
            if (view != null) {
                return (View) ObjectWrapper.unwrap(view);
            }
            zzakb.zzdk("View in mediation adapter is null.");
            return null;
        } catch (RemoteException e) {
            zzakb.zzc("Could not get View from mediation adapter.", e);
            return null;
        }
    }

    public static boolean zzf(@Nullable zzajh zzajhVar) {
        return (zzajhVar == null || !zzajhVar.zzceq || zzajhVar.zzbtw == null || zzajhVar.zzbtw.zzbsf == null) ? false : true;
    }
}
