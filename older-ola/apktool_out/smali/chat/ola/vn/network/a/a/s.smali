.class public Lchat/ola/vn/network/a/a/s;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/f;",
        ">;"
    }
.end annotation


# instance fields
.field public c:Lchat/ola/vn/p/c;

.field private d:J


# direct methods
.method public constructor <init>(JJ)V
    .locals 0

    invoke-direct {p0, p3, p4}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-wide p1, p0, Lchat/ola/vn/network/a/a/s;->d:J

    return-void
.end method

.method private a(Ljava/lang/String;Lorg/json/JSONObject;)Lchat/ola/vn/entity/f;
    .locals 8

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Lchat/ola/vn/entity/f;

    invoke-direct {v1}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object p1, v1, Lchat/ola/vn/entity/f;->k:Ljava/lang/String;

    const-string p1, "id"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_f

    const-string p1, "id"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_5

    :try_start_1
    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lchat/ola/vn/entity/f;->c:J
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    new-instance v2, Lchat/ola/vn/entity/d;

    const-string v3, "viewme"

    invoke-direct {v2, v3}, Lchat/ola/vn/entity/d;-><init>(Ljava/lang/String;)V

    iput-object v2, v1, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    iget-object v2, v1, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {v2, p1}, Lchat/ola/vn/entity/d;->b(Ljava/lang/String;)V

    iget-object p1, v1, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    const-string v2, "comment"

    invoke-virtual {p1, v2}, Lchat/ola/vn/entity/d;->e(Ljava/lang/String;)V

    const-string p1, "content"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "content"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    :cond_0
    const-string p1, "creator"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    const-string p1, "creator"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    iget-object p1, v1, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    iput-object p1, v1, Lchat/ola/vn/entity/f;->q:Ljava/lang/CharSequence;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_5

    :try_start_3
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v2, v1, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    invoke-virtual {p1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/entity/f;->q:Ljava/lang/CharSequence;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :cond_1
    :try_start_4
    const-string p1, "createdDate"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_5

    if-eqz p1, :cond_2

    :try_start_5
    const-string p1, "createdDate"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lchat/ola/vn/entity/f;->g:J
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    :catch_2
    :try_start_6
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, v1, Lchat/ola/vn/entity/f;->g:J

    const/4 p1, 0x0

    sub-long v6, v2, v4

    iput-wide v6, v1, Lchat/ola/vn/entity/f;->h:J

    :cond_2
    const-string p1, "deltaTime"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    if-eqz p1, :cond_3

    :try_start_7
    const-string p1, "deltaTime"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lchat/ola/vn/entity/f;->h:J
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_3

    :catch_3
    :cond_3
    :try_start_8
    const-string p1, "likes"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5

    const/4 v2, 0x0

    if-eqz p1, :cond_4

    :try_start_9
    const-string p1, "likes"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-lez v3, :cond_4

    new-array v4, v3, [Ljava/lang/String;

    iput-object v4, v1, Lchat/ola/vn/entity/f;->i:[Ljava/lang/String;

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_4

    iget-object v5, v1, Lchat/ola/vn/entity/f;->i:[Ljava/lang/String;

    invoke-virtual {p1, v4}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v4
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_4

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :catch_4
    :cond_4
    :try_start_a
    const-string p1, "kulId"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_5

    const-string p1, "kulId"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Short;->valueOf(Ljava/lang/String;)Ljava/lang/Short;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Short;->shortValue()S

    move-result v2

    :cond_5
    if-lez v2, :cond_6

    new-instance p1, Lchat/ola/vn/entity/w;

    invoke-direct {p1}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {p1, v2}, Lchat/ola/vn/entity/w;->a(I)V

    goto :goto_1

    :cond_6
    move-object p1, v0

    :goto_1
    const-string v2, "mediaCode"

    invoke-virtual {p2, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    const-string v2, "mediaCode"

    invoke-virtual {p2, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_7

    if-nez p1, :cond_7

    new-instance p1, Lchat/ola/vn/entity/w;

    invoke-direct {p1}, Lchat/ola/vn/entity/w;-><init>()V

    invoke-virtual {p1, v2}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    move-object v2, v0

    :cond_7
    iput-object v2, v1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    :cond_8
    iput-object p1, v1, Lchat/ola/vn/entity/f;->j:Lchat/ola/vn/entity/w;

    const-string p1, "liked"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_9

    const-string p1, "liked"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/entity/f;->a(S)V

    :cond_9
    const-string p1, "likeCount"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_a

    const-string p1, "likeCount"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p1

    iput p1, v1, Lchat/ola/vn/entity/f;->r:I

    :cond_a
    const-string p1, "noComments"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_b

    const-string p1, "noComments"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p1

    iput p1, v1, Lchat/ola/vn/entity/f;->t:I

    :cond_b
    iget-object p1, v1, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    if-eqz p1, :cond_c

    iget-object p1, v1, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result p1

    if-nez p1, :cond_d

    :cond_c
    iget-object p1, v1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_d

    iget-object p1, v1, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_d

    iget-object p1, v1, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_d

    return-object v0

    :cond_d
    iget-wide p1, v1, Lchat/ola/vn/entity/f;->g:J

    const-wide/16 v2, 0x0

    cmp-long v4, p1, v2

    if-gez v4, :cond_e

    iput-wide v2, v1, Lchat/ola/vn/entity/f;->g:J
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_5

    :cond_e
    return-object v1

    :catch_5
    :cond_f
    return-object v0
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/s;->b([B)Lchat/ola/vn/entity/f;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "me/view/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lchat/ola/vn/network/a/a/s;->d:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v1, v0, v1, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/f;)V
    .locals 3

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p1, Lchat/ola/vn/entity/f;->k:Ljava/lang/String;

    const-string v1, "me"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/network/a/a/s;->c:Lchat/ola/vn/p/c;

    iget-wide v1, p0, Lchat/ola/vn/network/a/a/s;->d:J

    invoke-interface {v0, v1, v2, p1}, Lchat/ola/vn/p/c;->a(JLchat/ola/vn/entity/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/s;->b(Ljava/lang/String;)V

    :catch_0
    :cond_1
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/f;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/s;->a(Lchat/ola/vn/entity/f;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/f;
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "me"

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/network/a/a/s;->a(Ljava/lang/String;Lorg/json/JSONObject;)Lchat/ola/vn/entity/f;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/network/a/a/s;->c:Lchat/ola/vn/p/c;

    iget-wide v0, p0, Lchat/ola/vn/network/a/a/s;->d:J

    invoke-interface {p1, v0, v1}, Lchat/ola/vn/p/c;->a(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
