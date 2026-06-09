.class public Lchat/ola/vn/network/a/a/aj;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/network/a/a/aj$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/z;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Lchat/ola/vn/network/a/a/aj$a;

.field private d:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lchat/ola/vn/network/a/a/aj$a;J)V
    .locals 0

    invoke-direct {p0, p3, p4}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-object p1, p0, Lchat/ola/vn/network/a/a/aj;->d:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/network/a/a/aj;->c:Lchat/ola/vn/network/a/a/aj$a;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/aj;->b([B)Lchat/ola/vn/entity/z;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    :try_start_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    const-string v1, "url"

    iget-object v2, p0, Lchat/ola/vn/network/a/a/aj;->d:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    const-string v2, "scrape/http/get"

    const/4 v3, 0x1

    invoke-static {v1, v2, v0, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/z;)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/aj;->c:Lchat/ola/vn/network/a/a/aj$a;

    invoke-interface {v0, p1}, Lchat/ola/vn/network/a/a/aj$a;->a(Lchat/ola/vn/entity/z;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/network/a/a/aj;->c:Lchat/ola/vn/network/a/a/aj$a;

    iget-object v0, p0, Lchat/ola/vn/network/a/a/aj;->d:Ljava/lang/String;

    invoke-interface {p1, v0}, Lchat/ola/vn/network/a/a/aj$a;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/z;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/aj;->a(Lchat/ola/vn/entity/z;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/z;
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v1, "site"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "site"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    const-string v2, "title"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v2, "title"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :cond_1
    move-object v2, v0

    :goto_1
    const-string v3, "desc"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "desc"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_2

    :cond_2
    move-object v3, v0

    :goto_2
    const-string v4, "image"

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    const-string v4, "image"

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_3

    :cond_3
    move-object v4, v0

    :goto_3
    const-string v5, "redirect"

    invoke-virtual {p1, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    const-string v5, "redirect"

    invoke-virtual {p1, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_4

    :cond_4
    move-object p1, v0

    :goto_4
    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    return-object v0

    :cond_5
    new-instance v5, Lchat/ola/vn/entity/z;

    invoke-direct {v5}, Lchat/ola/vn/entity/z;-><init>()V

    iput-object v1, v5, Lchat/ola/vn/entity/z;->d:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/aj;->d:Ljava/lang/String;

    iput-object v1, v5, Lchat/ola/vn/entity/z;->a:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/aj;->d:Ljava/lang/String;

    iput-object v1, v5, Lchat/ola/vn/entity/z;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    iput-object p1, v5, Lchat/ola/vn/entity/z;->b:Ljava/lang/String;

    :cond_6
    iput-object v2, v5, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    iput-object v3, v5, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    iput-object v4, v5, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v5

    :catch_0
    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/network/a/a/aj;->c:Lchat/ola/vn/network/a/a/aj$a;

    iget-object v0, p0, Lchat/ola/vn/network/a/a/aj;->d:Ljava/lang/String;

    invoke-interface {p1, v0}, Lchat/ola/vn/network/a/a/aj$a;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
