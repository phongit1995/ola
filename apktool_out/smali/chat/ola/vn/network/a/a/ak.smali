.class public Lchat/ola/vn/network/a/a/ak;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Ljava/lang/String;


# direct methods
.method public constructor <init>(J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ak;->c:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ak;->c:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ak;->b([B)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/network/a/a/ak;->c:Ljava/lang/String;

    const-string v1, "id/signoutall"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ak;->a(Ljava/lang/Void;)V

    return-void
.end method

.method public a(Ljava/lang/Void;)V
    .locals 0

    :try_start_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->k()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b([B)Ljava/lang/Void;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method
