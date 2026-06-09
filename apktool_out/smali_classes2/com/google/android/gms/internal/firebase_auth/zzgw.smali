.class public final Lcom/google/android/gms/internal/firebase_auth/zzgw;
.super Ljava/lang/Object;


# static fields
.field public static final EMPTY_STRING_ARRAY:[Ljava/lang/String;

.field public static final zzti:[I

.field private static final zzyb:I = 0xb

.field private static final zzyc:I = 0xc

.field private static final zzyd:I = 0x10

.field private static final zzye:I = 0x1a

.field private static final zzyf:[J

.field private static final zzyg:[F

.field private static final zzyh:[D

.field private static final zzyi:[Z

.field private static final zzyj:[[B

.field public static final zzyk:[B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v0, 0x0

    new-array v1, v0, [I

    sput-object v1, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzti:[I

    new-array v1, v0, [J

    sput-object v1, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyf:[J

    new-array v1, v0, [F

    sput-object v1, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyg:[F

    new-array v1, v0, [D

    sput-object v1, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyh:[D

    new-array v1, v0, [Z

    sput-object v1, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyi:[Z

    new-array v1, v0, [Ljava/lang/String;

    sput-object v1, Lcom/google/android/gms/internal/firebase_auth/zzgw;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    new-array v1, v0, [[B

    sput-object v1, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyj:[[B

    new-array v0, v0, [B

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzyk:[B

    return-void
.end method

.method public static final zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I
    .locals 3

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->getPosition()I

    move-result v0

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzn(I)Z

    const/4 v1, 0x1

    :goto_0
    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    move-result v2

    if-ne v2, p1, :cond_0

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzn(I)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzs(II)V

    return v1
.end method
