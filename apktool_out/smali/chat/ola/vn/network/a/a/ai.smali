.class public Lchat/ola/vn/network/a/a/ai;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/network/a/a/ai$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Lchat/ola/vn/network/a/a/ai$a;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p3, p4}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ai;->d:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/network/a/a/ai;->c:Ljava/lang/String;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/network/a/a/ai;->b:Z

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ai;->b([B)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    const-string v2, "kitToken"

    iget-object v3, p0, Lchat/ola/vn/network/a/a/ai;->c:Ljava/lang/String;

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v2, "gameCode"

    const-string v3, "ola.acckit"

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v2, "act"

    const-string v3, "resetpass"

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v2, "nick"

    iget-object v3, p0, Lchat/ola/vn/network/a/a/ai;->d:Ljava/lang/String;

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v2, "player/member/acckit"

    const/4 v3, 0x0

    invoke-static {v0, v2, v1, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    return-object v0
.end method

.method public a(Lchat/ola/vn/network/a/a/ai$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ai;->e:Lchat/ola/vn/network/a/a/ai$a;

    return-void
.end method

.method public synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ai;->c(Ljava/lang/String;)V

    return-void
.end method

.method public b([B)Ljava/lang/String;
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const/4 v0, 0x0

    const-string v1, "error"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "error"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    :cond_0
    if-nez v0, :cond_1

    const-string v0, "pass"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "pass"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/a/a/ai;->e:Lchat/ola/vn/network/a/a/ai$a;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ai;->d:Ljava/lang/String;

    invoke-interface {v0, v1, p1}, Lchat/ola/vn/network/a/a/ai$a;->a_(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/network/a/a/ai;->e:Lchat/ola/vn/network/a/a/ai$a;

    invoke-interface {p1}, Lchat/ola/vn/network/a/a/ai$a;->c_()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
