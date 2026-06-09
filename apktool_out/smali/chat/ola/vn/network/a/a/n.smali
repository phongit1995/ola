.class public Lchat/ola/vn/network/a/a/n;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Ljava/lang/Integer;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Lchat/ola/vn/p/q;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p4, p5}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-object p1, p0, Lchat/ola/vn/network/a/a/n;->f:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/network/a/a/n;->d:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/a/a/n;->e:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/n;->b([B)Ljava/lang/Integer;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/network/a/a/n;->f:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "responseCode"

    iget-object v2, p0, Lchat/ola/vn/network/a/a/n;->f:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/network/a/a/n;->d:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "purchaseData"

    iget-object v2, p0, Lchat/ola/vn/network/a/a/n;->d:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/network/a/a/n;->e:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "dataSignature"

    iget-object v2, p0, Lchat/ola/vn/network/a/a/n;->e:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    const-string v2, "pay/ginapp/commit"

    const/4 v3, 0x1

    invoke-static {v1, v2, v0, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Lchat/ola/vn/p/q;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/n;->c:Lchat/ola/vn/p/q;

    return-void
.end method

.method public a(Ljava/lang/Integer;)V
    .locals 3

    if-eqz p1, :cond_1

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    if-lez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/network/a/a/n;->g:Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/n;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/network/a/a/n;->c:Lchat/ola/vn/p/q;

    iget-object v0, p0, Lchat/ola/vn/network/a/a/n;->i:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/n;->h:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/n;->g:Ljava/lang/String;

    invoke-interface {p1, v0, v1, v2}, Lchat/ola/vn/p/q;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_1
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/n;->a(Ljava/lang/Integer;)V

    return-void
.end method

.method public b([B)Ljava/lang/Integer;
    .locals 3

    const/4 v0, -0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v2, "apiError"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1

    :cond_0
    const-string v0, "errorCode"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    const-string v1, "errorCode"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-object v1, v0

    :cond_1
    :goto_0
    :try_start_2
    const-string v0, "message"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "message"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/network/a/a/n;->g:Ljava/lang/String;

    :cond_2
    const-string v0, "purchaseToken"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "purchaseToken"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/network/a/a/n;->h:Ljava/lang/String;

    :cond_3
    const-string v0, "productId"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    const-string v0, "productId"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/network/a/a/n;->i:Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_4
    return-object v1
.end method

.method public b(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/n;->c:Lchat/ola/vn/p/q;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/n;->i:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/n;->h:Ljava/lang/String;

    invoke-interface {v0, v1, v2, p1}, Lchat/ola/vn/p/q;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
