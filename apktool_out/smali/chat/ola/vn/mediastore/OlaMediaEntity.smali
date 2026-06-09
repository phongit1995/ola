.class public Lchat/ola/vn/mediastore/OlaMediaEntity;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lchat/ola/vn/mediastore/OlaMediaEntity;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private a:I

.field private b:Ljava/lang/String;

.field private c:S

.field private d:Z

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lchat/ola/vn/mediastore/OlaMediaEntity$1;

    invoke-direct {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity$1;-><init>()V

    sput-object v0, Lchat/ola/vn/mediastore/OlaMediaEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->d:Z

    if-eqz p1, :cond_0

    :try_start_0
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->a:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->b:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    int-to-short v0, v0

    iput-short v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->c:S

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->d:Z

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->e:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->f:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->g:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;IS)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->d:Z

    iput p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->a:I

    iput-object p1, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->b:Ljava/lang/String;

    iput-short p3, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->c:S

    return-void
.end method

.method public static varargs a(ISZ[Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ISZ[",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/OlaMediaEntity;",
            ">;"
        }
    .end annotation

    if-eqz p3, :cond_0

    array-length v0, p3

    if-eqz v0, :cond_0

    invoke-static {p3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p3

    invoke-static {p3, p0, p1, p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Ljava/util/List;ISZ)Ljava/util/ArrayList;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static varargs a(IS[Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(IS[",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/OlaMediaEntity;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x1

    invoke-static {p0, p1, v0, p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(ISZ[Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/util/List;)Ljava/util/ArrayList;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/OlaMediaEntity;",
            ">;"
        }
    .end annotation

    if-eqz p0, :cond_3

    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_1
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Lchat/ola/vn/mediastore/OlaMediaEntity;

    const/4 v3, 0x1

    invoke-static {v1}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v4

    invoke-direct {v2, v1, v3, v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    return-object v0

    :cond_3
    :goto_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static a(Ljava/util/List;ISZ)Ljava/util/ArrayList;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;ISZ)",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/OlaMediaEntity;",
            ">;"
        }
    .end annotation

    if-eqz p0, :cond_3

    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_1
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-direct {v2, v1, p1, p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    invoke-virtual {v2, p3}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Z)V

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    return-object v0

    :cond_3
    :goto_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static varargs a([Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/OlaMediaEntity;",
            ">;"
        }
    .end annotation

    invoke-static {p0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->a:I

    return v0
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->e:Ljava/lang/String;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->d:Z

    return-void
.end method

.method public b()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->c:S

    return v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->f:Ljava/lang/String;

    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->b:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->g:Ljava/lang/String;

    return-void
.end method

.method public d()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->d:Z

    return v0
.end method

.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    check-cast p1, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget v1, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->a:I

    iget v2, p1, Lchat/ola/vn/mediastore/OlaMediaEntity;->a:I

    if-ne v1, v2, :cond_1

    iget-short v1, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->c:S

    iget-short v2, p1, Lchat/ola/vn/mediastore/OlaMediaEntity;->c:S

    if-ne v1, v2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->b:Ljava/lang/String;

    iget-object p1, p1, Lchat/ola/vn/mediastore/OlaMediaEntity;->b:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    return p1

    :cond_1
    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0

    if-eqz p1, :cond_3

    iget p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->a:I

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->b:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-short p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->c:S

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-boolean p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->d:Z

    invoke-static {p2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->e:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->e:Ljava/lang/String;

    :goto_0
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    const-string p2, ""

    goto :goto_0

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->f:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->f:Ljava/lang/String;

    :goto_2
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_3

    :cond_1
    const-string p2, ""

    goto :goto_2

    :goto_3
    iget-object p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->g:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/mediastore/OlaMediaEntity;->g:Ljava/lang/String;

    :goto_4
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void

    :cond_2
    const-string p2, ""

    goto :goto_4

    :cond_3
    return-void
.end method
