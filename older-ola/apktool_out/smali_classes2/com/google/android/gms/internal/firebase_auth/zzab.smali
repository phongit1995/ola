.class public final Lcom/google/android/gms/internal/firebase_auth/zzab;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzcg;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzcg<",
        "Lcom/google/android/gms/internal/firebase_auth/zzab;",
        "Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;",
        ">;"
    }
.end annotation


# instance fields
.field private zzad:Ljava/lang/String;

.field private zzaf:Ljava/lang/String;

.field private zzah:Ljava/lang/String;

.field private zzai:Ljava/lang/String;

.field private zzaj:J

.field private zzak:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getIdToken()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzaf:Ljava/lang/String;

    return-object v0
.end method

.method public final isNewUser()Z
    .locals 1

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzak:Z

    return v0
.end method

.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgt;)Lcom/google/firebase/auth/api/internal/zzcg;
    .locals 2

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;->zzad:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzad:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;->zzah:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzah:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;->zzaf:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzaf:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;->zzai:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzai:Ljava/lang/String;

    iget-boolean v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;->zzak:Z

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzak:Z

    iget-wide v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;->zzaj:J

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzaj:J

    return-object p0
.end method

.method public final zzag()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;",
            ">;"
        }
    .end annotation

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzb;

    return-object v0
.end method

.method public final zzap()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzai:Ljava/lang/String;

    return-object v0
.end method

.method public final zzaq()J
    .locals 2

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzab;->zzaj:J

    return-wide v0
.end method
