.class final Lchat/ola/vn/entry/VideoEntry$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/entry/VideoEntry;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator<",
        "Lchat/ola/vn/entry/VideoEntry;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/os/Parcel;)Lchat/ola/vn/entry/VideoEntry;
    .locals 1

    new-instance v0, Lchat/ola/vn/entry/VideoEntry;

    invoke-direct {v0, p1}, Lchat/ola/vn/entry/VideoEntry;-><init>(Landroid/os/Parcel;)V

    return-object v0
.end method

.method public a(I)[Lchat/ola/vn/entry/VideoEntry;
    .locals 0

    new-array p1, p1, [Lchat/ola/vn/entry/VideoEntry;

    return-object p1
.end method

.method public synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/entry/VideoEntry$1;->a(Landroid/os/Parcel;)Lchat/ola/vn/entry/VideoEntry;

    move-result-object p1

    return-object p1
.end method

.method public synthetic newArray(I)[Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/entry/VideoEntry$1;->a(I)[Lchat/ola/vn/entry/VideoEntry;

    move-result-object p1

    return-object p1
.end method
