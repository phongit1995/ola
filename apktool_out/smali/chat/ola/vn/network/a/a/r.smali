.class public Lchat/ola/vn/network/a/a/r;
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

    iput-wide p1, p0, Lchat/ola/vn/network/a/a/r;->d:J

    return-void
.end method

.method private a(Ljava/lang/String;Lorg/json/JSONObject;)Lchat/ola/vn/entity/f;
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Lchat/ola/vn/entity/f;

    invoke-direct {v1}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object p1, v1, Lchat/ola/vn/entity/f;->k:Ljava/lang/String;

    const-string p1, "id"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_a

    const-string p1, "id"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

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

    if-eqz p1, :cond_2

    const-string p1, "content"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string v2, ""

    invoke-static {p1, v2}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {p1}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    invoke-static {p1}, Lchat/ola/vn/util/i;->g(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    iput-object v2, v1, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    goto :goto_0

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    iput-object p1, v1, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    goto :goto_0

    :cond_1
    const-string p1, ""

    iput-object p1, v1, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    :cond_2
    :goto_0
    const-string p1, "creator"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    const-string p1, "creator"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    iget-object p1, v1, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    iput-object p1, v1, Lchat/ola/vn/entity/f;->q:Ljava/lang/CharSequence;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v2, v1, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    invoke-virtual {p1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/entity/f;->q:Ljava/lang/CharSequence;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :cond_3
    :try_start_4
    const-string p1, "mediaCode"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    const-string p1, "mediaCode"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    :cond_4
    const-string p1, "liked"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_5

    const-string p1, "liked"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/entity/f;->a(S)V

    :cond_5
    const-string p1, "likeCount"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    const-string p1, "likeCount"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p1

    iput p1, v1, Lchat/ola/vn/entity/f;->r:I

    :cond_6
    const-string p1, "replyCount"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_7

    const-string p1, "replyCount"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p1

    iput p1, v1, Lchat/ola/vn/entity/f;->t:I

    :cond_7
    iget-object p1, v1, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    if-eqz p1, :cond_8

    iget-object p1, v1, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result p1

    if-nez p1, :cond_9

    :cond_8
    iget-object p1, v1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_9

    iget-object p1, v1, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_9

    iget-object p1, v1, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    if-eqz p1, :cond_9

    return-object v0

    :cond_9
    return-object v1

    :catch_2
    :cond_a
    return-object v0
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/r;->b([B)Lchat/ola/vn/entity/f;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "me/view/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lchat/ola/vn/network/a/a/r;->d:J

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

    iget-object v0, p0, Lchat/ola/vn/network/a/a/r;->c:Lchat/ola/vn/p/c;

    iget-wide v1, p0, Lchat/ola/vn/network/a/a/r;->d:J

    invoke-interface {v0, v1, v2, p1}, Lchat/ola/vn/p/c;->a(JLchat/ola/vn/entity/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/r;->b(Ljava/lang/String;)V

    :catch_0
    :cond_1
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/f;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/r;->a(Lchat/ola/vn/entity/f;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/f;
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "me"

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/network/a/a/r;->a(Ljava/lang/String;Lorg/json/JSONObject;)Lchat/ola/vn/entity/f;

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
    iget-object p1, p0, Lchat/ola/vn/network/a/a/r;->c:Lchat/ola/vn/p/c;

    iget-wide v0, p0, Lchat/ola/vn/network/a/a/r;->d:J

    invoke-interface {p1, v0, v1}, Lchat/ola/vn/p/c;->a(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
