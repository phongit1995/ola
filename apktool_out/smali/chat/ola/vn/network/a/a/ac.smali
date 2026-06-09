.class public Lchat/ola/vn/network/a/a/ac;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/ai;",
        ">;"
    }
.end annotation


# instance fields
.field public c:Lchat/ola/vn/p/o;

.field private d:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ac;->d:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ac;->b([B)Lchat/ola/vn/entity/ai;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/network/a/a/ac;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mall/yt?id="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/network/a/a/ac;->d:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x1

    invoke-static {v0, v2, v1, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    return-object v1
.end method

.method public a(Lchat/ola/vn/entity/ai;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/a/a/ac;->c:Lchat/ola/vn/p/o;

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/a/a/ac;->c:Lchat/ola/vn/p/o;

    invoke-interface {v0, p1}, Lchat/ola/vn/p/o;->a(Lchat/ola/vn/entity/ai;)V

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ac;->b(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/ai;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ac;->a(Lchat/ola/vn/entity/ai;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/ai;
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    new-instance v1, Lchat/ola/vn/entity/ai;

    invoke-direct {v1}, Lchat/ola/vn/entity/ai;-><init>()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/network/a/a/ac;->d:Ljava/lang/String;

    iput-object v0, v1, Lchat/ola/vn/entity/ai;->c:Ljava/lang/String;

    const-string v0, "payload"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "title"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "title"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    :cond_0
    const-string v0, "duration"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "duration"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, v1, Lchat/ola/vn/entity/ai;->e:I

    iget v0, v1, Lchat/ola/vn/entity/ai;->e:I

    int-to-long v2, v0

    const-string v0, ":"

    const-string v4, ":"

    invoke-static {v2, v3, v0, v4}, Lcom/mg/ola/common/d/i;->a(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ai;->d:Ljava/lang/String;

    :cond_1
    const-string v0, "hqThumbnailUrl"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "hqThumbnailUrl"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/entity/ai;->b:Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_0
    move-object v1, v0

    :catch_1
    :cond_2
    :goto_0
    move-object v0, v1

    :catch_2
    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/network/a/a/ac;->c:Lchat/ola/vn/p/o;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/network/a/a/ac;->c:Lchat/ola/vn/p/o;

    invoke-interface {p1}, Lchat/ola/vn/p/o;->a()V

    :cond_0
    return-void
.end method
