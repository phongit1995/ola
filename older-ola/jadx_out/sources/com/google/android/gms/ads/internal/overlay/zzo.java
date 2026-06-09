package com.google.android.gms.ads.internal.overlay;

import android.R;
import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzamu;
import com.google.android.gms.internal.ads.zzkb;
import javax.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzo extends FrameLayout implements View.OnClickListener {
    private final ImageButton zzbyy;
    private final zzw zzbyz;

    public zzo(Context context, zzp zzpVar, @Nullable zzw zzwVar) {
        super(context);
        this.zzbyz = zzwVar;
        setOnClickListener(this);
        this.zzbyy = new ImageButton(context);
        this.zzbyy.setImageResource(R.drawable.btn_dialog);
        this.zzbyy.setBackgroundColor(0);
        this.zzbyy.setOnClickListener(this);
        ImageButton imageButton = this.zzbyy;
        zzkb.zzif();
        int iZza = zzamu.zza(context, zzpVar.paddingLeft);
        zzkb.zzif();
        int iZza2 = zzamu.zza(context, 0);
        zzkb.zzif();
        int iZza3 = zzamu.zza(context, zzpVar.paddingRight);
        zzkb.zzif();
        imageButton.setPadding(iZza, iZza2, iZza3, zzamu.zza(context, zzpVar.paddingBottom));
        this.zzbyy.setContentDescription("Interstitial close button");
        zzkb.zzif();
        zzamu.zza(context, zzpVar.size);
        ImageButton imageButton2 = this.zzbyy;
        zzkb.zzif();
        int iZza4 = zzamu.zza(context, zzpVar.size + zzpVar.paddingLeft + zzpVar.paddingRight);
        zzkb.zzif();
        addView(imageButton2, new FrameLayout.LayoutParams(iZza4, zzamu.zza(context, zzpVar.size + zzpVar.paddingBottom), 17));
    }

    @Override // android.view.View.OnClickListener
    public final void onClick(View view) {
        if (this.zzbyz != null) {
            this.zzbyz.zzni();
        }
    }

    public final void zzu(boolean z) {
        ImageButton imageButton;
        int i;
        if (z) {
            imageButton = this.zzbyy;
            i = 8;
        } else {
            imageButton = this.zzbyy;
            i = 0;
        }
        imageButton.setVisibility(i);
    }
}
