.class public Lchat/ola/vn/network/a/a/v;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/p;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Lchat/ola/vn/p/q;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p3, p4}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-object p2, p0, Lchat/ola/vn/network/a/a/v;->d:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/network/a/a/v;->e:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/v;->b([B)Lchat/ola/vn/entity/p;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "pay/ginapp/payload?packageName="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/v;->e:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "&productId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/v;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/p;)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/v;->c:Lchat/ola/vn/p/q;

    invoke-interface {v0, p1}, Lchat/ola/vn/p/q;->a(Lchat/ola/vn/entity/p;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/v;->b(Ljava/lang/String;)V

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/p/q;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/v;->c:Lchat/ola/vn/p/q;

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/p;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/v;->a(Lchat/ola/vn/entity/p;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/p;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const/4 v1, 0x0

    const-string v2, "apiError"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v0

    :cond_0
    const-string v2, "errorCode"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v2, :cond_1

    :try_start_1
    const-string v2, "errorCode"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move v1, v2

    :catch_0
    :cond_1
    if-nez v1, :cond_2

    :try_start_2
    const-string v1, "productId"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "productId"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "payload"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "payload"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance v2, Lchat/ola/vn/entity/p;

    invoke-direct {v2}, Lchat/ola/vn/entity/p;-><init>()V

    iput-object p1, v2, Lchat/ola/vn/entity/p;->e:Ljava/lang/String;

    iput-object v1, v2, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-object v2

    :catch_1
    :cond_2
    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/network/a/a/v;->c:Lchat/ola/vn/p/q;

    invoke-interface {p1}, Lchat/ola/vn/p/q;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
