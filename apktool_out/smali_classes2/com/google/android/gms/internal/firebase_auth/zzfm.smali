.class public final Lcom/google/android/gms/internal/firebase_auth/zzfm;
.super Lcom/google/android/gms/internal/firebase_auth/zzdb;

# interfaces
.implements Lcom/google/android/gms/internal/firebase_auth/zzej;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/android/gms/internal/firebase_auth/zzfm$zza;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzdb<",
        "Lcom/google/android/gms/internal/firebase_auth/zzfm;",
        "Lcom/google/android/gms/internal/firebase_auth/zzfm$zza;",
        ">;",
        "Lcom/google/android/gms/internal/firebase_auth/zzej;"
    }
.end annotation


# static fields
.field private static final zzuz:Lcom/google/android/gms/internal/firebase_auth/zzfm;

.field private static volatile zzva:Lcom/google/android/gms/internal/firebase_auth/zzer;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/internal/firebase_auth/zzer<",
            "Lcom/google/android/gms/internal/firebase_auth/zzfm;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private zzux:J

.field private zzuy:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzfm;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfm;-><init>()V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzuz:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzfm;

    sget-object v1, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzuz:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    invoke-static {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(Ljava/lang/Class;Lcom/google/android/gms/internal/firebase_auth/zzdb;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzdb;-><init>()V

    return-void
.end method

.method public static zzfw()Lcom/google/android/gms/internal/firebase_auth/zzer;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/android/gms/internal/firebase_auth/zzer<",
            "Lcom/google/android/gms/internal/firebase_auth/zzfm;",
            ">;"
        }
    .end annotation

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzuz:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    sget v1, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzrk:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v2}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzer;

    return-object v0
.end method

.method static synthetic zzfx()Lcom/google/android/gms/internal/firebase_auth/zzfm;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzuz:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    return-object v0
.end method


# virtual methods
.method protected final zza(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    sget-object p2, Lcom/google/android/gms/internal/firebase_auth/zzfn;->zzvb:[I

    const/4 p3, 0x1

    sub-int/2addr p1, p3

    aget p1, p2, p1

    const/4 p2, 0x0

    packed-switch p1, :pswitch_data_0

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1

    :pswitch_0
    return-object p2

    :pswitch_1
    invoke-static {p3}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object p1

    return-object p1

    :pswitch_2
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzva:Lcom/google/android/gms/internal/firebase_auth/zzer;

    if-nez p1, :cond_1

    const-class p2, Lcom/google/android/gms/internal/firebase_auth/zzfm;

    monitor-enter p2

    :try_start_0
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzva:Lcom/google/android/gms/internal/firebase_auth/zzer;

    if-nez p1, :cond_0

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzdb$zzb;

    sget-object p3, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzuz:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    invoke-direct {p1, p3}, Lcom/google/android/gms/internal/firebase_auth/zzdb$zzb;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzdb;)V

    sput-object p1, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzva:Lcom/google/android/gms/internal/firebase_auth/zzer;

    :cond_0
    monitor-exit p2

    return-object p1

    :catchall_0
    move-exception p1

    monitor-exit p2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_1
    return-object p1

    :pswitch_3
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzuz:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    return-object p1

    :pswitch_4
    const/4 p1, 0x2

    new-array p1, p1, [Ljava/lang/Object;

    const/4 p2, 0x0

    const-string v0, "zzux"

    aput-object v0, p1, p2

    const-string p2, "zzuy"

    aput-object p2, p1, p3

    const-string p2, "\u0000\u0002\u0000\u0000\u0001\u0002\u0002\u0000\u0000\u0000\u0001\u0002\u0002\u0004"

    sget-object p3, Lcom/google/android/gms/internal/firebase_auth/zzfm;->zzuz:Lcom/google/android/gms/internal/firebase_auth/zzfm;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzet;

    invoke-direct {v0, p3, p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzet;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzeh;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v0

    :pswitch_5
    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzfm$zza;

    invoke-direct {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfm$zza;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzfn;)V

    return-object p1

    :pswitch_6
    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzfm;

    invoke-direct {p1}, Lcom/google/android/gms/internal/firebase_auth/zzfm;-><init>()V

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
