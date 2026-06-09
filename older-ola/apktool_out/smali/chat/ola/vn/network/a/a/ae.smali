.class public Lchat/ola/vn/network/a/a/ae;
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
.field public c:Lchat/ola/vn/p/k;


# direct methods
.method public constructor <init>(J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entity/m;-><init>(J)V

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ae;->b([B)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    const-string v0, "id/activehit"

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-static {v1, v0, v2, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ae;->a(Ljava/lang/Void;)V

    return-void
.end method

.method public a(Ljava/lang/Void;)V
    .locals 0

    return-void
.end method

.method public b([B)Ljava/lang/Void;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/network/a/a/ae;->c:Lchat/ola/vn/p/k;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/network/a/a/ae;->c:Lchat/ola/vn/p/k;

    invoke-interface {p1}, Lchat/ola/vn/p/k;->a()V

    :cond_0
    return-void
.end method
