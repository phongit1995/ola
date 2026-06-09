.class public final enum Lcom/google/android/gms/internal/firebase_auth/zzae;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/google/android/gms/internal/firebase_auth/zzae;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum zzjj:Lcom/google/android/gms/internal/firebase_auth/zzae;

.field private static final enum zzjk:Lcom/google/android/gms/internal/firebase_auth/zzae;

.field private static final synthetic zzjl:[Lcom/google/android/gms/internal/firebase_auth/zzae;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzae;

    const-string v1, "REFRESH_TOKEN"

    const-string v2, "refresh_token"

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzae;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzae;->zzjj:Lcom/google/android/gms/internal/firebase_auth/zzae;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzae;

    const-string v1, "AUTHORIZATION_CODE"

    const-string v2, "authorization_code"

    const/4 v4, 0x1

    invoke-direct {v0, v1, v4, v2}, Lcom/google/android/gms/internal/firebase_auth/zzae;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzae;->zzjk:Lcom/google/android/gms/internal/firebase_auth/zzae;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/google/android/gms/internal/firebase_auth/zzae;

    sget-object v1, Lcom/google/android/gms/internal/firebase_auth/zzae;->zzjj:Lcom/google/android/gms/internal/firebase_auth/zzae;

    aput-object v1, v0, v3

    sget-object v1, Lcom/google/android/gms/internal/firebase_auth/zzae;->zzjk:Lcom/google/android/gms/internal/firebase_auth/zzae;

    aput-object v1, v0, v4

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzae;->zzjl:[Lcom/google/android/gms/internal/firebase_auth/zzae;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/google/android/gms/internal/firebase_auth/zzae;->value:Ljava/lang/String;

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/firebase_auth/zzae;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzae;->zzjl:[Lcom/google/android/gms/internal/firebase_auth/zzae;

    invoke-virtual {v0}, [Lcom/google/android/gms/internal/firebase_auth/zzae;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/firebase_auth/zzae;

    return-object v0
.end method


# virtual methods
.method public final toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzae;->value:Ljava/lang/String;

    return-object v0
.end method
