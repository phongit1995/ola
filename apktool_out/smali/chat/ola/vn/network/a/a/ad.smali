.class public Lchat/ola/vn/network/a/a/ad;
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

.field public d:[Ljava/lang/String;


# direct methods
.method public constructor <init>(J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ad;->c:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ad;->b([B)Lchat/ola/vn/entity/q;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    :try_start_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    if-eqz v2, :cond_1

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    array-length v3, v3

    if-ge v2, v3, :cond_0

    iget-object v3, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    aget-object v3, v3, v2

    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "ids"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "like/gets/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/network/a/a/ad;->c:Ljava/lang/String;

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ad;->a(Lchat/ola/vn/entity/q;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/q;
    .locals 10

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    if-eqz v1, :cond_7

    const/4 v1, 0x0

    move-object v3, v0

    const/4 v2, 0x0

    :goto_0
    iget-object v4, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    array-length v4, v4

    if-ge v2, v4, :cond_6

    iget-object v4, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    aget-object v4, v4, v2

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    iget-object v4, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    aget-object v4, v4, v2

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/entity/q;

    invoke-direct {v5}, Lchat/ola/vn/entity/q;-><init>()V

    iget-object v6, p0, Lchat/ola/vn/network/a/a/ad;->c:Ljava/lang/String;

    iput-object v6, v5, Lchat/ola/vn/entity/q;->b:Ljava/lang/String;

    iget-object v6, p0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    aget-object v6, v6, v2

    iput-object v6, v5, Lchat/ola/vn/entity/q;->c:Ljava/lang/String;

    const-string v6, "1"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    const-string v6, "1"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v6

    iput v6, v5, Lchat/ola/vn/entity/q;->d:I

    :cond_0
    const-string v6, "2"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1

    const-string v6, "2"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v6

    iput v6, v5, Lchat/ola/vn/entity/q;->e:I

    :cond_1
    const-string v6, "liked"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    const-string v6, "liked"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v6

    int-to-short v6, v6

    iput-short v6, v5, Lchat/ola/vn/entity/q;->f:S

    :cond_2
    const-string v6, "likers"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    const-string v6, "likers"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_3

    new-array v7, v6, [Ljava/lang/String;

    iput-object v7, v5, Lchat/ola/vn/entity/q;->a:[Ljava/lang/String;

    const/4 v7, 0x0

    :goto_1
    if-ge v7, v6, :cond_3

    iget-object v8, v5, Lchat/ola/vn/entity/q;->a:[Ljava/lang/String;

    invoke-virtual {v4, v7}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v8, v7

    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    :cond_3
    if-nez v3, :cond_4

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    :cond_4
    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_5
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_0

    :cond_6
    invoke-static {v3}, Lchat/ola/vn/r/a/e;->f(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_7
    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method
