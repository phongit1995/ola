.class public final Lcom/google/android/gms/internal/firebase_auth/zzba;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzcg;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzcg<",
        "Lcom/google/android/gms/internal/firebase_auth/zzba;",
        "Lcom/google/android/gms/internal/firebase_auth/zzg$zze;",
        ">;"
    }
.end annotation


# instance fields
.field private zzaf:Ljava/lang/String;

.field private zzah:Ljava/lang/String;

.field private zzai:Ljava/lang/String;

.field private zzaj:J

.field private zzbh:Ljava/lang/String;

.field private zzbi:Ljava/lang/String;

.field private zzbr:Ljava/lang/String;

.field private zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

.field private zzkg:Ljava/lang/Boolean;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getEmail()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzah:Ljava/lang/String;

    return-object v0
.end method

.method public final getIdToken()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzaf:Ljava/lang/String;

    return-object v0
.end method

.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgt;)Lcom/google/firebase/auth/api/internal/zzcg;
    .locals 2

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzah:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzah:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzby:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzbi:Ljava/lang/String;

    iget-boolean v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbk:Z

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzkg:Ljava/lang/Boolean;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbh:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzbh:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbr:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzbr:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzas;->zza([Lcom/google/android/gms/internal/firebase_auth/zzt;)Lcom/google/android/gms/internal/firebase_auth/zzas;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaf:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzaf:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzai:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzai:Ljava/lang/String;

    iget-wide v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;->zzaj:J

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzaj:J

    return-object p0
.end method

.method public final zzag()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "Lcom/google/android/gms/internal/firebase_auth/zzg$zze;",
            ">;"
        }
    .end annotation

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzg$zze;

    return-object v0
.end method

.method public final zzap()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzai:Ljava/lang/String;

    return-object v0
.end method

.method public final zzaq()J
    .locals 2

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzaj:J

    return-wide v0
.end method

.method public final zzat()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/google/android/gms/internal/firebase_auth/zzaq;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzas;->zzat()Ljava/util/List;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method
