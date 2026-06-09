.class public Lchat/ola/vn/network/a/a/k;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Ljava/util/List<",
        "Lchat/ola/vn/entity/OlaVenueEntity;",
        ">;>;"
    }
.end annotation


# instance fields
.field private c:Lchat/ola/vn/p/a;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:I

.field private h:I


# direct methods
.method public constructor <init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p5, p6}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p5, 0x0

    iput p5, p0, Lchat/ola/vn/network/a/a/k;->g:I

    iput p5, p0, Lchat/ola/vn/network/a/a/k;->h:I

    iput-object p1, p0, Lchat/ola/vn/network/a/a/k;->d:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/a/a/k;->e:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/a/a/k;->f:Ljava/lang/String;

    iput p2, p0, Lchat/ola/vn/network/a/a/k;->g:I

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/k;->b([B)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/network/a/a/k;->d:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "{\"lat\": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/k;->f:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ", \"lon\": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/k;->e:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ",\"name\": \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/k;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\"} "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "{\"lat\": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/k;->f:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ", \"lon\": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/k;->e:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "}"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :goto_1
    invoke-static {v1}, Lchat/ola/vn/util/m;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget v2, p0, Lchat/ola/vn/network/a/a/k;->g:I

    const/4 v3, 0x1

    if-lez v2, :cond_1

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "aurora/venue/find?info="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "&lmt="

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lchat/ola/vn/network/a/a/k;->g:I

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1, v0, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v1

    return-object v1

    :cond_1
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "aurora/venue/find?info="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1, v0, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    move-exception v1

    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object v0
.end method

.method public a(Lchat/ola/vn/p/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/k;->c:Lchat/ola/vn/p/a;

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/k;->a(Ljava/util/List;)V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/k;->c:Lchat/ola/vn/p/a;

    iget v1, p0, Lchat/ola/vn/network/a/a/k;->h:I

    invoke-interface {v0, p1, v1}, Lchat/ola/vn/p/a;->b(Ljava/util/List;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/k;->b(Ljava/lang/String;)V

    :catch_0
    return-void
.end method

.method public b([B)Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
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

    if-eqz v1, :cond_d

    const-string v1, "code"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_d

    const-string v1, "payload"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_d

    const-string v1, "payload"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    const-string v1, "nextPage"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    const-string v1, "nextPage"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lchat/ola/vn/network/a/a/k;->h:I

    goto :goto_0

    :cond_1
    iput v2, p0, Lchat/ola/vn/network/a/a/k;->h:I

    :goto_0
    const-string v1, "venues"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_d

    const-string v1, "venues"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v1

    :goto_1
    if-ge v2, v1, :cond_d

    new-instance v3, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {v3}, Lchat/ola/vn/entity/OlaVenueEntity;-><init>()V

    invoke-virtual {p1, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    const-string v5, "address"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    const-string v5, "address"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/OlaVenueEntity;->d(Ljava/lang/String;)V

    :cond_2
    const-string v5, "distanceMt"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    const-string v5, "distanceMt"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v5

    invoke-virtual {v3, v5, v6}, Lchat/ola/vn/entity/OlaVenueEntity;->a(J)V

    :cond_3
    const-string v5, "desc"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    const-string v5, "desc"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/OlaVenueEntity;->c(Ljava/lang/String;)V

    :cond_4
    const-string v5, "mediaCode"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    const-string v5, "mediaCode"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/OlaVenueEntity;->e(Ljava/lang/String;)V

    :cond_5
    const-string v5, "name"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_6

    const-string v5, "name"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/OlaVenueEntity;->b(Ljava/lang/String;)V

    :cond_6
    const-string v5, "venueId"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_7

    const-string v5, "venueId"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/OlaVenueEntity;->a(Ljava/lang/String;)V

    :cond_7
    const-string v5, "lon"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_8

    const-string v5, "lon"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/OlaVenueEntity;->f(Ljava/lang/String;)V

    :cond_8
    const-string v5, "lat"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_9

    const-string v5, "lat"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/OlaVenueEntity;->g(Ljava/lang/String;)V

    :cond_9
    const-string v5, "distance"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_a

    const-string v5, "distance"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/OlaVenueEntity;->h(Ljava/lang/String;)V

    :cond_a
    const-string v5, "checkinNo"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_b

    const-string v5, "checkinNo"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4}, Lchat/ola/vn/entity/OlaVenueEntity;->a(I)V

    :cond_b
    if-nez v0, :cond_c

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v4

    :cond_c
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_d
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

    const v0, 0x7f0f0542

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/k;->c:Lchat/ola/vn/p/a;

    const/4 v1, 0x1

    invoke-interface {v0, v1, p1}, Lchat/ola/vn/p/a;->a(SLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
