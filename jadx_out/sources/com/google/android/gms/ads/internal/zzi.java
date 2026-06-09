package com.google.android.gms.ads.internal;

import android.content.Context;
import android.support.annotation.Nullable;
import android.view.View;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.internal.ads.zzaam;
import com.google.android.gms.internal.ads.zzabl;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzait;
import com.google.android.gms.internal.ads.zzajh;
import com.google.android.gms.internal.ads.zzaji;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzakk;
import com.google.android.gms.internal.ads.zzang;
import com.google.android.gms.internal.ads.zzaqw;
import com.google.android.gms.internal.ads.zzarc;
import com.google.android.gms.internal.ads.zzasi;
import com.google.android.gms.internal.ads.zzjn;
import com.google.android.gms.internal.ads.zzkb;
import com.google.android.gms.internal.ads.zznk;
import com.google.android.gms.internal.ads.zznx;
import com.google.android.gms.internal.ads.zzod;
import com.google.android.gms.internal.ads.zzxn;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public abstract class zzi extends zzd implements zzaf, zzaam {
    private boolean zzwl;

    public zzi(Context context, zzjn zzjnVar, String str, zzxn zzxnVar, zzang zzangVar, zzw zzwVar) {
        super(context, zzjnVar, str, zzxnVar, zzangVar, zzwVar);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    protected zzaqw zza(zzaji zzajiVar, @Nullable zzx zzxVar, @Nullable zzait zzaitVar) {
        View nextView = this.zzvw.zzacs.getNextView();
        if (nextView instanceof zzaqw) {
            ((zzaqw) nextView).destroy();
        }
        if (nextView != 0) {
            this.zzvw.zzacs.removeView(nextView);
        }
        zzbv.zzel();
        zzaqw zzaqwVarZza = zzarc.zza(this.zzvw.zzrt, zzasi.zzb(this.zzvw.zzacv), this.zzvw.zzacv.zzarb, false, false, this.zzvw.zzacq, this.zzvw.zzacr, this.zzvr, this, this.zzwc, zzajiVar.zzcoq);
        if (this.zzvw.zzacv.zzard == null) {
            zzg(zzaqwVarZza.getView());
        }
        zzaqwVarZza.zzuf().zza(this, this, this, this, this, false, null, zzxVar, this, zzaitVar);
        zza(zzaqwVarZza);
        zzaqwVarZza.zzdr(zzajiVar.zzcgs.zzcdi);
        return zzaqwVarZza;
    }

    @Override // com.google.android.gms.internal.ads.zzaam
    public final void zza(int i, int i2, int i3, int i4) {
        zzbp();
    }

    @Override // com.google.android.gms.ads.internal.zza
    protected void zza(zzaji zzajiVar, zznx zznxVar) {
        if (zzajiVar.errorCode != -2) {
            zzakk.zzcrm.post(new zzk(this, zzajiVar));
            return;
        }
        if (zzajiVar.zzacv != null) {
            this.zzvw.zzacv = zzajiVar.zzacv;
        }
        if (!zzajiVar.zzcos.zzceq || zzajiVar.zzcos.zzarg) {
            zzakk.zzcrm.post(new zzl(this, zzajiVar, this.zzwc.zzxa.zza(this.zzvw.zzrt, this.zzvw.zzacr, zzajiVar.zzcos), zznxVar));
        } else {
            this.zzvw.zzadv = 0;
            zzbw zzbwVar = this.zzvw;
            zzbv.zzej();
            zzbwVar.zzacu = zzabl.zza(this.zzvw.zzrt, this, zzajiVar, this.zzvw.zzacq, null, this.zzwh, this, zznxVar);
        }
    }

    protected final void zza(zzaqw zzaqwVar) {
        zzaqwVar.zza("/trackActiveViewUnit", new zzj(this));
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public final void zza(zzod zzodVar) {
        Preconditions.checkMainThread("setOnCustomRenderedAdLoadedListener must be called on the main UI thread.");
        this.zzvw.zzado = zzodVar;
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.ads.internal.zza
    protected boolean zza(@Nullable zzajh zzajhVar, zzajh zzajhVar2) {
        if (this.zzvw.zzfo() && this.zzvw.zzacs != null) {
            this.zzvw.zzacs.zzfr().zzdb(zzajhVar2.zzcev);
        }
        try {
            if (zzajhVar2.zzbyo != null && !zzajhVar2.zzceq && zzajhVar2.zzcor) {
                if (((Boolean) zzkb.zzik().zzd(zznk.zzbfq)).booleanValue() && !zzajhVar2.zzccv.extras.containsKey("sdk_less_server_data")) {
                    try {
                        zzajhVar2.zzbyo.zzus();
                    } catch (Throwable unused) {
                        zzakb.v("Could not render test Ad label.");
                    }
                }
            }
        } catch (RuntimeException unused2) {
            zzakb.v("Could not render test AdLabel.");
        }
        return super.zza(zzajhVar, zzajhVar2);
    }

    @VisibleForTesting
    final void zzb(zzaqw zzaqwVar) {
        if (this.zzvw.zzacw != null) {
            this.zzvy.zza(this.zzvw.zzacv, this.zzvw.zzacw, zzaqwVar.getView(), zzaqwVar);
            this.zzwl = false;
        } else {
            this.zzwl = true;
            zzakb.zzdk("Request to enable ActiveView before adState is available.");
        }
    }

    @Override // com.google.android.gms.ads.internal.zza
    protected void zzbq() {
        super.zzbq();
        if (this.zzwl) {
            if (((Boolean) zzkb.zzik().zzd(zznk.zzbcb)).booleanValue()) {
                zzb(this.zzvw.zzacw.zzbyo);
            }
        }
    }

    @Override // com.google.android.gms.ads.internal.zzaf
    public final void zzcn() {
        onAdClicked();
    }

    @Override // com.google.android.gms.ads.internal.zzaf
    public final void zzco() {
        recordImpression();
        zzbm();
    }

    protected final boolean zzcp() {
        return (this.zzvw.zzacx == null || this.zzvw.zzacx.zzcos == null || !this.zzvw.zzacx.zzcos.zzcfp) ? false : true;
    }

    @Override // com.google.android.gms.internal.ads.zzaam
    public final void zzcq() {
        zzbn();
    }

    @Override // com.google.android.gms.ads.internal.zzaf
    public final void zzh(View view) {
        this.zzvw.zzadu = view;
        zzb(new zzajh(this.zzvw.zzacx, null, null, null, null, null, null, null));
    }
}
