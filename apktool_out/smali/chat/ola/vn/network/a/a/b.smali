.class public Lchat/ola/vn/network/a/a/b;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Ljava/util/List<",
        "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
        ">;>;"
    }
.end annotation


# instance fields
.field private c:Lchat/ola/vn/p/a;

.field private d:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-object p1, p0, Lchat/ola/vn/network/a/a/b;->d:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/b;->b([B)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    const-string v1, "aurora/action"

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Lchat/ola/vn/p/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/b;->c:Lchat/ola/vn/p/a;

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/b;->a(Ljava/util/List;)V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/b;->c:Lchat/ola/vn/p/a;

    invoke-interface {v0, p1}, Lchat/ola/vn/p/a;->c(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/b;->b(Ljava/lang/String;)V

    :catch_0
    return-void
.end method

.method public b([B)Ljava/util/List;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v1, "apiError"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object v0

    :cond_0
    const-string v1, "code"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_f

    const-string v1, "code"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_f

    const-string v1, "payload"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_f

    const-string v1, "payload"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    const/4 v2, 0x0

    move-object v3, v0

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v1, :cond_e

    :try_start_1
    new-instance v4, Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-direct {v4}, Lchat/ola/vn/entity/OlaCheckInActionEntity;-><init>()V

    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    const-string v6, "id"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1

    const-string v6, "id"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a(Ljava/lang/String;)V

    :cond_1
    const-string v6, "name"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    const-string v6, "name"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b(Ljava/lang/String;)V

    :cond_2
    const-string v6, "icon"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    const-string v6, "icon"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->c(Ljava/lang/String;)V

    :cond_3
    const-string v6, "placeholder"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_4

    const-string v6, "placeholder"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->d(Ljava/lang/String;)V

    :cond_4
    if-nez v3, :cond_5

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6}, Ljava/util/ArrayList;-><init>()V

    move-object v3, v6

    :cond_5
    const-string v6, "allowDefined"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_6

    const-string v6, "allowDefined"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v6

    invoke-virtual {v4, v6}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a(Z)V

    :cond_6
    const-string v6, "items"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    if-eqz v6, :cond_b

    :try_start_2
    const-string v6, "items"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v6

    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7, v2}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v8, 0x0

    :goto_1
    invoke-virtual {v6}, Lorg/json/JSONArray;->length()I

    move-result v9

    if-ge v8, v9, :cond_a

    invoke-virtual {v6, v8}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v9

    new-instance v10, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-direct {v10}, Lchat/ola/vn/entity/OlaCheckInItemEntity;-><init>()V

    const-string v11, "mediaCode"

    invoke-virtual {v9, v11}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_7

    const-string v11, "mediaCode"

    invoke-virtual {v9, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->c(Ljava/lang/String;)V

    :cond_7
    const-string v11, "name"

    invoke-virtual {v9, v11}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_8

    const-string v11, "name"

    invoke-virtual {v9, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->b(Ljava/lang/String;)V

    :cond_8
    const-string v11, "id"

    invoke-virtual {v9, v11}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_9

    const-string v11, "id"

    invoke-virtual {v9, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v10, v9}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->a(Ljava/lang/String;)V

    :cond_9
    invoke-interface {v7, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    :cond_a
    invoke-virtual {v4, v7}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a(Ljava/util/List;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_2

    :catch_0
    move-exception v6

    :try_start_3
    invoke-virtual {v6}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_b
    :goto_2
    const-string v6, "icons"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    if-eqz v6, :cond_d

    :try_start_4
    const-string v6, "icons"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v5

    invoke-virtual {v5}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-lez v6, :cond_d

    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7, v2}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v8, 0x0

    :goto_3
    if-ge v8, v6, :cond_c

    invoke-virtual {v5, v8}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    invoke-interface {v7, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    :cond_c
    invoke-virtual {v4, v7}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b(Ljava/util/List;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_4

    :catch_1
    move-exception v5

    :try_start_5
    invoke-virtual {v5}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_d
    :goto_4
    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    :catch_2
    move-exception p1

    move-object v0, v3

    goto :goto_5

    :cond_e
    move-object v0, v3

    return-object v0

    :catch_3
    move-exception p1

    :goto_5
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_f
    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/c;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f0f053f

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/b;->c:Lchat/ola/vn/p/a;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p1}, Lchat/ola/vn/p/a;->a(SLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
