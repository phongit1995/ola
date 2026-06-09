.class public Lchat/ola/vn/network/a/a/ag;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/q;",
        ">;"
    }
.end annotation


# instance fields
.field public c:Ljava/lang/String;

.field public d:Ljava/lang/String;

.field public e:S


# direct methods
.method public constructor <init>(J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ag;->c:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ag;->d:Ljava/lang/String;

    const/4 p1, 0x0

    iput-short p1, p0, Lchat/ola/vn/network/a/a/ag;->e:S

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ag;->b([B)Lchat/ola/vn/entity/q;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    :try_start_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    const-string v1, "act"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-short v3, p0, Lchat/ola/vn/network/a/a/ag;->e:S

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "like/act/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/network/a/a/ag;->c:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/network/a/a/ag;->d:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

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

.method public a(Lchat/ola/vn/entity/q;)V
    .locals 0

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/q;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ag;->a(Lchat/ola/vn/entity/q;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/q;
    .locals 5

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/entity/q;

    invoke-direct {v0}, Lchat/ola/vn/entity/q;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ag;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/q;->b:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ag;->c:Ljava/lang/String;

    const-string v2, "me"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ag;->d:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/q;->c:Ljava/lang/String;

    const-string v1, "1"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "1"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    iput v1, v0, Lchat/ola/vn/entity/q;->d:I

    :cond_0
    const-string v1, "2"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "2"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    iput v1, v0, Lchat/ola/vn/entity/q;->e:I

    :cond_1
    const-string v1, "liked"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "liked"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    int-to-short v1, v1

    iput-short v1, v0, Lchat/ola/vn/entity/q;->f:S

    :cond_2
    const-string v1, "likers"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    const-string v1, "likers"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_3

    new-array v2, v1, [Ljava/lang/String;

    iput-object v2, v0, Lchat/ola/vn/entity/q;->a:[Ljava/lang/String;

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_3

    iget-object v3, v0, Lchat/ola/vn/entity/q;->a:[Ljava/lang/String;

    invoke-virtual {p1, v2}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_3
    invoke-static {v0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entity/q;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_4
    :goto_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method
