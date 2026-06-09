.class abstract Lcom/google/android/gms/internal/firebase_auth/zzfp;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        "B:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method abstract zza(Ljava/lang/Object;IJ)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TB;IJ)V"
        }
    .end annotation
.end method

.method abstract zza(Ljava/lang/Object;ILcom/google/android/gms/internal/firebase_auth/zzbu;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TB;I",
            "Lcom/google/android/gms/internal/firebase_auth/zzbu;",
            ")V"
        }
    .end annotation
.end method

.method abstract zza(Ljava/lang/Object;ILjava/lang/Object;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TB;ITT;)V"
        }
    .end annotation
.end method

.method abstract zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzgj;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/google/android/gms/internal/firebase_auth/zzgj;",
            ")V"
        }
    .end annotation
.end method

.method abstract zza(Lcom/google/android/gms/internal/firebase_auth/zzeu;)Z
.end method

.method final zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzeu;)Z
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TB;",
            "Lcom/google/android/gms/internal/firebase_auth/zzeu;",
            ")Z"
        }
    .end annotation

    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->getTag()I

    move-result v0

    ushr-int/lit8 v1, v0, 0x3

    and-int/lit8 v0, v0, 0x7

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :pswitch_0
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzch()I

    move-result p2

    invoke-virtual {p0, p1, v1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzc(Ljava/lang/Object;II)V

    return v2

    :pswitch_1
    const/4 p1, 0x0

    return p1

    :pswitch_2
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzfy()Ljava/lang/Object;

    move-result-object v0

    shl-int/lit8 v3, v1, 0x3

    or-int/lit8 v3, v3, 0x4

    :cond_0
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzda()I

    move-result v4

    const v5, 0x7fffffff

    if-eq v4, v5, :cond_1

    invoke-virtual {p0, v0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzeu;)Z

    move-result v4

    if-nez v4, :cond_0

    :cond_1
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->getTag()I

    move-result p2

    if-eq v3, p2, :cond_2

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzeh()Lcom/google/android/gms/internal/firebase_auth/zzdh;

    move-result-object p1

    throw p1

    :cond_2
    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    invoke-virtual {p0, p1, v1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zza(Ljava/lang/Object;ILjava/lang/Object;)V

    return v2

    :pswitch_3
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzck()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object p2

    invoke-virtual {p0, p1, v1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zza(Ljava/lang/Object;ILcom/google/android/gms/internal/firebase_auth/zzbu;)V

    return v2

    :pswitch_4
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzcg()J

    move-result-wide v3

    invoke-virtual {p0, p1, v1, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zzb(Ljava/lang/Object;IJ)V

    return v2

    :pswitch_5
    invoke-interface {p2}, Lcom/google/android/gms/internal/firebase_auth/zzeu;->zzce()J

    move-result-wide v3

    invoke-virtual {p0, p1, v1, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzfp;->zza(Ljava/lang/Object;IJ)V

    return v2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method abstract zzb(Ljava/lang/Object;IJ)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TB;IJ)V"
        }
    .end annotation
.end method

.method abstract zzc(Ljava/lang/Object;II)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TB;II)V"
        }
    .end annotation
.end method

.method abstract zzc(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzgj;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/google/android/gms/internal/firebase_auth/zzgj;",
            ")V"
        }
    .end annotation
.end method

.method abstract zze(Ljava/lang/Object;)V
.end method

.method abstract zze(Ljava/lang/Object;Ljava/lang/Object;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "TT;)V"
        }
    .end annotation
.end method

.method abstract zzf(Ljava/lang/Object;Ljava/lang/Object;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "TB;)V"
        }
    .end annotation
.end method

.method abstract zzfy()Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TB;"
        }
    .end annotation
.end method

.method abstract zzg(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;TT;)TT;"
        }
    .end annotation
.end method

.method abstract zzl(Ljava/lang/Object;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TB;)TT;"
        }
    .end annotation
.end method

.method abstract zzo(Ljava/lang/Object;)I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)I"
        }
    .end annotation
.end method

.method abstract zzr(Ljava/lang/Object;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")TT;"
        }
    .end annotation
.end method

.method abstract zzs(Ljava/lang/Object;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")TB;"
        }
    .end annotation
.end method

.method abstract zzt(Ljava/lang/Object;)I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)I"
        }
    .end annotation
.end method
