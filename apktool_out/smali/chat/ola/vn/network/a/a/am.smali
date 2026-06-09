.class public Lchat/ola/vn/network/a/a/am;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field public c:Lchat/ola/vn/p/p;


# direct methods
.method public constructor <init>(J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entity/m;-><init>(J)V

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/am;->b([B)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 5

    const-string v0, "id/authweb"

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    const-string v2, "did"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v4, Lchat/ola/vn/h;->g:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x1

    invoke-static {v2, v0, v1, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/am;->c(Ljava/lang/String;)V

    return-void
.end method

.method public b([B)Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "url"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "url"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/network/a/a/am;->c:Lchat/ola/vn/p/p;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/network/a/a/am;->c:Lchat/ola/vn/p/p;

    invoke-interface {p1}, Lchat/ola/vn/p/p;->a()V

    :cond_0
    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/a/a/am;->c:Lchat/ola/vn/p/p;

    invoke-interface {v0, p1}, Lchat/ola/vn/p/p;->a(Ljava/lang/String;)V

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/am;->b(Ljava/lang/String;)V

    return-void
.end method
