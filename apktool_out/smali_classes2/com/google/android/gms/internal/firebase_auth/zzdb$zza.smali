.class public Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;
.super Lcom/google/android/gms/internal/firebase_auth/zzbo;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/internal/firebase_auth/zzdb;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "zza"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<MessageType:",
        "Lcom/google/android/gms/internal/firebase_auth/zzdb<",
        "TMessageType;TBuilderType;>;BuilderType:",
        "Lcom/google/android/gms/internal/firebase_auth/zzdb$zza<",
        "TMessageType;TBuilderType;>;>",
        "Lcom/google/android/gms/internal/firebase_auth/zzbo<",
        "TMessageType;TBuilderType;>;"
    }
.end annotation


# instance fields
.field private final zzra:Lcom/google/android/gms/internal/firebase_auth/zzdb;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TMessageType;"
        }
    .end annotation
.end field

.field private zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TMessageType;"
        }
    .end annotation
.end field

.field private zzrc:Z


# direct methods
.method protected constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzdb;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TMessageType;)V"
        }
    .end annotation

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbo;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzra:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    sget v0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzrh:I

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    return-void
.end method

.method private static zza(Lcom/google/android/gms/internal/firebase_auth/zzdb;Lcom/google/android/gms/internal/firebase_auth/zzdb;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TMessageType;TMessageType;)V"
        }
    .end annotation

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzfg()Lcom/google/android/gms/internal/firebase_auth/zzes;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzq(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzev;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zzc(Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public synthetic clone()Ljava/lang/Object;
    .locals 3

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzra:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    sget v1, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzri:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v2}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    if-eqz v1, :cond_0

    :goto_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzfg()Lcom/google/android/gms/internal/firebase_auth/zzes;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzq(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzev;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zze(Ljava/lang/Object;)V

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    goto :goto_0

    :goto_1
    check-cast v1, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzdb;)Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;

    return-object v0
.end method

.method public final isInitialized()Z
    .locals 2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(Lcom/google/android/gms/internal/firebase_auth/zzdb;Z)Z

    move-result v0

    return v0
.end method

.method protected final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzbn;)Lcom/google/android/gms/internal/firebase_auth/zzbo;
    .locals 0

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzdb;)Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzdb;)Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TMessageType;)TBuilderType;"
        }
    .end annotation

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    sget v1, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzrh:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v2}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-static {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzdb;Lcom/google/android/gms/internal/firebase_auth/zzdb;)V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-static {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzdb;Lcom/google/android/gms/internal/firebase_auth/zzdb;)V

    return-object p0
.end method

.method public final synthetic zzbq()Lcom/google/android/gms/internal/firebase_auth/zzbo;
    .locals 1

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbo;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;

    return-object v0
.end method

.method public final synthetic zzeb()Lcom/google/android/gms/internal/firebase_auth/zzeh;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzra:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    return-object v0
.end method

.method public final synthetic zzec()Lcom/google/android/gms/internal/firebase_auth/zzeh;
    .locals 2

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzfg()Lcom/google/android/gms/internal/firebase_auth/zzes;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzq(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzev;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zze(Ljava/lang/Object;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    return-object v0
.end method

.method public final synthetic zzed()Lcom/google/android/gms/internal/firebase_auth/zzeh;
    .locals 5

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    :goto_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrb:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzfg()Lcom/google/android/gms/internal/firebase_auth/zzes;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzq(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzev;

    move-result-object v2

    invoke-interface {v2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zze(Ljava/lang/Object;)V

    iput-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zza;->zzrc:Z

    goto :goto_0

    :goto_1
    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    sget-object v2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    sget v3, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzre:I

    const/4 v4, 0x0

    invoke-virtual {v0, v3, v4, v4}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Byte;

    invoke-virtual {v3}, Ljava/lang/Byte;->byteValue()B

    move-result v3

    if-ne v3, v1, :cond_1

    goto :goto_3

    :cond_1
    if-nez v3, :cond_2

    const/4 v1, 0x0

    goto :goto_3

    :cond_2
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzfg()Lcom/google/android/gms/internal/firebase_auth/zzes;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzq(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzev;

    move-result-object v1

    invoke-interface {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zzp(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v2, :cond_4

    sget v2, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzrf:I

    if-eqz v1, :cond_3

    move-object v3, v0

    goto :goto_2

    :cond_3
    move-object v3, v4

    :goto_2
    invoke-virtual {v0, v2, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_4
    :goto_3
    if-nez v1, :cond_5

    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzfo;

    invoke-direct {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzfo;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzeh;)V

    throw v1

    :cond_5
    return-object v0
.end method
