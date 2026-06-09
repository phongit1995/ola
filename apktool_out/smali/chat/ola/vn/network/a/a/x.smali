.class public Lchat/ola/vn/network/a/a/x;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/u;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Lchat/ola/vn/p/l;

.field private d:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-object p1, p0, Lchat/ola/vn/network/a/a/x;->d:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/x;->b([B)Lchat/ola/vn/entity/u;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/network/a/a/x;->d:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    if-nez v1, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "rss/get/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lchat/ola/vn/network/a/a/x;->d:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3, v0, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v1

    return-object v1

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    const-string v3, "rss/get"

    invoke-static {v1, v3, v0, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/u;)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/x;->c:Lchat/ola/vn/p/l;

    invoke-interface {v0, p1}, Lchat/ola/vn/p/l;->a(Lchat/ola/vn/entity/u;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/x;->b(Ljava/lang/String;)V

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/p/l;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/x;->c:Lchat/ola/vn/p/l;

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/u;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/x;->a(Lchat/ola/vn/entity/u;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/u;
    .locals 10

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-wide/16 v1, 0x0

    const-string v3, "type"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_0

    const-string v3, "type"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :goto_0
    packed-switch v3, :pswitch_data_0

    const-string v3, "title"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, "title"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_1
    move-object v3, v0

    :goto_1
    const-string v5, "content"

    invoke-virtual {p1, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    const-string v5, "content"

    invoke-virtual {p1, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_2

    :cond_2
    move-object v5, v0

    :goto_2
    const-string v6, "thumbCode"

    invoke-virtual {p1, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    const-string v6, "thumbCode"

    invoke-virtual {p1, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    goto :goto_3

    :cond_3
    move-object v6, v0

    :goto_3
    invoke-static {v6}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v7, :cond_4

    :try_start_1
    invoke-static {v5}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v6, v7

    :catch_0
    :cond_4
    :try_start_2
    const-string v7, "meId"

    invoke-virtual {p1, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_5

    const-string v1, "meId"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    :cond_5
    const-string v7, "noLikes"

    invoke-virtual {p1, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_6

    const-string v7, "noLikes"

    invoke-virtual {p1, v7}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v7

    goto :goto_4

    :cond_6
    const/4 v7, 0x0

    :goto_4
    const-string v8, "liked"

    invoke-virtual {p1, v8}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_7

    const-string v8, "liked"

    invoke-virtual {p1, v8}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v8

    goto :goto_5

    :cond_7
    const/4 v8, 0x0

    :goto_5
    const-string v9, "noComments"

    invoke-virtual {p1, v9}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_8

    const-string v4, "noComments"

    invoke-virtual {p1, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    :cond_8
    new-instance p1, Lchat/ola/vn/entity/u;

    invoke-direct {p1}, Lchat/ola/vn/entity/u;-><init>()V

    iget-object v9, p0, Lchat/ola/vn/network/a/a/x;->d:Ljava/lang/String;

    invoke-virtual {p1, v9}, Lchat/ola/vn/entity/u;->d(Ljava/lang/String;)V

    invoke-virtual {p1, v3}, Lchat/ola/vn/entity/u;->a(Ljava/lang/String;)V

    invoke-virtual {p1, v5}, Lchat/ola/vn/entity/u;->b(Ljava/lang/String;)V

    invoke-virtual {p1, v6}, Lchat/ola/vn/entity/u;->c(Ljava/lang/String;)V

    invoke-virtual {p1, v1, v2}, Lchat/ola/vn/entity/u;->a(J)V

    invoke-virtual {p1, v7}, Lchat/ola/vn/entity/u;->b(I)V

    invoke-virtual {p1, v8}, Lchat/ola/vn/entity/u;->a(Z)V

    invoke-virtual {p1, v4}, Lchat/ola/vn/entity/u;->a(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-object p1

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :pswitch_0
    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public b(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p1, ""

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/x;->c:Lchat/ola/vn/p/l;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p1}, Lchat/ola/vn/p/l;->a(SLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
