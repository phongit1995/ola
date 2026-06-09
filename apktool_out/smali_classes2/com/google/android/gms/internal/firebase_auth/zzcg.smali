.class final Lcom/google/android/gms/internal/firebase_auth/zzcg;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/internal/firebase_auth/zzeu;


# instance fields
.field private tag:I

.field private final zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

.field private zznc:I

.field private zznd:I


# direct methods
.method private constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzcd;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    const-string v0, "input"

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzdd;->zza(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iput-object p0, p1, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmt:Lcom/google/android/gms/internal/firebase_auth/zzcg;

    return-void
.end method

.method public static zza(Lcom/google/android/gms/internal/firebase_auth/zzcd;)Lcom/google/android/gms/internal/firebase_auth/zzcg;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmt:Lcom/google/android/gms/internal/firebase_auth/zzcg;

    if-eqz v0, :cond_0

    iget-object p0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmt:Lcom/google/android/gms/internal/firebase_auth/zzcg;

    return-object p0

    :cond_0
    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzcg;

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzcd;)V

    return-object v0
.end method

.method private final zza(Lcom/google/android/gms/internal/firebase_auth/zzgd;Ljava/lang/Class;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/internal/firebase_auth/zzgd;",
            "Ljava/lang/Class<",
            "*>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzch;->zzne:[I

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgd;->ordinal()I

    move-result p1

    aget p1, v0, p1

    packed-switch p1, :pswitch_data_0

    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "unsupported field type."

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcd()J

    move-result-wide p1

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    return-object p1

    :pswitch_1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcl()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1

    :pswitch_2
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcj()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :pswitch_3
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcq()J

    move-result-wide p1

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    return-object p1

    :pswitch_4
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcp()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1

    :pswitch_5
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzco()J

    move-result-wide p1

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    return-object p1

    :pswitch_6
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcn()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1

    :pswitch_7
    const/4 p1, 0x2

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzfg()Lcom/google/android/gms/internal/firebase_auth/zzes;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzes;->zzf(Ljava/lang/Class;)Lcom/google/android/gms/internal/firebase_auth/zzev;

    move-result-object p1

    invoke-direct {p0, p1, p3}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzc(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :pswitch_8
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzce()J

    move-result-wide p1

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    return-object p1

    :pswitch_9
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcf()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1

    :pswitch_a
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->readFloat()F

    move-result p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    return-object p1

    :pswitch_b
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcg()J

    move-result-wide p1

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    return-object p1

    :pswitch_c
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzch()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1

    :pswitch_d
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcm()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1

    :pswitch_e
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->readDouble()D

    move-result-wide p1

    invoke-static {p1, p2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p1

    return-object p1

    :pswitch_f
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzck()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object p1

    return-object p1

    :pswitch_10
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzci()Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final zza(Ljava/util/List;Z)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;Z)V"
        }
    .end annotation

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdq;

    if-eqz v0, :cond_3

    if-nez p2, :cond_3

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdq;

    :cond_1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzck()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdq;->zzc(Lcom/google/android/gms/internal/firebase_auth/zzbu;)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_2

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, p2, :cond_1

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_3
    if-eqz p2, :cond_4

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzcj()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_4
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->readString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_5

    return-void

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_3

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method private final zzc(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/internal/firebase_auth/zzev<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")TT;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iget v1, v1, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmq:I

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iget v2, v2, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmr:I

    if-lt v1, v2, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzej()Lcom/google/android/gms/internal/firebase_auth/zzdh;

    move-result-object p1

    throw p1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzp(I)I

    move-result v0

    invoke-interface {p1}, Lcom/google/android/gms/internal/firebase_auth/zzev;->newInstance()Ljava/lang/Object;

    move-result-object v1

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iget v3, v2, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmq:I

    add-int/lit8 v3, v3, 0x1

    iput v3, v2, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmq:I

    invoke-interface {p1, v1, p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzeu;Lcom/google/android/gms/internal/firebase_auth/zzco;)V

    invoke-interface {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zze(Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzm(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iget p2, p1, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmq:I

    add-int/lit8 p2, p2, -0x1

    iput p2, p1, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmq:I

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzq(I)V

    return-object v1
.end method

.method private final zzd(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/internal/firebase_auth/zzev<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")TT;"
        }
    .end annotation

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznc:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    ushr-int/lit8 v1, v1, 0x3

    shl-int/lit8 v1, v1, 0x3

    or-int/lit8 v1, v1, 0x4

    iput v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznc:I

    :try_start_0
    invoke-interface {p1}, Lcom/google/android/gms/internal/firebase_auth/zzev;->newInstance()Ljava/lang/Object;

    move-result-object v1

    invoke-interface {p1, v1, p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzeu;Lcom/google/android/gms/internal/firebase_auth/zzco;)V

    invoke-interface {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zze(Ljava/lang/Object;)V

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    iget p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznc:I

    if-eq p1, p2, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzek()Lcom/google/android/gms/internal/firebase_auth/zzdh;

    move-result-object p1

    throw p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznc:I

    return-object v1

    :catchall_0
    move-exception p1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznc:I

    throw p1
.end method

.method private final zzs(I)V
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eq v0, p1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    return-void
.end method

.method private static zzt(I)V
    .locals 0

    and-int/lit8 p0, p0, 0x7

    if-eqz p0, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzek()Lcom/google/android/gms/internal/firebase_auth/zzdh;

    move-result-object p0

    throw p0

    :cond_0
    return-void
.end method

.method private static zzu(I)V
    .locals 0

    and-int/lit8 p0, p0, 0x3

    if-eqz p0, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzek()Lcom/google/android/gms/internal/firebase_auth/zzdh;

    move-result-object p0

    throw p0

    :cond_0
    return-void
.end method

.method private final zzv(I)V
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-eq v0, p1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzee()Lcom/google/android/gms/internal/firebase_auth/zzdh;

    move-result-object p1

    throw p1

    :cond_0
    return-void
.end method


# virtual methods
.method public final getTag()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    return v0
.end method

.method public final readDouble()D
    .locals 2

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readDouble()D

    move-result-wide v0

    return-wide v0
.end method

.method public final readFloat()F
    .locals 1

    const/4 v0, 0x5

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readFloat()F

    move-result v0

    return v0
.end method

.method public final readString()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final readStringList(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zza(Ljava/util/List;Z)V

    return-void
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/internal/firebase_auth/zzev<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")TT;"
        }
    .end annotation

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    invoke-direct {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzc(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Ljava/util/List;Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/List<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzev<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")V"
        }
    .end annotation

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    :cond_1
    invoke-direct {p0, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzc(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {p1, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v1

    if-nez v1, :cond_3

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    if-eqz v1, :cond_2

    return-void

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v1

    if-eq v1, v0, :cond_1

    iput v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    :cond_3
    return-void
.end method

.method public final zza(Ljava/util/Map;Lcom/google/android/gms/internal/firebase_auth/zzea;Lcom/google/android/gms/internal/firebase_auth/zzco;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K:",
            "Ljava/lang/Object;",
            "V:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/Map<",
            "TK;TV;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzea<",
            "TK;TV;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")V"
        }
    .end annotation

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzp(I)I

    move-result v0

    iget-object v1, p2, Lcom/google/android/gms/internal/firebase_auth/zzea;->zztc:Ljava/lang/Object;

    iget-object v2, p2, Lcom/google/android/gms/internal/firebase_auth/zzea;->zzte:Ljava/lang/Object;

    :cond_0
    :goto_0
    :try_start_0
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzda()I

    move-result v3

    const v4, 0x7fffffff

    if-eq v3, v4, :cond_1

    iget-object v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v4}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v4, :cond_1

    packed-switch v3, :pswitch_data_0

    :try_start_1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzdb()Z

    move-result v3

    goto :goto_1

    :pswitch_0
    iget-object v3, p2, Lcom/google/android/gms/internal/firebase_auth/zzea;->zztd:Lcom/google/android/gms/internal/firebase_auth/zzgd;

    iget-object v4, p2, Lcom/google/android/gms/internal/firebase_auth/zzea;->zzte:Ljava/lang/Object;

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-direct {p0, v3, v4, p3}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgd;Ljava/lang/Class;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;

    move-result-object v3

    move-object v2, v3

    goto :goto_0

    :pswitch_1
    iget-object v3, p2, Lcom/google/android/gms/internal/firebase_auth/zzea;->zztb:Lcom/google/android/gms/internal/firebase_auth/zzgd;

    const/4 v4, 0x0

    invoke-direct {p0, v3, v4, v4}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgd;Ljava/lang/Class;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;

    move-result-object v3

    move-object v1, v3

    goto :goto_0

    :goto_1
    if-nez v3, :cond_0

    new-instance v3, Lcom/google/android/gms/internal/firebase_auth/zzdh;

    const-string v4, "Unable to parse map entry."

    invoke-direct {v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzdh;-><init>(Ljava/lang/String;)V

    throw v3
    :try_end_1
    .catch Lcom/google/android/gms/internal/firebase_auth/zzdi; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :try_start_2
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzdb()Z

    move-result v3

    if-nez v3, :cond_0

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzdh;

    const-string p2, "Unable to parse map entry."

    invoke-direct {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzdh;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    invoke-interface {p1, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzq(I)V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzq(I)V

    throw p1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final zzb(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/internal/firebase_auth/zzev<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")TT;"
        }
    .end annotation

    const/4 v0, 0x3

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    invoke-direct {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzd(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Ljava/util/List;Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/List<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzev<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")V"
        }
    .end annotation

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    :cond_1
    invoke-direct {p0, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzd(Lcom/google/android/gms/internal/firebase_auth/zzev;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {p1, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v1

    if-nez v1, :cond_3

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    if-eqz v1, :cond_2

    return-void

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v1

    if-eq v1, v0, :cond_1

    iput v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    :cond_3
    return-void
.end method

.method public final zzc(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzcl;

    if-eqz v0, :cond_3

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzcl;

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    packed-switch v0, :pswitch_data_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :pswitch_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzt(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readDouble()D

    move-result-wide v2

    invoke-virtual {p1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzcl;->zzc(D)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_0

    return-void

    :cond_1
    :pswitch_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readDouble()D

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcl;->zzc(D)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_2

    return-void

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_3
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    packed-switch v0, :pswitch_data_1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :pswitch_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzt(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readDouble()D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_4

    return-void

    :cond_5
    :pswitch_3
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readDouble()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_6

    return-void

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_5

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public final zzcd()J
    .locals 2

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcd()J

    move-result-wide v0

    return-wide v0
.end method

.method public final zzce()J
    .locals 2

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzce()J

    move-result-wide v0

    return-wide v0
.end method

.method public final zzcf()I
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcf()I

    move-result v0

    return v0
.end method

.method public final zzcg()J
    .locals 2

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcg()J

    move-result-wide v0

    return-wide v0
.end method

.method public final zzch()I
    .locals 1

    const/4 v0, 0x5

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzch()I

    move-result v0

    return v0
.end method

.method public final zzci()Z
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzci()Z

    move-result v0

    return v0
.end method

.method public final zzcj()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcj()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final zzck()Lcom/google/android/gms/internal/firebase_auth/zzbu;
    .locals 1

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzck()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object v0

    return-object v0
.end method

.method public final zzcl()I
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    return v0
.end method

.method public final zzcm()I
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcm()I

    move-result v0

    return v0
.end method

.method public final zzcn()I
    .locals 1

    const/4 v0, 0x5

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcn()I

    move-result v0

    return v0
.end method

.method public final zzco()J
    .locals 2

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzco()J

    move-result-wide v0

    return-wide v0
.end method

.method public final zzcp()I
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcp()I

    move-result v0

    return v0
.end method

.method public final zzcq()J
    .locals 2

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzs(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcq()J

    move-result-wide v0

    return-wide v0
.end method

.method public final zzd(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Float;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzcy;

    const/4 v1, 0x5

    const/4 v2, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzcy;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eq p1, v2, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readFloat()F

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcy;->zzc(F)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_1

    return-void

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_0

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzu(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int v3, v1, p1

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readFloat()F

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzcy;->zzc(F)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v3, :cond_3

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eq v0, v2, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readFloat()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_6

    return-void

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_5

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzu(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->readFloat()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_8

    return-void
.end method

.method public final zzda()I
    .locals 2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    :goto_0
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznc:I

    if-ne v0, v1, :cond_1

    goto :goto_1

    :cond_1
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    ushr-int/lit8 v0, v0, 0x3

    return v0

    :cond_2
    :goto_1
    const v0, 0x7fffffff

    return v0
.end method

.method public final zzdb()Z
    .locals 2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-nez v0, :cond_1

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznc:I

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzn(I)Z

    move-result v0

    return v0

    :cond_1
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zze(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Long;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    const/4 v1, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eqz p1, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcd()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcd()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_2

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eqz v0, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcd()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_6

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcd()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_8

    return-void

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_7

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method public final zzf(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Long;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    const/4 v1, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eqz p1, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzce()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzce()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_2

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eqz v0, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzce()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_6

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzce()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_8

    return-void

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_7

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method public final zzg(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    const/4 v1, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eqz p1, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcf()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcf()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_2

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eqz v0, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcf()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_6

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcf()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_8

    return-void

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_7

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method public final zzh(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Long;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    if-eqz v0, :cond_3

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    packed-switch v0, :pswitch_data_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :pswitch_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzt(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcg()J

    move-result-wide v2

    invoke-virtual {p1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_0

    return-void

    :cond_1
    :pswitch_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcg()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_2

    return-void

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_3
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    packed-switch v0, :pswitch_data_1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :pswitch_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzt(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcg()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_4

    return-void

    :cond_5
    :pswitch_3
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcg()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_6

    return-void

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_5

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public final zzi(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    const/4 v1, 0x5

    const/4 v2, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eq p1, v2, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzch()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_1

    return-void

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_0

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzu(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int v3, v1, p1

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzch()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v3, :cond_3

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eq v0, v2, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzch()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_6

    return-void

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_5

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzu(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzch()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_8

    return-void
.end method

.method public final zzj(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzbs;

    const/4 v1, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzbs;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eqz p1, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzci()Z

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzbs;->addBoolean(Z)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzci()Z

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzbs;->addBoolean(Z)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_2

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eqz v0, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzci()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_6

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzci()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_8

    return-void

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_7

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method public final zzk(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zza(Ljava/util/List;Z)V

    return-void
.end method

.method public final zzl(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/google/android/gms/internal/firebase_auth/zzbu;",
            ">;)V"
        }
    .end annotation

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzck()Lcom/google/android/gms/internal/firebase_auth/zzbu;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method public final zzm(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    const/4 v1, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eqz p1, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_2

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eqz v0, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_6

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_8

    return-void

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_7

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method public final zzn(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    const/4 v1, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eqz p1, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcm()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcm()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_2

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eqz v0, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcm()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_6

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcm()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_8

    return-void

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_7

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method public final zzo(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    const/4 v1, 0x5

    const/4 v2, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eq p1, v2, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcn()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_1

    return-void

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_0

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzu(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int v3, v1, p1

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcn()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v3, :cond_3

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eq v0, v2, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcn()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_6

    return-void

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_5

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzu(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcn()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_8

    return-void
.end method

.method public final zzp(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Long;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    if-eqz v0, :cond_3

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    packed-switch v0, :pswitch_data_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :pswitch_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzt(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzco()J

    move-result-wide v2

    invoke-virtual {p1, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_0

    return-void

    :cond_1
    :pswitch_1
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzco()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_2

    return-void

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_3
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    packed-switch v0, :pswitch_data_1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :pswitch_2
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzt(I)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzco()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_4

    return-void

    :cond_5
    :pswitch_3
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzco()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_6

    return-void

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_5

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public final zzq(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    const/4 v1, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdc;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eqz p1, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcp()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcp()I

    move-result p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzdc;->zzal(I)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_2

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eqz v0, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcp()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_6

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcp()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_8

    return-void

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_7

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method

.method public final zzr(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Long;",
            ">;)V"
        }
    .end annotation

    instance-of v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    const/4 v1, 0x2

    if-eqz v0, :cond_4

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzdv;

    iget p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 p1, p1, 0x7

    if-eqz p1, :cond_2

    if-eq p1, v1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result p1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcq()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result p1

    if-lt p1, v1, :cond_1

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcq()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzdv;->zzl(J)V

    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    :cond_3
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result p1

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq p1, v1, :cond_2

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void

    :cond_4
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    and-int/lit8 v0, v0, 0x7

    if-eqz v0, :cond_7

    if-eq v0, v1, :cond_5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdh;->zzei()Lcom/google/android/gms/internal/firebase_auth/zzdi;

    move-result-object p1

    throw p1

    :cond_5
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcl()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v1

    add-int/2addr v1, v0

    :cond_6
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcq()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzct()I

    move-result v0

    if-lt v0, v1, :cond_6

    invoke-direct {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zzv(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcq()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcs()Z

    move-result v0

    if-eqz v0, :cond_8

    return-void

    :cond_8
    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznb:Lcom/google/android/gms/internal/firebase_auth/zzcd;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzcc()I

    move-result v0

    iget v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->tag:I

    if-eq v0, v1, :cond_7

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcg;->zznd:I

    return-void
.end method
