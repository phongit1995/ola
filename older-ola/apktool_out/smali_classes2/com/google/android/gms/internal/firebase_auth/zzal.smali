.class public final Lcom/google/android/gms/internal/firebase_auth/zzal;
.super Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;


# annotations
.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "GetAccountInfoUserListCreator"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Reserved;
    value = {
        0x1
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/internal/firebase_auth/zzal;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private zzjv:Ljava/util/List;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getUsers"
        id = 0x2
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/google/android/gms/internal/firebase_auth/zzaj;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzam;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzam;-><init>()V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzal;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzal;->zzjv:Ljava/util/List;

    return-void
.end method

.method constructor <init>(Ljava/util/List;)V
    .locals 0
    .param p1    # Ljava/util/List;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/google/android/gms/internal/firebase_auth/zzaj;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    if-nez p1, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object p1

    goto :goto_0

    :cond_0
    invoke-static {p1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzal;->zzjv:Ljava/util/List;

    return-void
.end method

.method public static zza(Lcom/google/android/gms/internal/firebase_auth/zzal;)Lcom/google/android/gms/internal/firebase_auth/zzal;
    .locals 2

    iget-object p0, p0, Lcom/google/android/gms/internal/firebase_auth/zzal;->zzjv:Ljava/util/List;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzal;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzal;-><init>()V

    if-eqz p0, :cond_0

    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzal;->zzjv:Ljava/util/List;

    invoke-interface {v1, p0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_0
    return-object v0
.end method

.method public static zza(Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;)Lcom/google/android/gms/internal/firebase_auth/zzal;
    .locals 21

    move-object/from16 v0, p0

    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, v0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    array-length v2, v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v2, 0x0

    :goto_0
    iget-object v3, v0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    array-length v3, v3

    if-ge v2, v3, :cond_0

    iget-object v3, v0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    aget-object v3, v3, v2

    new-instance v15, Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iget-object v4, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzad:Ljava/lang/String;

    invoke-static {v4}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iget-object v4, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzah:Ljava/lang/String;

    invoke-static {v4}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iget-boolean v7, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbk:Z

    iget-object v4, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbh:Ljava/lang/String;

    invoke-static {v4}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    iget-object v4, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbr:Ljava/lang/String;

    invoke-static {v4}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    iget-object v4, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbx:[Lcom/google/android/gms/internal/firebase_auth/zzt;

    invoke-static {v4}, Lcom/google/android/gms/internal/firebase_auth/zzas;->zza([Lcom/google/android/gms/internal/firebase_auth/zzt;)Lcom/google/android/gms/internal/firebase_auth/zzas;

    move-result-object v10

    iget-object v4, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzdr:Ljava/lang/String;

    invoke-static {v4}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    iget-object v4, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbd:Ljava/lang/String;

    invoke-static {v4}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    iget-wide v13, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbw:J

    iget-wide v3, v3, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzbv:J

    const/16 v17, 0x0

    const/16 v18, 0x0

    move-wide/from16 v19, v3

    move-object v4, v15

    move-object v3, v15

    move-wide/from16 v15, v19

    invoke-direct/range {v4 .. v18}, Lcom/google/android/gms/internal/firebase_auth/zzaj;-><init>(Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Lcom/google/android/gms/internal/firebase_auth/zzas;Ljava/lang/String;Ljava/lang/String;JJZLcom/google/firebase/auth/zzd;)V

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzal;

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzal;-><init>(Ljava/util/List;)V

    return-object v0
.end method


# virtual methods
.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 3

    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result p2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzal;->zzjv:Ljava/util/List;

    const/4 v1, 0x2

    const/4 v2, 0x0

    invoke-static {p1, v1, v0, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeTypedList(Landroid/os/Parcel;ILjava/util/List;Z)V

    invoke-static {p1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final zzas()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/google/android/gms/internal/firebase_auth/zzaj;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzal;->zzjv:Ljava/util/List;

    return-object v0
.end method
