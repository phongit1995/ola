.class public Lchat/ola/vn/network/a/a/ab;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Ljava/util/List<",
        "Lchat/ola/vn/entity/l;",
        ">;>;"
    }
.end annotation


# instance fields
.field private c:Lchat/ola/vn/p/n;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ab;->d:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ab;->e:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ab;->g:Ljava/util/List;

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ab;->e:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/network/a/a/ab;->d:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/network/a/a/ab;->e:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/network/a/a/ab;->g:Ljava/util/List;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_0

    sget-object p2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, p2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "http"

    invoke-virtual {p2, p3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    const-string p2, "json/"

    invoke-virtual {p1, p2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result p2

    if-lez p2, :cond_0

    const-string p2, "json/"

    invoke-virtual {p1, p2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result p2

    add-int/lit8 p2, p2, 0x5

    invoke-virtual {p1, p2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/network/a/a/ab;->e:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ab;->b([B)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/ab;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/network/a/a/ab;->e:Ljava/lang/String;

    invoke-static {v0, v2, v1}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    const-string v2, "gallery"

    invoke-static {v0, v2, v1}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public a(Lchat/ola/vn/p/n;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ab;->c:Lchat/ola/vn/p/n;

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ab;->a(Ljava/util/List;)V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    :try_start_0
    const-string v0, "cats"

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/a/a/ab;->c:Lchat/ola/vn/p/n;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ab;->d:Ljava/lang/String;

    invoke-interface {v0, p1, v1}, Lchat/ola/vn/p/n;->a(Ljava/util/List;Ljava/lang/String;)V

    return-void

    :cond_0
    const-string v0, "folders"

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/network/a/a/ab;->c:Lchat/ola/vn/p/n;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ab;->e:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/ab;->d:Ljava/lang/String;

    invoke-interface {v0, v1, p1, v2}, Lchat/ola/vn/p/n;->a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_1
    iget-object p1, p0, Lchat/ola/vn/network/a/a/ab;->g:Ljava/util/List;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/network/a/a/ab;->c:Lchat/ola/vn/p/n;

    iget-object v0, p0, Lchat/ola/vn/network/a/a/ab;->e:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ab;->g:Ljava/util/List;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/ab;->d:Ljava/lang/String;

    invoke-interface {p1, v0, v1, v2}, Lchat/ola/vn/p/n;->b(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;)V

    :cond_2
    return-void
.end method

.method public b([B)Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v1, "type"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    const-string v1, "morePath"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "morePath"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/network/a/a/ab;->d:Ljava/lang/String;

    goto :goto_0

    :cond_0
    iput-object v0, p0, Lchat/ola/vn/network/a/a/ab;->d:Ljava/lang/String;

    :goto_0
    const-string v1, "cats"

    iget-object v2, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "cats"

    :goto_1
    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    goto :goto_2

    :cond_1
    const-string v1, "folders"

    iget-object v2, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "folders"

    goto :goto_1

    :cond_2
    const-string v1, "files"

    goto :goto_1

    :goto_2
    if-eqz p1, :cond_f

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_f

    const/4 v1, 0x0

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :goto_3
    if-ge v1, v2, :cond_f

    :try_start_1
    const-string v3, "cats"

    iget-object v4, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const/4 v4, 0x5

    if-eqz v3, :cond_7

    invoke-virtual {p1, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    new-instance v5, Lchat/ola/vn/entity/l;

    invoke-direct {v5}, Lchat/ola/vn/entity/l;-><init>()V

    iget-object v6, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    iput-object v6, v5, Lchat/ola/vn/entity/l;->e:Ljava/lang/String;

    iput-short v4, v5, Lchat/ola/vn/entity/l;->i:S

    const-string v4, "name"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    const-string v4, "name"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v5, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    :cond_3
    const-string v4, "path"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    const-string v4, "path"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v5, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    :cond_4
    const-string v4, "coverUrl"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    const-string v4, "coverUrl"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v5, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    :cond_5
    if-nez v0, :cond_6

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v3

    :cond_6
    :goto_4
    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_5

    :cond_7
    const-string v3, "folders"

    iget-object v5, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_c

    invoke-virtual {p1, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    new-instance v5, Lchat/ola/vn/entity/l;

    invoke-direct {v5}, Lchat/ola/vn/entity/l;-><init>()V

    iget-object v6, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    iput-object v6, v5, Lchat/ola/vn/entity/l;->e:Ljava/lang/String;

    iput-short v4, v5, Lchat/ola/vn/entity/l;->i:S

    const-string v4, "name"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_8

    const-string v4, "name"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v5, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    :cond_8
    const-string v4, "path"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_9

    const-string v4, "path"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v5, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    :cond_9
    const-string v4, "coverUrl"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_a

    const-string v4, "coverUrl"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v5, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    :cond_a
    const-string v4, "count"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_b

    const-string v4, "count"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    iput v3, v5, Lchat/ola/vn/entity/l;->g:I

    :cond_b
    if-nez v0, :cond_6

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v3

    goto :goto_4

    :cond_c
    const-string v3, "files"

    iget-object v4, p0, Lchat/ola/vn/network/a/a/ab;->f:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_e

    invoke-virtual {p1, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    new-instance v4, Lchat/ola/vn/entity/i;

    invoke-direct {v4}, Lchat/ola/vn/entity/i;-><init>()V

    const-string v5, "url"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Lchat/ola/vn/entity/i;->j(Ljava/lang/String;)V

    iget-object v3, p0, Lchat/ola/vn/network/a/a/ab;->g:Ljava/util/List;

    if-nez v3, :cond_d

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    iput-object v3, p0, Lchat/ola/vn/network/a/a/ab;->g:Ljava/util/List;

    :cond_d
    iget-object v3, p0, Lchat/ola/vn/network/a/a/ab;->g:Ljava/util/List;

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_5

    :catch_0
    move-exception v3

    :try_start_2
    invoke-virtual {v3}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :cond_e
    :goto_5
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_3

    :catch_1
    :cond_f
    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method
