.class public abstract Lcom/google/android/gms/internal/firebase_auth/zzcd;
.super Ljava/lang/Object;


# static fields
.field private static volatile zzmv:Z = false


# instance fields
.field zzmq:I

.field zzmr:I

.field private zzms:I

.field zzmt:Lcom/google/android/gms/internal/firebase_auth/zzcg;

.field private zzmu:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x64

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmr:I

    const v0, 0x7fffffff

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzms:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmu:Z

    return-void
.end method

.method synthetic constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzce;)V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;-><init>()V

    return-void
.end method

.method static zza([BIIZ)Lcom/google/android/gms/internal/firebase_auth/zzcd;
    .locals 6

    new-instance p3, Lcom/google/android/gms/internal/firebase_auth/zzcf;

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p3

    move-object v1, p0

    move v2, p1

    move v3, p2

    invoke-direct/range {v0 .. v5}, Lcom/google/android/gms/internal/firebase_auth/zzcf;-><init>([BIIZLcom/google/android/gms/internal/firebase_auth/zzce;)V

    :try_start_0
    invoke-virtual {p3, p2}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzp(I)I
    :try_end_0
    .catch Lcom/google/android/gms/internal/firebase_auth/zzdh; {:try_start_0 .. :try_end_0} :catch_0

    return-object p3

    :catch_0
    move-exception p0

    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/Throwable;)V

    throw p1
.end method

.method public static zzd([BII)Lcom/google/android/gms/internal/firebase_auth/zzcd;
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zza([BIIZ)Lcom/google/android/gms/internal/firebase_auth/zzcd;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public abstract readDouble()D
.end method

.method public abstract readFloat()F
.end method

.method public abstract readString()Ljava/lang/String;
.end method

.method public abstract zza(Lcom/google/android/gms/internal/firebase_auth/zzer;Lcom/google/android/gms/internal/firebase_auth/zzco;)Lcom/google/android/gms/internal/firebase_auth/zzeh;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T::",
            "Lcom/google/android/gms/internal/firebase_auth/zzeh;",
            ">(",
            "Lcom/google/android/gms/internal/firebase_auth/zzer<",
            "TT;>;",
            "Lcom/google/android/gms/internal/firebase_auth/zzco;",
            ")TT;"
        }
    .end annotation
.end method

.method public abstract zzcc()I
.end method

.method public abstract zzcd()J
.end method

.method public abstract zzce()J
.end method

.method public abstract zzcf()I
.end method

.method public abstract zzcg()J
.end method

.method public abstract zzch()I
.end method

.method public abstract zzci()Z
.end method

.method public abstract zzcj()Ljava/lang/String;
.end method

.method public abstract zzck()Lcom/google/android/gms/internal/firebase_auth/zzbu;
.end method

.method public abstract zzcl()I
.end method

.method public abstract zzcm()I
.end method

.method public abstract zzcn()I
.end method

.method public abstract zzco()J
.end method

.method public abstract zzcp()I
.end method

.method public abstract zzcq()J
.end method

.method abstract zzcr()J
.end method

.method public abstract zzcs()Z
.end method

.method public abstract zzct()I
.end method

.method public abstract zzm(I)V
.end method

.method public abstract zzn(I)Z
.end method

.method public final zzo(I)I
    .locals 3

    if-gez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const/16 v1, 0x2f

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v1, "Recursion limit cannot be negative: "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmr:I

    iput p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzcd;->zzmr:I

    return v0
.end method

.method public abstract zzp(I)I
.end method

.method public abstract zzq(I)V
.end method

.method public abstract zzr(I)V
.end method
