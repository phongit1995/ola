.class final Lcom/google/android/gms/internal/firebase_auth/zzem;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/internal/firebase_auth/zzev;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/google/android/gms/internal/firebase_auth/zzev<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private final zzto:Lcom/google/android/gms/internal/firebase_auth/zzeh;

.field private final zztp:Z

.field private final zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/internal/firebase_auth/zzfp<",
            "**>;"
        }
    .end annotation
.end field

.field private final zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/internal/firebase_auth/zzcp<",
            "*>;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzeh;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/internal/firebase_auth/zzfp<",
            "**>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzcp<",
            "*>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzeh;",
            ")V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    invoke-virtual {p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zze(Lcom/google/android/gms/internal/firebase_auth/zzeh;)Z

    move-result p1

    iput-boolean p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztp:Z

    iput-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    iput-object p3, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzto:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    return-void
.end method

.method static zza(Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzeh;)Lcom/google/android/gms/internal/firebase_auth/zzem;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/internal/firebase_auth/zzfp<",
            "**>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzcp<",
            "*>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzeh;",
            ")",
            "Lcom/google/android/gms/internal/firebase_auth/zzem<",
            "TT;>;"
        }
    .end annotation

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzem;

    invoke-direct {v0, p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzem;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzeh;)V

    return-object v0
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;TT;)Z"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzr(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    invoke-virtual {v1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzr(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztp:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zzc(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzcs;

    move-result-object p1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-virtual {v0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zzc(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzcs;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzcs;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_1
    const/4 p1, 0x1

    return p1
.end method

.method public final hashCode(Ljava/lang/Object;)I
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)I"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzr(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztp:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zzc(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzcs;

    move-result-object p1

    mul-int/lit8 v0, v0, 0x35

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcs;->hashCode()I

    move-result p1

    add-int/2addr v0, p1

    :cond_0
    return v0
.end method

.method public final newInstance()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzto:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    invoke-interface {v0}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzea()Lcom/google/android/gms/internal/firebase_auth/zzei;

    move-result-object v0

    invoke-interface {v0}, Lcom/google/android/gms/internal/firebase_auth/zzei;->zzec()Lcom/google/android/gms/internal/firebase_auth/zzeh;

    move-result-object v0

    return-object v0
.end method

.method public final zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzeu;Lcom/google/android/gms/internal/firebase_auth/zzco;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/google/android/gms/internal/firebase_auth/zzeu;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")V"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzs(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zzd(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzcs;

    move-result-object v3

    :cond_0
    :try_start_0
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzda()I

    move-result v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const v5, 0x7fffffff

    if-ne v4, v5, :cond_1

    invoke-virtual {v0, p1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzf(Ljava/lang/Object;Ljava/lang/Object;)V

    return-void

    :cond_1
    :try_start_1
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->getTag()I

    move-result v4

    const/16 v6, 0xb

    if-eq v4, v6, :cond_4

    and-int/lit8 v5, v4, 0x7

    const/4 v6, 0x2

    if-ne v5, v6, :cond_3

    iget-object v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzto:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    ushr-int/lit8 v4, v4, 0x3

    invoke-virtual {v1, p3, v5, v4}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zza(Lcom/google/android/gms/internal/firebase_auth/zzco;Lcom/google/android/gms/internal/firebase_auth/zzeh;I)Ljava/lang/Object;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-virtual {v1, p2, v4, p3, v3}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zza(Lcom/google/android/gms/internal/firebase_auth/zzeu;Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzco;Lcom/google/android/gms/internal/firebase_auth/zzcs;)V

    goto :goto_1

    :cond_2
    invoke-virtual {v0, v2, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzeu;)Z

    move-result v4

    goto :goto_2

    :cond_3
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzdb()Z

    move-result v4

    goto :goto_2

    :cond_4
    const/4 v4, 0x0

    const/4 v6, 0x0

    move-object v4, v6

    const/4 v7, 0x0

    :cond_5
    :goto_0
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzda()I

    move-result v8

    if-eq v8, v5, :cond_9

    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->getTag()I

    move-result v8

    const/16 v9, 0x10

    if-ne v8, v9, :cond_6

    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzcl()I

    move-result v7

    iget-object v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzto:Lcom/google/android/gms/internal/firebase_auth/zzeh;

    invoke-virtual {v1, p3, v6, v7}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zza(Lcom/google/android/gms/internal/firebase_auth/zzco;Lcom/google/android/gms/internal/firebase_auth/zzeh;I)Ljava/lang/Object;

    move-result-object v6

    goto :goto_0

    :cond_6
    const/16 v9, 0x1a

    if-ne v8, v9, :cond_8

    if-eqz v6, :cond_7

    invoke-virtual {v1, p2, v6, p3, v3}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zza(Lcom/google/android/gms/internal/firebase_auth/zzeu;Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzco;Lcom/google/android/gms/internal/firebase_auth/zzcs;)V

    goto :goto_0

    :cond_7
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzck()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object v4

    goto :goto_0

    :cond_8
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzdb()Z

    move-result v8

    if-nez v8, :cond_5

    :cond_9
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->getTag()I

    move-result v5

    const/16 v8, 0xc

    if-eq v5, v8, :cond_a

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzeh()Lcom/google/android/gms/internal/firebase_auth/zzdh;

    move-result-object p2

    throw p2

    :cond_a
    if-eqz v4, :cond_c

    if-eqz v6, :cond_b

    invoke-virtual {v1, v4, v6, p3, v3}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbu;Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzco;Lcom/google/android/gms/internal/firebase_auth/zzcs;)V

    goto :goto_1

    :cond_b
    invoke-virtual {v0, v2, v7, v4}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zza(Ljava/lang/Object;ILcom/google/android/gms/internal/firebase_auth/zzbu;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_c
    :goto_1
    const/4 v4, 0x1

    :goto_2
    if-nez v4, :cond_0

    invoke-virtual {v0, p1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzf(Ljava/lang/Object;Ljava/lang/Object;)V

    return-void

    :catchall_0
    move-exception p2

    invoke-virtual {v0, p1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzf(Ljava/lang/Object;Ljava/lang/Object;)V

    throw p2
.end method

.method public final zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzgj;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/google/android/gms/internal/firebase_auth/zzgj;",
            ")V"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zzc(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzcs;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcs;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/google/android/gms/internal/firebase_auth/zzcu;

    invoke-interface {v2}, Lcom/google/android/gms/internal/firebase_auth/zzcu;->zzdu()Lcom/google/android/gms/internal/firebase_auth/zzgi;

    move-result-object v3

    sget-object v4, Lcom/google/android/gms/internal/firebase_auth/zzgi;->zzxi:Lcom/google/android/gms/internal/firebase_auth/zzgi;

    if-ne v3, v4, :cond_2

    invoke-interface {v2}, Lcom/google/android/gms/internal/firebase_auth/zzcu;->zzdv()Z

    move-result v3

    if-nez v3, :cond_2

    invoke-interface {v2}, Lcom/google/android/gms/internal/firebase_auth/zzcu;->zzdw()Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_2

    :cond_0
    instance-of v3, v1, Lcom/google/android/gms/internal/firebase_auth/zzdm;

    if-eqz v3, :cond_1

    invoke-interface {v2}, Lcom/google/android/gms/internal/firebase_auth/zzcu;->zzds()I

    move-result v2

    check-cast v1, Lcom/google/android/gms/internal/firebase_auth/zzdm;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzdm;->zzen()Lcom/google/android/gms/internal/firebase_auth/zzdk;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzbo()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object v1

    :goto_1
    invoke-interface {p2, v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgj;->zza(ILjava/lang/Object;)V

    goto :goto_0

    :cond_1
    invoke-interface {v2}, Lcom/google/android/gms/internal/firebase_auth/zzcu;->zzds()I

    move-result v2

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    goto :goto_1

    :cond_2
    :goto_2
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Found invalid MessageSet item."

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_3
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzr(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzc(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzgj;)V

    return-void
.end method

.method public final zzc(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;TT;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    invoke-static {v0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zza(Lcom/google/android/gms/internal/firebase_auth/zzfp;Ljava/lang/Object;Ljava/lang/Object;)V

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztp:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-static {v0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zza(Lcom/google/android/gms/internal/firebase_auth/zzcp;Ljava/lang/Object;Ljava/lang/Object;)V

    :cond_0
    return-void
.end method

.method public final zze(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zze(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zze(Ljava/lang/Object;)V

    return-void
.end method

.method public final zzo(Ljava/lang/Object;)I
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)I"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zzty:Lcom/google/android/gms/internal/firebase_auth/zzfp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzr(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzt(Ljava/lang/Object;)I

    move-result v0

    add-int/lit8 v0, v0, 0x0

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztp:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zzc(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzcs;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcs;->zzdr()I

    move-result p1

    add-int/2addr v0, p1

    :cond_0
    return v0
.end method

.method public final zzp(Ljava/lang/Object;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)Z"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzem;->zztz:Lcom/google/android/gms/internal/firebase_auth/zzcp;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcp;->zzc(Ljava/lang/Object;)Lcom/google/android/gms/internal/firebase_auth/zzcs;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcs;->isInitialized()Z

    move-result p1

    return p1
.end method
