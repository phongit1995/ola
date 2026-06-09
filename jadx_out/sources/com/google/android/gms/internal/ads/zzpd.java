package com.google.android.gms.internal.ads;

import android.content.Context;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.facebook.share.internal.MessengerShareContentUtility;
import com.google.android.gms.ads.formats.NativeAppInstallAd;
import com.google.android.gms.ads.formats.NativeContentAd;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.measurement.AppMeasurement;
import java.lang.ref.WeakReference;
import java.util.Iterator;
import java.util.Map;
import javax.annotation.ParametersAreNonnullByDefault;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public class zzpd implements zzoz {
    private final Context mContext;

    @Nullable
    private final zzacm zzaad;

    @Nullable
    private String zzaae;
    private final zzpa zzbiw;
    private final zzok zzbiz;

    @Nullable
    private final JSONObject zzbja;

    @Nullable
    private final zzpb zzbjb;
    private final zzci zzbjc;

    @VisibleForTesting
    boolean zzbjd;

    @VisibleForTesting
    boolean zzbje;

    @Nullable
    private final zzang zzyf;

    @Nullable
    private zzaix zzyv;
    private final Object mLock = new Object();
    private WeakReference<View> zzbjf = null;

    public zzpd(Context context, zzpa zzpaVar, @Nullable zzacm zzacmVar, zzci zzciVar, @Nullable JSONObject jSONObject, @Nullable zzpb zzpbVar, @Nullable zzang zzangVar, @Nullable String str) {
        this.mContext = context;
        this.zzbiw = zzpaVar;
        this.zzaad = zzacmVar;
        this.zzbjc = zzciVar;
        this.zzbja = jSONObject;
        this.zzbjb = zzpbVar;
        this.zzyf = zzangVar;
        this.zzaae = str;
        this.zzbiz = new zzok(this.zzaad);
    }

    private final JSONObject zza(Map<String, WeakReference<View>> map, View view) {
        JSONObject jSONObjectZzb;
        JSONObject jSONObject = new JSONObject();
        if (map == null || view == null) {
            return jSONObject;
        }
        int[] iArrZzn = zzn(view);
        synchronized (map) {
            for (Map.Entry<String, WeakReference<View>> entry : map.entrySet()) {
                View view2 = entry.getValue().get();
                if (view2 != null) {
                    int[] iArrZzn2 = zzn(view2);
                    JSONObject jSONObject2 = new JSONObject();
                    JSONObject jSONObject3 = new JSONObject();
                    try {
                        jSONObject3.put("width", zzv(view2.getMeasuredWidth()));
                        jSONObject3.put("height", zzv(view2.getMeasuredHeight()));
                        jSONObject3.put("x", zzv(iArrZzn2[0] - iArrZzn[0]));
                        jSONObject3.put("y", zzv(iArrZzn2[1] - iArrZzn[1]));
                        jSONObject3.put("relative_to", "ad_view");
                        jSONObject2.put("frame", jSONObject3);
                        Rect rect = new Rect();
                        if (view2.getLocalVisibleRect(rect)) {
                            jSONObjectZzb = zzb(rect);
                        } else {
                            JSONObject jSONObject4 = new JSONObject();
                            jSONObject4.put("width", 0);
                            jSONObject4.put("height", 0);
                            jSONObject4.put("x", zzv(iArrZzn2[0] - iArrZzn[0]));
                            jSONObject4.put("y", zzv(iArrZzn2[1] - iArrZzn[1]));
                            jSONObject4.put("relative_to", "ad_view");
                            jSONObjectZzb = jSONObject4;
                        }
                        jSONObject2.put("visible_bounds", jSONObjectZzb);
                        if (view2 instanceof TextView) {
                            TextView textView = (TextView) view2;
                            jSONObject2.put("text_color", textView.getCurrentTextColor());
                            jSONObject2.put("font_size", textView.getTextSize());
                            jSONObject2.put("text", textView.getText());
                        }
                        jSONObject.put(entry.getKey(), jSONObject2);
                    } catch (JSONException unused) {
                        zzakb.zzdk("Unable to get asset views information");
                    }
                }
            }
        }
        return jSONObject;
    }

    private final void zza(View view, JSONObject jSONObject, JSONObject jSONObject2, JSONObject jSONObject3, JSONObject jSONObject4, String str, JSONObject jSONObject5, JSONObject jSONObject6) {
        Preconditions.checkMainThread("Invalid call from a non-UI thread.");
        try {
            JSONObject jSONObject7 = new JSONObject();
            jSONObject7.put("ad", this.zzbja);
            if (jSONObject2 != null) {
                jSONObject7.put("asset_view_signal", jSONObject2);
            }
            if (jSONObject != null) {
                jSONObject7.put("ad_view_signal", jSONObject);
            }
            if (jSONObject5 != null) {
                jSONObject7.put("click_signal", jSONObject5);
            }
            if (jSONObject3 != null) {
                jSONObject7.put("scroll_view_signal", jSONObject3);
            }
            if (jSONObject4 != null) {
                jSONObject7.put("lock_screen_signal", jSONObject4);
            }
            JSONObject jSONObject8 = new JSONObject();
            jSONObject8.put("asset_id", str);
            jSONObject8.put(MessengerShareContentUtility.ATTACHMENT_TEMPLATE_TYPE, this.zzbjb.zzkb());
            com.google.android.gms.ads.internal.zzbv.zzem();
            jSONObject8.put("is_privileged_process", zzakq.zzrp());
            boolean z = true;
            if (((Boolean) zzkb.zzik().zzd(zznk.zzbcf)).booleanValue() && this.zzbiz.zzjw() != null && this.zzbja.optBoolean("custom_one_point_five_click_enabled", false)) {
                jSONObject8.put("custom_one_point_five_click_eligible", true);
            }
            jSONObject8.put(AppMeasurement.Param.TIMESTAMP, com.google.android.gms.ads.internal.zzbv.zzer().currentTimeMillis());
            jSONObject8.put("has_custom_click_handler", this.zzbiw.zzr(this.zzbjb.getCustomTemplateId()) != null);
            if (this.zzbiw.zzr(this.zzbjb.getCustomTemplateId()) == null) {
                z = false;
            }
            jSONObject7.put("has_custom_click_handler", z);
            try {
                JSONObject jSONObjectOptJSONObject = this.zzbja.optJSONObject("tracking_urls_and_actions");
                if (jSONObjectOptJSONObject == null) {
                    jSONObjectOptJSONObject = new JSONObject();
                }
                jSONObject8.put("click_signals", this.zzbjc.zzaa().zza(this.mContext, jSONObjectOptJSONObject.optString("click_string"), view));
            } catch (Exception e) {
                zzakb.zzb("Exception obtaining click signals", e);
            }
            jSONObject7.put("click", jSONObject8);
            if (jSONObject6 != null) {
                jSONObject7.put("provided_signals", jSONObject6);
            }
            jSONObject7.put("ads_id", this.zzaae);
            zzanm.zza(this.zzaad.zzi(jSONObject7), "NativeAdEngineImpl.performClick");
        } catch (JSONException e2) {
            zzakb.zzb("Unable to create click JSON.", e2);
        }
    }

    private final boolean zza(JSONObject jSONObject, JSONObject jSONObject2, JSONObject jSONObject3, JSONObject jSONObject4, JSONObject jSONObject5) {
        Preconditions.checkMainThread("Invalid call from a non-UI thread.");
        if (this.zzbjd) {
            return true;
        }
        this.zzbjd = true;
        try {
            JSONObject jSONObject6 = new JSONObject();
            jSONObject6.put("ad", this.zzbja);
            jSONObject6.put("ads_id", this.zzaae);
            if (jSONObject2 != null) {
                jSONObject6.put("asset_view_signal", jSONObject2);
            }
            if (jSONObject != null) {
                jSONObject6.put("ad_view_signal", jSONObject);
            }
            if (jSONObject3 != null) {
                jSONObject6.put("scroll_view_signal", jSONObject3);
            }
            if (jSONObject4 != null) {
                jSONObject6.put("lock_screen_signal", jSONObject4);
            }
            if (jSONObject5 != null) {
                jSONObject6.put("provided_signals", jSONObject5);
            }
            zzanm.zza(this.zzaad.zzj(jSONObject6), "NativeAdEngineImpl.recordImpression");
            this.zzbiw.zza(this);
            this.zzbiw.zzbv();
            zzcr();
            return true;
        } catch (JSONException e) {
            zzakb.zzb("Unable to create impression JSON.", e);
            return false;
        }
    }

    private final boolean zzaq(String str) {
        JSONObject jSONObjectOptJSONObject = this.zzbja == null ? null : this.zzbja.optJSONObject("allow_pub_event_reporting");
        if (jSONObjectOptJSONObject == null) {
            return false;
        }
        return jSONObjectOptJSONObject.optBoolean(str, false);
    }

    private final JSONObject zzb(Rect rect) throws JSONException {
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("width", zzv(rect.right - rect.left));
        jSONObject.put("height", zzv(rect.bottom - rect.top));
        jSONObject.put("x", zzv(rect.left));
        jSONObject.put("y", zzv(rect.top));
        jSONObject.put("relative_to", "self");
        return jSONObject;
    }

    private static boolean zzm(View view) {
        return view.isShown() && view.getGlobalVisibleRect(new Rect(), null);
    }

    @VisibleForTesting
    private static int[] zzn(View view) {
        int[] iArr = new int[2];
        view.getLocationOnScreen(iArr);
        return iArr;
    }

    private final JSONObject zzo(View view) {
        JSONObject jSONObject;
        JSONObject jSONObject2 = new JSONObject();
        if (view == null) {
            return jSONObject2;
        }
        try {
            int[] iArrZzn = zzn(view);
            JSONObject jSONObject3 = new JSONObject();
            jSONObject3.put("width", zzv(view.getMeasuredWidth()));
            jSONObject3.put("height", zzv(view.getMeasuredHeight()));
            jSONObject3.put("x", zzv(iArrZzn[0]));
            jSONObject3.put("y", zzv(iArrZzn[1]));
            jSONObject3.put("relative_to", "window");
            jSONObject2.put("frame", jSONObject3);
            Rect rect = new Rect();
            if (view.getGlobalVisibleRect(rect)) {
                jSONObject = zzb(rect);
            } else {
                jSONObject = new JSONObject();
                jSONObject.put("width", 0);
                jSONObject.put("height", 0);
                jSONObject.put("x", zzv(iArrZzn[0]));
                jSONObject.put("y", zzv(iArrZzn[1]));
                jSONObject.put("relative_to", "window");
            }
            jSONObject2.put("visible_bounds", jSONObject);
            return jSONObject2;
        } catch (Exception unused) {
            zzakb.zzdk("Unable to get native ad view bounding box");
            return jSONObject2;
        }
    }

    private static JSONObject zzp(View view) {
        JSONObject jSONObject = new JSONObject();
        if (view == null) {
            return jSONObject;
        }
        try {
            com.google.android.gms.ads.internal.zzbv.zzek();
            jSONObject.put("contained_in_scroll_view", zzakk.zzx(view) != -1);
        } catch (Exception unused) {
        }
        return jSONObject;
    }

    private final JSONObject zzq(View view) {
        JSONObject jSONObject = new JSONObject();
        if (view == null) {
            return jSONObject;
        }
        try {
            com.google.android.gms.ads.internal.zzbv.zzek();
            jSONObject.put("can_show_on_lock_screen", zzakk.zzw(view));
            com.google.android.gms.ads.internal.zzbv.zzek();
            jSONObject.put("is_keyguard_locked", zzakk.zzau(this.mContext));
            return jSONObject;
        } catch (JSONException unused) {
            zzakb.zzdk("Unable to get lock screen information");
            return jSONObject;
        }
    }

    @VisibleForTesting
    private final int zzv(int i) {
        zzkb.zzif();
        return zzamu.zzb(this.mContext, i);
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void cancelUnconfirmedClick() {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbcf)).booleanValue()) {
            if (this.zzbja.optBoolean("custom_one_point_five_click_enabled", false)) {
                this.zzbiz.cancelUnconfirmedClick();
            } else {
                zzakb.zzdk("Your account need to be whitelisted to use this feature.\nContact your account manager for more information.");
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final Context getContext() {
        return this.mContext;
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final void performClick(Bundle bundle) {
        if (bundle == null) {
            zzakb.zzck("Click data is null. No click is reported.");
        } else if (zzaq("click_reporting")) {
            zza(null, null, null, null, null, bundle.getBundle("click_signal").getString("asset_id"), null, com.google.android.gms.ads.internal.zzbv.zzek().zza(bundle, (JSONObject) null));
        } else {
            zzakb.e("The ad slot cannot handle external click events. You must be whitelisted to be able to report your click events.");
        }
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final boolean recordImpression(Bundle bundle) {
        if (zzaq("impression_reporting")) {
            return zza((JSONObject) null, (JSONObject) null, (JSONObject) null, (JSONObject) null, com.google.android.gms.ads.internal.zzbv.zzek().zza(bundle, (JSONObject) null));
        }
        zzakb.e("The ad slot cannot handle external impression events. You must be whitelisted to whitelisted to be able to report your impression events.");
        return false;
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final void reportTouchEvent(Bundle bundle) {
        if (bundle == null) {
            zzakb.zzck("Touch event data is null. No touch event is reported.");
            return;
        }
        if (!zzaq("touch_reporting")) {
            zzakb.e("The ad slot cannot handle external touch events. You must be whitelisted to be able to report your touch events.");
            return;
        }
        this.zzbjc.zzaa().zza((int) bundle.getFloat("x"), (int) bundle.getFloat("y"), bundle.getInt("duration_ms"));
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void setClickConfirmingView(View view) {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbcf)).booleanValue()) {
            if (!this.zzbja.optBoolean("custom_one_point_five_click_enabled", false)) {
                zzakb.zzdk("Your account need to be whitelisted to use this feature.\nContact your account manager for more information.");
                return;
            }
            zzok zzokVar = this.zzbiz;
            if (view != null) {
                view.setOnClickListener(zzokVar);
                view.setClickable(true);
                zzokVar.zzbhq = new WeakReference<>(view);
            }
        }
    }

    /* JADX WARN: Failed to find 'out' block for switch in B:11:0x0020. Please report as an issue. */
    @Override // com.google.android.gms.internal.ads.zzoz
    @Nullable
    public View zza(View.OnClickListener onClickListener, boolean z) {
        zzoj zzojVarZzkc = this.zzbjb.zzkc();
        if (zzojVarZzkc == null) {
            return null;
        }
        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(-2, -2);
        if (!z) {
            int iZzju = zzojVarZzkc.zzju();
            if (iZzju != 0) {
                switch (iZzju) {
                    case 2:
                        layoutParams.addRule(12);
                        layoutParams.addRule(11);
                        break;
                    case 3:
                        layoutParams.addRule(12);
                        break;
                    default:
                        layoutParams.addRule(10);
                        layoutParams.addRule(11);
                        break;
                }
            } else {
                layoutParams.addRule(10);
            }
            layoutParams.addRule(9);
        }
        zzom zzomVar = new zzom(this.mContext, zzojVarZzkc, layoutParams);
        zzomVar.setOnClickListener(onClickListener);
        zzomVar.setContentDescription((CharSequence) zzkb.zzik().zzd(zznk.zzbbz));
        return zzomVar;
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final void zza(View view, zzox zzoxVar) {
        if (zzb(view, zzoxVar)) {
            return;
        }
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(-1, -1);
        ((FrameLayout) view).removeAllViews();
        if (this.zzbjb instanceof zzpc) {
            zzpc zzpcVar = (zzpc) this.zzbjb;
            if (zzpcVar.getImages() == null || zzpcVar.getImages().size() <= 0) {
                return;
            }
            Object obj = zzpcVar.getImages().get(0);
            zzpw zzpwVarZzh = obj instanceof IBinder ? zzpx.zzh((IBinder) obj) : null;
            if (zzpwVarZzh != null) {
                try {
                    IObjectWrapper iObjectWrapperZzjy = zzpwVarZzh.zzjy();
                    if (iObjectWrapperZzjy != null) {
                        Drawable drawable = (Drawable) ObjectWrapper.unwrap(iObjectWrapperZzjy);
                        ImageView imageView = new ImageView(this.mContext);
                        imageView.setImageDrawable(drawable);
                        imageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                        ((FrameLayout) view).addView(imageView, layoutParams);
                    }
                } catch (RemoteException unused) {
                    zzakb.zzdk("Could not get drawable from image");
                }
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final void zza(View view, String str, @Nullable Bundle bundle, Map<String, WeakReference<View>> map, View view2) {
        JSONObject jSONObject;
        JSONObject jSONObjectZza;
        JSONObject jSONObject2;
        JSONObject jSONObjectZza2 = zza(map, view2);
        JSONObject jSONObjectZzo = zzo(view2);
        JSONObject jSONObjectZzp = zzp(view2);
        JSONObject jSONObjectZzq = zzq(view2);
        JSONObject jSONObject3 = null;
        try {
            jSONObjectZza = com.google.android.gms.ads.internal.zzbv.zzek().zza(bundle, (JSONObject) null);
            jSONObject2 = new JSONObject();
        } catch (Exception e) {
            e = e;
        }
        try {
            jSONObject2.put("click_point", jSONObjectZza);
            jSONObject2.put("asset_id", str);
            jSONObject = jSONObject2;
        } catch (Exception e2) {
            e = e2;
            jSONObject3 = jSONObject2;
            zzakb.zzb("Error occurred while grabbing click signals.", e);
            jSONObject = jSONObject3;
        }
        zza(view, jSONObjectZzo, jSONObjectZza2, jSONObjectZzp, jSONObjectZzq, str, jSONObject, null);
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zza(View view, Map<String, WeakReference<View>> map) {
        zza(zzo(view), zza(map, view), zzp(view), zzq(view), (JSONObject) null);
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zza(View view, Map<String, WeakReference<View>> map, Bundle bundle, View view2) {
        String str;
        Preconditions.checkMainThread("Invalid call from a non-UI thread.");
        if (map != null) {
            synchronized (map) {
                for (Map.Entry<String, WeakReference<View>> entry : map.entrySet()) {
                    if (view.equals(entry.getValue().get())) {
                        zza(view, entry.getKey(), bundle, map, view2);
                        return;
                    }
                }
            }
        }
        if ("6".equals(this.zzbjb.zzkb())) {
            str = "3099";
        } else {
            if (!"2".equals(this.zzbjb.zzkb())) {
                if ("1".equals(this.zzbjb.zzkb())) {
                    zza(view, "1099", bundle, map, view2);
                    return;
                }
                return;
            }
            str = "2099";
        }
        zza(view, str, bundle, map, view2);
    }

    public void zza(View view, @Nullable Map<String, WeakReference<View>> map, @Nullable Map<String, WeakReference<View>> map2, View.OnTouchListener onTouchListener, View.OnClickListener onClickListener) {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbbw)).booleanValue()) {
            view.setOnTouchListener(onTouchListener);
            view.setClickable(true);
            view.setOnClickListener(onClickListener);
            if (map != null) {
                synchronized (map) {
                    Iterator<Map.Entry<String, WeakReference<View>>> it2 = map.entrySet().iterator();
                    while (it2.hasNext()) {
                        View view2 = it2.next().getValue().get();
                        if (view2 != null) {
                            view2.setOnTouchListener(onTouchListener);
                            view2.setClickable(true);
                            view2.setOnClickListener(onClickListener);
                        }
                    }
                }
            }
            if (map2 != null) {
                synchronized (map2) {
                    Iterator<Map.Entry<String, WeakReference<View>>> it3 = map2.entrySet().iterator();
                    while (it3.hasNext()) {
                        View view3 = it3.next().getValue().get();
                        if (view3 != null) {
                            view3.setOnTouchListener(onTouchListener);
                        }
                    }
                }
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zza(zzro zzroVar) {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbcf)).booleanValue()) {
            if (this.zzbja.optBoolean("custom_one_point_five_click_enabled", false)) {
                this.zzbiz.zza(zzroVar);
            } else {
                zzakb.zzdk("Your account need to be whitelisted to use this feature.\nContact your account manager for more information.");
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zzb(View view, Map<String, WeakReference<View>> map) {
        if (((Boolean) zzkb.zzik().zzd(zznk.zzbbv)).booleanValue()) {
            return;
        }
        view.setOnTouchListener(null);
        view.setClickable(false);
        view.setOnClickListener(null);
        if (map == null) {
            return;
        }
        synchronized (map) {
            Iterator<Map.Entry<String, WeakReference<View>>> it2 = map.entrySet().iterator();
            while (it2.hasNext()) {
                View view2 = it2.next().getValue().get();
                if (view2 != null) {
                    view2.setOnTouchListener(null);
                    view2.setClickable(false);
                    view2.setOnClickListener(null);
                }
            }
        }
    }

    public final boolean zzb(View view, zzox zzoxVar) {
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(-2, -2, 17);
        View viewZzkd = this.zzbjb.zzkd();
        if (viewZzkd == null) {
            return false;
        }
        ViewParent parent = viewZzkd.getParent();
        if (parent instanceof ViewGroup) {
            ((ViewGroup) parent).removeView(viewZzkd);
        }
        FrameLayout frameLayout = (FrameLayout) view;
        frameLayout.removeAllViews();
        frameLayout.addView(viewZzkd, layoutParams);
        this.zzbiw.zza(zzoxVar);
        return true;
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final void zzc(View view, Map<String, WeakReference<View>> map) {
        synchronized (this.mLock) {
            if (this.zzbjd) {
                return;
            }
            if (zzm(view)) {
                zza(view, map);
                return;
            }
            if (((Boolean) zzkb.zzik().zzd(zznk.zzbce)).booleanValue() && map != null) {
                synchronized (map) {
                    Iterator<Map.Entry<String, WeakReference<View>>> it2 = map.entrySet().iterator();
                    while (it2.hasNext()) {
                        View view2 = it2.next().getValue().get();
                        if (view2 != null && zzm(view2)) {
                            zza(view, map);
                            return;
                        }
                    }
                }
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zzcr() {
        this.zzbiw.zzcr();
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zzcs() {
        this.zzbiw.zzcs();
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final void zzd(MotionEvent motionEvent) {
        this.zzbjc.zza(motionEvent);
    }

    public final void zzf(Map<String, WeakReference<View>> map) {
        if (this.zzbjb.zzkd() != null) {
            if ("2".equals(this.zzbjb.zzkb())) {
                com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zza(this.zzbiw.getAdUnitId(), this.zzbjb.zzkb(), map.containsKey(NativeAppInstallAd.ASSET_MEDIA_VIDEO));
            } else if ("1".equals(this.zzbjb.zzkb())) {
                com.google.android.gms.ads.internal.zzbv.zzeo().zzqh().zza(this.zzbiw.getAdUnitId(), this.zzbjb.zzkb(), map.containsKey(NativeContentAd.ASSET_MEDIA_VIDEO));
            }
        }
    }

    public final void zzi(View view) {
        this.zzbiw.zzi(view);
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final void zzj(View view) {
        zzce zzceVarZzaa;
        if (!((Boolean) zzkb.zzik().zzd(zznk.zzbat)).booleanValue() || this.zzbjc == null || (zzceVarZzaa = this.zzbjc.zzaa()) == null) {
            return;
        }
        zzceVarZzaa.zzb(view);
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public boolean zzkj() {
        zzoj zzojVarZzkc = this.zzbjb.zzkc();
        return zzojVarZzkc != null && zzojVarZzkc.zzjv();
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public boolean zzkk() {
        return this.zzbja != null && this.zzbja.optBoolean("allow_pub_owned_ad_view", false);
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zzkl() {
        Preconditions.checkMainThread("Invalid call from a non-UI thread.");
        if (this.zzbje) {
            return;
        }
        this.zzbje = true;
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("ad", this.zzbja);
            jSONObject.put("ads_id", this.zzaae);
            zzanm.zza(this.zzaad.zzk(jSONObject), "NativeAdEngineImpl.recordDownloadedImpression");
        } catch (JSONException e) {
            zzane.zzb("", e);
        }
    }

    public zzaqw zzko() {
        if (this.zzbja == null || this.zzbja.optJSONObject("overlay") == null) {
            return null;
        }
        com.google.android.gms.ads.internal.zzbv.zzel();
        Context context = this.mContext;
        zzjn zzjnVarZzf = zzjn.zzf(this.mContext);
        zzaqw zzaqwVarZza = zzarc.zza(context, zzasi.zzb(zzjnVarZzf), zzjnVarZzf.zzarb, false, false, this.zzbjc, this.zzyf, null, null, null, zzhs.zzhm());
        if (zzaqwVarZza != null) {
            zzaqwVarZza.getView().setVisibility(8);
            new zzpf(zzaqwVarZza).zza(this.zzaad);
        }
        return zzaqwVarZza;
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zzkp() {
        this.zzaad.zzmc();
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public void zzkq() {
        this.zzbiw.zzct();
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final View zzkr() {
        if (this.zzbjf != null) {
            return this.zzbjf.get();
        }
        return null;
    }

    @Nullable
    public final zzaix zzks() {
        if (!com.google.android.gms.ads.internal.zzbv.zzfh().zzu(this.mContext)) {
            return null;
        }
        if (this.zzyv == null) {
            this.zzyv = new zzaix(this.mContext, this.zzbiw.getAdUnitId());
        }
        return this.zzyv;
    }

    @Override // com.google.android.gms.internal.ads.zzoz
    public final void zzl(View view) {
        this.zzbjf = new WeakReference<>(view);
    }
}
