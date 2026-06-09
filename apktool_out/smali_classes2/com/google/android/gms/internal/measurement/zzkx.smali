.class public final Lcom/google/android/gms/internal/measurement/zzkx;
.super Lcom/google/android/gms/internal/measurement/zzacd;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/measurement/zzacd<",
        "Lcom/google/android/gms/internal/measurement/zzkx;",
        ">;"
    }
.end annotation


# static fields
.field private static volatile zzawr:[Lcom/google/android/gms/internal/measurement/zzkx;


# instance fields
.field public name:Ljava/lang/String;

.field public zzale:Ljava/lang/String;

.field private zzasv:Ljava/lang/Float;

.field public zzasw:Ljava/lang/Double;

.field public zzave:Ljava/lang/Long;

.field public zzaws:Ljava/lang/Long;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/google/android/gms/internal/measurement/zzacd;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzo:I

    return-void
.end method

.method public static zzmc()[Lcom/google/android/gms/internal/measurement/zzkx;
    .locals 2

    sget-object v0, Lcom/google/android/gms/internal/measurement/zzkx;->zzawr:[Lcom/google/android/gms/internal/measurement/zzkx;

    if-nez v0, :cond_1

    sget-object v0, Lcom/google/android/gms/internal/measurement/zzach;->zzbzn:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/google/android/gms/internal/measurement/zzkx;->zzawr:[Lcom/google/android/gms/internal/measurement/zzkx;

    if-nez v1, :cond_0

    const/4 v1, 0x0

    new-array v1, v1, [Lcom/google/android/gms/internal/measurement/zzkx;

    sput-object v1, Lcom/google/android/gms/internal/measurement/zzkx;->zzawr:[Lcom/google/android/gms/internal/measurement/zzkx;

    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    :cond_1
    :goto_0
    sget-object v0, Lcom/google/android/gms/internal/measurement/zzkx;->zzawr:[Lcom/google/android/gms/internal/measurement/zzkx;

    return-object v0
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/google/android/gms/internal/measurement/zzkx;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    check-cast p1, Lcom/google/android/gms/internal/measurement/zzkx;

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    if-nez v1, :cond_2

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    if-eqz v1, :cond_3

    return v2

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    invoke-virtual {v1, v3}, Ljava/lang/Long;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    return v2

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    if-nez v1, :cond_4

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    if-eqz v1, :cond_5

    return v2

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    return v2

    :cond_5
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    if-nez v1, :cond_6

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    if-eqz v1, :cond_7

    return v2

    :cond_6
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    return v2

    :cond_7
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    if-nez v1, :cond_8

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    if-eqz v1, :cond_9

    return v2

    :cond_8
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    invoke-virtual {v1, v3}, Ljava/lang/Long;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    return v2

    :cond_9
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    if-nez v1, :cond_a

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    if-eqz v1, :cond_b

    return v2

    :cond_a
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    invoke-virtual {v1, v3}, Ljava/lang/Float;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    return v2

    :cond_b
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    if-nez v1, :cond_c

    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    if-eqz v1, :cond_d

    return v2

    :cond_c
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    iget-object v3, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    invoke-virtual {v1, v3}, Ljava/lang/Double;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    return v2

    :cond_d
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    if-eqz v1, :cond_f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/measurement/zzacf;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_e

    goto :goto_0

    :cond_e
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    iget-object p1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/measurement/zzacf;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_f
    :goto_0
    iget-object v1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    if-eqz v1, :cond_11

    iget-object p1, p1, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzacf;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_10

    return v0

    :cond_10
    return v2

    :cond_11
    return v0
.end method

.method public final hashCode()I
    .locals 3

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    add-int/lit16 v0, v0, 0x20f

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    const/4 v2, 0x0

    if-nez v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->hashCode()I

    move-result v1

    :goto_0
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    if-nez v1, :cond_1

    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    :goto_1
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    if-nez v1, :cond_2

    const/4 v1, 0x0

    goto :goto_2

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    :goto_2
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    if-nez v1, :cond_3

    const/4 v1, 0x0

    goto :goto_3

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->hashCode()I

    move-result v1

    :goto_3
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    if-nez v1, :cond_4

    const/4 v1, 0x0

    goto :goto_4

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->hashCode()I

    move-result v1

    :goto_4
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    if-nez v1, :cond_5

    const/4 v1, 0x0

    goto :goto_5

    :cond_5
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    invoke-virtual {v1}, Ljava/lang/Double;->hashCode()I

    move-result v1

    :goto_5
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    if-eqz v1, :cond_7

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/measurement/zzacf;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_6

    goto :goto_6

    :cond_6
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzbzd:Lcom/google/android/gms/internal/measurement/zzacf;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/measurement/zzacf;->hashCode()I

    move-result v2

    :cond_7
    :goto_6
    add-int/2addr v0, v2

    return v0
.end method

.method protected final zza()I
    .locals 5

    invoke-super {p0}, Lcom/google/android/gms/internal/measurement/zzacd;->zza()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-static {v1, v2, v3}, Lcom/google/android/gms/internal/measurement/zzacb;->zzc(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_0
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    if-eqz v1, :cond_1

    const/4 v1, 0x2

    iget-object v2, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/measurement/zzacb;->zzc(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_1
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    if-eqz v1, :cond_2

    const/4 v1, 0x3

    iget-object v2, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/google/android/gms/internal/measurement/zzacb;->zzc(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    const/4 v2, 0x4

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    invoke-static {v2, v3, v4}, Lcom/google/android/gms/internal/measurement/zzacb;->zzc(IJ)I

    move-result v1

    add-int/2addr v0, v1

    :cond_3
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    if-eqz v1, :cond_4

    const/4 v1, 0x5

    iget-object v3, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    invoke-static {v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzaq(I)I

    move-result v1

    add-int/2addr v1, v2

    add-int/2addr v0, v1

    :cond_4
    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    if-eqz v1, :cond_5

    const/4 v1, 0x6

    iget-object v2, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    invoke-virtual {v2}, Ljava/lang/Double;->doubleValue()D

    invoke-static {v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzaq(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    :cond_5
    return v0
.end method

.method public final zza(Lcom/google/android/gms/internal/measurement/zzacb;)V
    .locals 3

    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/measurement/zzacb;->zzb(IJ)V

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    if-eqz v0, :cond_1

    const/4 v0, 0x2

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzb(ILjava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    if-eqz v0, :cond_2

    const/4 v0, 0x3

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zzb(ILjava/lang/String;)V

    :cond_2
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    if-eqz v0, :cond_3

    const/4 v0, 0x4

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/measurement/zzacb;->zzb(IJ)V

    :cond_3
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    if-eqz v0, :cond_4

    const/4 v0, 0x5

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/internal/measurement/zzacb;->zza(IF)V

    :cond_4
    iget-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    if-eqz v0, :cond_5

    const/4 v0, 0x6

    iget-object v1, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    invoke-virtual {v1}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v1

    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/internal/measurement/zzacb;->zza(ID)V

    :cond_5
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/measurement/zzacd;->zza(Lcom/google/android/gms/internal/measurement/zzacb;)V

    return-void
.end method

.method public final synthetic zzb(Lcom/google/android/gms/internal/measurement/zzaca;)Lcom/google/android/gms/internal/measurement/zzacj;
    .locals 2

    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvl()I

    move-result v0

    if-eqz v0, :cond_7

    const/16 v1, 0x8

    if-eq v0, v1, :cond_6

    const/16 v1, 0x12

    if-eq v0, v1, :cond_5

    const/16 v1, 0x1a

    if-eq v0, v1, :cond_4

    const/16 v1, 0x20

    if-eq v0, v1, :cond_3

    const/16 v1, 0x2d

    if-eq v0, v1, :cond_2

    const/16 v1, 0x31

    if-eq v0, v1, :cond_1

    invoke-super {p0, p1, v0}, Lcom/google/android/gms/internal/measurement/zzacd;->zza(Lcom/google/android/gms/internal/measurement/zzaca;I)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :cond_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvq()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->longBitsToDouble(J)D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasw:Ljava/lang/Double;

    goto :goto_0

    :cond_2
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvp()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzasv:Ljava/lang/Float;

    goto :goto_0

    :cond_3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvo()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzave:Ljava/lang/Long;

    goto :goto_0

    :cond_4
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzale:Ljava/lang/String;

    goto :goto_0

    :cond_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->name:Ljava/lang/String;

    goto :goto_0

    :cond_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/measurement/zzaca;->zzvo()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/measurement/zzkx;->zzaws:Ljava/lang/Long;

    goto :goto_0

    :cond_7
    return-object p0
.end method
